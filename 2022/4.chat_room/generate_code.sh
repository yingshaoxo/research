cd flutter_client
mkdir -p lib/src/generated
protoc --dart_out=grpc:lib/src/generated --proto_path ../protocols helloworld.proto
cd ..

cd rust_service
cargo build --bin server
cd ..