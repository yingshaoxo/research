# flutter_client

A new Flutter project.

## Env

```bash
brew install protobuf && protoc --version

dart pub global activate protoc_plugin
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

## Regenerate protocals
```bash
mkdir -p lib/src/generated
# protoc --dart_out=grpc:lib/src/generated --proto_path ../protocols ../protocols/helloworld.proto
protoc --dart_out=grpc:lib/src/generated --proto_path ../protocols helloworld.proto
```