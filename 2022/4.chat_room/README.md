# rust and flutter grpc test

## generate the code
```bash
cd flutter_client

protoc --dart_out=grpc:lib/src/generated --proto_path ../protocols helloworld.proto

cd ..
```

```bash
cd rust_service

cargo build --bin server

cd ..
```