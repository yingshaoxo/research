use tonic::{transport::Server, Request, Response, Status};

use hello_world::greeter_server::{Greeter, GreeterServer};
use hello_world::{Empty, HelloReply, HelloRequest, VoiceReply, VoiceRequest};

pub mod hello_world {
    tonic::include_proto!("helloworld"); //This is the package name?
}

use futures::stream::StreamExt;
use std::pin::Pin;
use tokio::sync::broadcast;
use tokio::sync::mpsc;
// use std::sync::Arc;
// use tokio::sync::Mutex;
use tokio_stream::wrappers::BroadcastStream;
use tokio_stream::wrappers::ReceiverStream;
use tokio_stream::Stream;

use rawsample::{SampleFormat, SampleReader, SampleWriter};

// #[derive(Debug, Default)]
#[derive(Debug)]
pub struct MyGreeter {
    mpsc_sender: mpsc::Sender<VoiceReply>,
    // broadcast_receiver: broadcast::Receiver<VoiceReply>,
    broadcast_sender: broadcast::Sender<VoiceReply>,
    //use Arc<Mutex<T>> to share variables across threads
}

#[tonic::async_trait]
impl Greeter for MyGreeter {
    async fn say_hello(
        &self,
        request: Request<HelloRequest>,
    ) -> Result<Response<HelloReply>, Status> {
        println!("Got a request: {:?}", request);

        let reply = hello_world::HelloReply {
            message: format!("Hello {}!", request.into_inner().name).into(),
        };

        Ok(Response::new(reply))
    }

    async fn send_voice(
        &self,
        request: Request<tonic::Streaming<VoiceRequest>>,
    ) -> Result<Response<Empty>, Status> {
        println!("\n\ngot voice: {:?}", request);

        let mut stream = request.into_inner();
        while let Some(data) = stream.next().await {
            // println!("got data: {:?}", data);
            let data = data.expect("error for data");
            self.mpsc_sender
                .send(VoiceReply {
                    uuid: data.uuid,
                    timestamp: data.timestamp,
                    voice: data.voice,
                })
                .await
                .expect("sender: it should voice to receiver sent successfully");
        }

        let reply = hello_world::Empty {};
        Ok(Response::new(reply))
    }

    type GetVoiceStream =
        Pin<Box<dyn Stream<Item = Result<VoiceReply, Status>> + Send + Sync + 'static>>;

    async fn get_voice(
        &self,
        request: Request<Empty>,
    ) -> Result<Response<Self::GetVoiceStream>, Status> {
        println!("\n\nrequest voice: {:?}", request);
        // let Empty {} = request.into_inner();

        let broadcast_receiver = self.broadcast_sender.subscribe();

        let stream = BroadcastStream::new(broadcast_receiver)
            .filter_map(|res| async move { res.ok() })
            .map(Ok);
        let stream: Self::GetVoiceStream = Box::pin(stream);
        let res = Response::new(stream);

        Ok(res)
    }
}

async fn get_float_vector_samples_from_bytes_samples(bytes: &[u8]) -> Vec<f32> {
    // let mut reader = SampleReader::new(bytes);
    // let mut samples = Vec::new();
    // while let Some(sample) = reader.next().await {
    //     samples.push(sample.unwrap());
    // }
    // samples
    let mut values = Vec::new();
    let mut slice: &[u8] = &bytes;
    // read the raw bytes back as samples into the new vec
    f32::read_all_samples(&mut slice, &mut values, &SampleFormat::S16LE).unwrap();
    values
}

async fn add_float_vector_samples_togather(
    vector_signal1: Vec<f32>,
    vector_signal2: Vec<f32>,
) -> Vec<f32> {
    if vector_signal1.len() != vector_signal2.len() {
        return vector_signal1;
    }

    let mut vector_signal_merged = Vec::new();

    for i in 0..vector_signal1.len() {
        vector_signal_merged.push(vector_signal1[i] + vector_signal2[i]);
    }

    vector_signal_merged
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let (mpsc_sender, mpsc_receiver): (mpsc::Sender<VoiceReply>, mpsc::Receiver<VoiceReply>) =
        mpsc::channel(32); //A multi-producer, single-consumer queue for sending values across asynchronous tasks.
    let (broadcast_sender, mut _broadcast_receiver) = broadcast::channel(32); //A multi-producer, multi-consumer broadcast queue. Each sent value is seen by all consumers.

    let another_broadcast_sender = broadcast::Sender::clone(&broadcast_sender);

    tokio::spawn(async move {
        let mut mpsc_receiver_stream = ReceiverStream::new(mpsc_receiver);

        while let Some(data) = mpsc_receiver_stream.next().await {
            // println!("got data: {:?}", data);
            broadcast_sender
                .send(VoiceReply {
                    uuid: data.uuid,
                    timestamp: data.timestamp,
                    voice: data.voice,
                })
                .expect("sender: it should voice to receiver sent successfully");
        }
    });

    let address_string = "0.0.0.0:40051";
    let addr = address_string.parse()?;

    let greeter = MyGreeter {
        mpsc_sender: mpsc_sender,
        broadcast_sender: another_broadcast_sender,
    };

    println!("Server is running on http://{} ...", address_string);

    Server::builder()
        .add_service(GreeterServer::new(greeter))
        .serve(addr)
        .await?;

    Ok(())
}
