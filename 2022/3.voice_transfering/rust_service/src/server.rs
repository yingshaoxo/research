use tonic::{transport::Server, Request, Response, Status};

use hello_world::greeter_server::{Greeter, GreeterServer};
use hello_world::{Empty, HelloReply, HelloRequest, VoiceReply, VoiceRequest};

pub mod hello_world {
    tonic::include_proto!("helloworld"); //This is the package name?
}

// use tokio_stream::wrappers::ReceiverStream;
// use std::sync::mpsc::{Receiver, Sender};
use async_stream::stream;
use futures_util::stream::StreamExt;
use tokio::sync::broadcast;
use tokio_stream::wrappers::BroadcastStream;

#[derive(Debug, Default)]
pub struct MyGreeter {
    // sender: Sender<VoiceReply>,
// receiver: Receiver<VoiceReply>,
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
        println!("Got a request: {:?}", request);

        let reply = hello_world::Empty {};

        Ok(Response::new(reply))
    }

    type GetVoiceStream = BroadcastStream<VoiceReply>;

    async fn get_voice(
        &self,
        request: Request<Empty>,
    ) -> Result<Response<Self::GetVoiceStream>, Status> {
        println!("Client connected from: {:?}", request.remote_addr());
        let (tx, mut rx) = broadcast::channel(16);
        let new_rx = BroadcastStream::new(rx);

        let the_stream = stream! {
            // for i in 0..3 {
            //     yield i;
            // }
        };
        // tokio::spawn(async move {
        //     for feature in &features[..] {
        //         if in_range(feature.location.as_ref().unwrap(), request.get_ref()) {
        //             tx.send(Ok(feature.clone())).await.unwrap();
        //         }
        //     }
        // });

        // returning our reciever so that tonic can listen on reciever and send the response to client
        Ok(Response::new(the_stream))
    }
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let address_string = "127.0.0.1:40051";
    let addr = address_string.parse()?;
    let greeter = MyGreeter::default();

    println!("Server is running on http://{} ...", address_string);

    Server::builder()
        .add_service(GreeterServer::new(greeter))
        .serve(addr)
        .await?;

    Ok(())
}
