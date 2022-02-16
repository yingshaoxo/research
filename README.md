# research
Some explorations about everything related to this project.


## I have words to say
Before we get started, there has a thing that we must understand: "we need a plan to achieve our goals".

It is the same for software development.

We need to splits a big project into multiple small parts.

And then according to the list, we implement them one by one.

## Goal
Try to do a lot of experiments to know what kind of library we needed to build each part of the big project.

Once we know how to implement them, we implement them.

After that, we combine those small pieces into one single software.

## Thinking
### round 1
1. we need a backend service for sure
2. we need a frontend UI to display something to our user for sure

### round 2
1. we need to have a real-time data transfer solution for sure
    - from the basic level, it's TCP/IP.
    - for browser, it is webRTC
    - for apps, it is GRPC
    - it depends on what kind of software we want to build

2. we need a UI framework to build the UI
    - it can be vue3, flutter
    - I'll use flutter for this time to simplify my life with `Row/Column` syntax; and also it's good to use with GRPC; and it checks your code before running

3. I do not consider the deploy problem right now

### round 3
1. server-side
    - experiment 1: can grpc work with rust and flutter (rust is not natively support by google grpc)
        - success, see [this](2022/1.tonic+flutter+grpc)
    - ~~experiment 2: can webRTC work with rust and flutter (this can change the way we transfer data)~~

2. ui-side
    - experiment 1: is it good to just use others [repository](https://github.com/PuzzleLeaf/flutter_clubhouse_ui_clone)?
        - temprarily add a flutter houseclub, see [this](2022/2.houseclub_test)
        - it should work if I simplify the whole stuff until one single page (the chat page)

### round 4
1. ui-side
    - experiment 1: can we makde a simple UI that does record and play for the audio stream?
        - yes, we can!
    - experiment 2: can we use flutter to fetch a user's voice and convert it into bytes and sent it out by GRPC
        - yes, we can! see [this](2022/3.voice_transfering/flutter_client)
1. server-side
    - experiment 1: can we receive voice bytes through GRPC, then forward them to other clients?
        - yes, we can! see [this](2022/3.voice_transfering/rust_service)

### round 5
- experiment 1: can we simplify the other's UI repo into a single page, the chat page?
    - yes, we can! see [this](2022/4.chat_room/flutter_client)
- experiment 2: can we map multiple users' audio streams into the UI in real-time? I mean display who is in speaking.
    - working on...

### round 6
1. can we seperate rust code into multiple files?