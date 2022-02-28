# Live Kit

## set up the server
### generate config file
```bash
docker run --rm -v$PWD:/output livekit/generate --local
```

### start docker
```bash
docker run --rm -p 7880:7880 \
    -p 7881:7881 \
    -p 7882:7882/udp \
    -v $PWD/livekit.yaml:/livekit.yaml \
    livekit/livekit-server \
    --config /livekit.yaml \
    --node-ip 192.168.50.189
```

### generate token
```bash
docker run --rm -e LIVEKIT_KEYS="<api-key>: <api-secret>" \
    livekit/livekit-server create-join-token \
    --room "<room-name>" \
    --identity "<participant-identity>"
```

the `api-key` and `api-secret` is inside of the `config file`: `livekit.yaml`


### test example
https://example.livekit.io/#/

For android emulator: the host ip address should be `10.0.2.2` or `ws://10.0.2.2:7880`