use tonic::{transport::Server, Request, Response, Status};

use hello_world::greeter_server::{Greeter, GreeterServer};
use hello_world::{
    CurrentUsersUuidReply, Empty, HelloReply, HelloRequest, StartSpeakingRequest,
    StopSpeakingRequest, VoiceReply, VoiceRequest,
};

pub mod hello_world {
    tonic::include_proto!("helloworld"); //This is the package name?
}

use std::sync::Arc;
use tokio::sync::Mutex;

use futures::stream::StreamExt;
use std::pin::Pin;
use tokio::sync::broadcast;
use tokio_stream::wrappers::BroadcastStream;
use tokio_stream::Stream;

use rawsample::{SampleFormat, SampleReader};

#[derive(Debug)]
pub struct User {
    uuid: String,
    timestamp: i64,
}

impl Clone for User {
    fn clone(&self) -> User {
        User {
            uuid: self.uuid.clone(),
            timestamp: self.timestamp,
        }
    }
}

async fn get_timestamp() -> i64 {
    let now = std::time::SystemTime::now();
    let since_epoch = now
        .duration_since(std::time::UNIX_EPOCH)
        .unwrap()
        .as_millis();
    return since_epoch as i64;
}

async fn add_user_only_if_not_exists(users: &mut Arc<Mutex<Vec<User>>>, new_user: User) {
    let mut users = users.lock().await;
    let mut found = false;
    for user in users.iter() {
        if user.uuid == new_user.uuid {
            found = true;
            break;
        }
    }
    if !found {
        users.push(new_user);
    }
}

async fn remove_user_only_if_exists(users: &mut Arc<Mutex<Vec<User>>>, user: User) {
    let mut users = users.lock().await;
    users.retain(|a_user| !(a_user.uuid == user.uuid));
}

async fn update_user_timestamp(users: &mut Arc<Mutex<Vec<User>>>, uuid: String) {
    let mut users = users.lock().await;
    for user in users.iter_mut() {
        if user.uuid == uuid {
            user.timestamp = get_timestamp().await;
            break;
        }
    }
}

async fn filter_out_users_that_do_not_active_for_more_than_x_milliseconds(
    users: &mut Arc<Mutex<Vec<User>>>,
    x: i32,
) {
    let now = get_timestamp().await;

    let mut to_remove = Vec::new();
    for user in users.lock().await.iter_mut() {
        println!("time: {}", now - user.timestamp);
        if (now - user.timestamp) > x.into() {
            to_remove.push(user.uuid.clone());
        }
    }

    users
        .lock()
        .await
        .retain(|user| !to_remove.contains(&user.uuid));
}

// #[derive(Debug, Default)]
#[derive(Debug)]
pub struct MyGreeter {
    current_users: Arc<Mutex<Vec<User>>>,
    broadcast_sender: broadcast::Sender<VoiceReply>,
    // broadcast_receiver: broadcast::Receiver<VoiceReply>,
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
            let mut data = data.expect("error for data");
            data.timestamp = get_timestamp().await; // client's time cannot be trusted

            let new_user = User {
                uuid: data.uuid.clone(),
                timestamp: data.timestamp,
            };
            let mut current_users = self.current_users.clone();
            let the_uuid = data.uuid.clone();
            tokio::spawn(async move {
                add_user_only_if_not_exists(&mut current_users, new_user).await;
                update_user_timestamp(&mut current_users, the_uuid).await;
            });

            self.broadcast_sender
                .send(VoiceReply {
                    uuid: data.uuid,
                    timestamp: data.timestamp,
                    voice: data.voice,
                })
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

    async fn get_current_users_uuid(
        &self,
        request: tonic::Request<Empty>,
    ) -> Result<tonic::Response<CurrentUsersUuidReply>, tonic::Status> {
        println!("\n\nrequest uuid list: {:?}", request);

        let mut current_users = self.current_users.clone();
        filter_out_users_that_do_not_active_for_more_than_x_milliseconds(&mut current_users, 1000)
            .await;

        return Ok(tonic::Response::new(CurrentUsersUuidReply {
            uuid: self
                .current_users
                .lock()
                .await
                .clone()
                .into_iter()
                .map(|user| user.uuid)
                .collect(),
        }));
    }
    async fn start_speaking(
        &self,
        request: tonic::Request<StartSpeakingRequest>,
    ) -> Result<tonic::Response<Empty>, tonic::Status> {
        let the_uuid = request.into_inner().uuid;
        let mut current_users = self.current_users.clone();
        add_user_only_if_not_exists(
            &mut current_users,
            User {
                uuid: the_uuid.clone(),
                timestamp: get_timestamp().await,
            },
        )
        .await;
        update_user_timestamp(&mut current_users, the_uuid).await;
        Ok(Response::new(Empty {}))
    }

    async fn stop_speaking(
        &self,
        request: tonic::Request<StopSpeakingRequest>,
    ) -> Result<tonic::Response<Empty>, tonic::Status> {
        let mut current_users = self.current_users.clone();
        remove_user_only_if_exists(
            &mut current_users,
            User {
                uuid: request.into_inner().uuid,
                timestamp: get_timestamp().await,
            },
        )
        .await;
        Ok(Response::new(Empty {}))
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
    let (broadcast_sender, _broadcast_receiver) = broadcast::channel(32); //A multi-producer, multi-consumer broadcast queue. Each sent value is seen by all consumers.
                                                                          // let another_broadcast_sender = broadcast::Sender::clone(&broadcast_sender);
    let address_string = "0.0.0.0:40051";
    let addr = address_string.parse()?;

    let current_users = Arc::new(Mutex::new(Vec::new()));

    let greeter = MyGreeter {
        current_users: current_users,
        broadcast_sender: broadcast_sender,
        // broadcast_receiver: broadcast_receiver,
    };

    println!("Server is running on http://{} ...", address_string);

    Server::builder()
        .add_service(GreeterServer::new(greeter))
        .serve(addr)
        .await?;

    Ok(())
}
