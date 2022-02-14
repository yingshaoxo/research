use tonic::{transport::Server, Request, Response, Status};

use hello_world::greeter_server::{Greeter, GreeterServer};
use hello_world::{Empty, HelloReply, HelloRequest, VoiceReply, VoiceRequest};

pub mod hello_world {
    tonic::include_proto!("helloworld"); //This is the package name?
}

use futures::stream::StreamExt;
use std::pin::Pin;
use tokio::sync::broadcast;
use tokio_stream::wrappers::BroadcastStream;
use tokio_stream::Stream;

// #[derive(Debug, Default)]
#[derive(Debug)]
pub struct MyGreeter {
    sender: broadcast::Sender<VoiceReply>,
    // receiver: broadcast::Receiver<VoiceReply>,
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
            let data = data.expect("error for data");
            self.sender
                .send(VoiceReply { voice: data.voice })
                .expect("sender: it should voice to receiver sent successfully");
        }

        let reply = hello_world::Empty {};
        Ok(Response::new(reply))
    }

    // type GetVoiceStream = <Result<VoiceReply, Status>>;
    type GetVoiceStream =
        Pin<Box<dyn Stream<Item = Result<VoiceReply, Status>> + Send + Sync + 'static>>;

    async fn get_voice(
        &self,
        request: Request<Empty>,
    ) -> Result<Response<Self::GetVoiceStream>, Status> {
        println!("\n\nrequest voice: {:?}", request);
        // let Empty {} = request.into_inner();

        let rx = self.sender.subscribe();
        let stream = BroadcastStream::new(rx)
            .filter_map(|res| async move { res.ok() })
            .map(Ok);
        let stream: Self::GetVoiceStream = Box::pin(stream);
        let res = Response::new(stream);

        Ok(res)
    }
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let (tx, mut _rx) = broadcast::channel(16);

    let address_string = "0.0.0.0:40051";
    let addr = address_string.parse()?;

    let greeter = MyGreeter {
        sender: tx,
        // receiver: rx,
    };

    println!("Server is running on http://{} ...", address_string);

    Server::builder()
        .add_service(GreeterServer::new(greeter))
        .serve(addr)
        .await?;

    Ok(())
}
