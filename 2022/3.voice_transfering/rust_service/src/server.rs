use tonic::{transport::Server, Request, Response, Status};

use hello_world::greeter_server::{Greeter, GreeterServer};
use hello_world::{Empty, HelloReply, HelloRequest, VoiceReply, VoiceRequest};

pub mod hello_world {
    tonic::include_proto!("helloworld"); //This is the package name?
}

// // use futures_util::stream::StreamExt;
// use async_stream::stream;
// // use std::future;
use std::pin::Pin;
// // use std::task::{Context, Poll};
use tokio::sync::broadcast;
// // use tokio_stream::wrappers::errors::BroadcastStreamRecvError;
use tokio_stream::wrappers::BroadcastStream;
// // use tokio_stream::wrappers::ReceiverStream;
// use tokio_stream::{Stream, StreamExt};
use futures::stream::StreamExt;
use tokio_stream::Stream;
// use futures_core::stream::Stream;
// // use tokio_stream::wrappers::errors::BroadcastStreamRecvError;

// #[derive(Debug, Default)]
#[derive(Debug)]
pub struct MyGreeter {
    // sender: Sender<VoiceReply>,
    // Arc::new(data::load()),
    sender: broadcast::Sender<VoiceReply>,
    receiver: broadcast::Receiver<VoiceReply>,
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

        let mut stream = request.into_inner();
        println!("Got a stream: {:?}", stream);
        while let Some(data) = stream.next().await {
            // println!("data: {:?}", data);
            let data = data.unwrap();
            self.sender
                .send(VoiceReply { voice: data.voice })
                .expect("sender: it should voice to receiver sent successfully");
            // println!("data received: {:?}", data.voice);
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
        println!("\nGot a request for voice sending: {:?}", request);

        let Empty {} = request.into_inner();

        let rx = self.sender.subscribe();
        let stream = BroadcastStream::new(rx)
            .filter_map(|res| async move { res.ok() })
            .map(Ok);
        let stream: Self::GetVoiceStream = Box::pin(stream);
        let res = Response::new(stream);

        Ok(res)

        /*
        let rx = self.sender.subscribe();
        let stream = BroadcastStream::new(rx)
            .filter_map(|item| async move { // ignore receive errors
                item.ok()
            })
            .map(Ok);
        let stream: Self::GetVoiceStream = Box::pin(stream);
        let res = Response::new(stream);
        */

        // let (tx, mut rx) = broadcast::channel(16);
        // let mut newRX = tx.subscribe();
        // let rx_stream = BroadcastStream::new(newRX);

        // fn MyStream(
        //     input: BroadcastStream<VoiceReply>,
        // ) -> impl Stream<Item = Result<VoiceReply, Status>> {
        //     stream! {
        //         for await value in input {
        //             yield
        //             (match value {
        //                 Ok(v) => Ok(v),
        //                 Err(e) => Err(e),
        //             })
        //         }
        //     }
        // }

        // Ok(Response::new(
        //     Box::pin(MyStream(rx_stream)) as Self::GetVoiceStream
        // ))
    }
}

/*
        fn MyStream<S: Stream<Item = Result<VoiceReply, Status>>>(
            input: S,
        ) -> impl Stream<Item = Result<VoiceReply, Status>> {
            stream! {
                for await value in input {
                    yield
                    (match value {
                        Ok(v) => Ok(v),
                        BroadcastStreamRecvError => Ok(value),
                    })
                }
            }
        }

        Ok(Response::new(
            Box::pin(MyStream(rx_stream)) as Self::GetVoiceStream
        ))
*/

/*
        // struct MyStream {
        //     therx: broadcast::Receiver<VoiceReply>,
        // }

        // impl Stream for MyStream {
        //     type Item = Result<VoiceReply, Status>;

        //     fn poll_next(self: Pin<&mut Self>, cx: &mut Context<'_>) -> Poll<Option<Self::Item>> {
        //         return match self.therx.recv().await {
        //             Ok(item) => Poll::Ready(Some(Ok(item))),
        //             Err(item) => Poll::Pending,
        //         };
        //     }
        // }

            Box::pin(MyStream { therx: newRX }) as Self::GetVoiceStream
*/

/*

                // Poll::Ready(None);
                // Poll::Ready(Some());
                // return Poll::Pending;
*/

/*
        // let stream = BroadcastStream::new(rx)
        //     .filter(|event| {
        //         let t = match event {
        //             Ok(val) => true,
        //             Err(e) => false,
        //         };
        //         // future::ready(t)
        //         t
        //     })
        //     .map(|event| match event {
        //         // Ok(item) => item,
        //         // Err(e) => VoiceReply { voice: vec![] },
        //         Ok(item) => item,
        //         Err(BroadcastStreamRecvError) => VoiceReply { voice: vec![] },
        //     });

*/

#[tokio::main]
async fn main() -> Result<(), Box<dyn std::error::Error>> {
    let (tx, mut rx) = broadcast::channel(16);

    let mut tempRx = tx.subscribe();
    tokio::spawn(async move {
        // while let data = tempRx.recv().await {
        //     println!("data: {:?}", data);
        // }
    });

    let address_string = "127.0.0.1:40051";
    let addr = address_string.parse()?;
    // let greeter = MyGreeter::default();
    let greeter = MyGreeter {
        sender: tx,
        receiver: rx,
    };

    println!("Server is running on http://{} ...", address_string);

    Server::builder()
        .add_service(GreeterServer::new(greeter))
        .serve(addr)
        .await?;

    Ok(())
}
