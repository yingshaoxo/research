cd flutter_client
protoc --dart_out=grpc:lib/src/generated --proto_path ../protocols helloworld.proto
cd ..

cd rust_service
cargo build --bin server
cd ..