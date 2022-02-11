import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_client/src/generated/helloworld.pbgrpc.dart';
import 'package:get/get.dart';
import 'package:grpc/grpc.dart';

import 'package:stream_transform/stream_transform.dart';

class GrpcControllr extends GetxController {
  final channel = ClientChannel(
    // '127.0.0.1',
    "10.0.2.2",
    port: 40051,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  Future<void> test() async {
    final stub = GreeterClient(channel);
    final response = await stub.sayHello(HelloRequest()..name = 'you');
    print('Greeter client received: ${response.message}');
    await channel.shutdown();
  }

  Stream<VoiceRequest> getNewVoiceStreamForUpload(Stream stream) async* {
    await for (final value in stream) {
      VoiceRequest voiceRequest = VoiceRequest()..voice = value;
      yield voiceRequest;
    }
  }

  Future<void> sendVoiceDataOut(Stream? stream) async {
    if (stream == null) {
      return;
    }

    Stream<VoiceRequest> newStream = getNewVoiceStreamForUpload(stream);

    final stub = GreeterClient(channel);
    final response = await stub.sendVoice(newStream);
    print('Greeter client received: ${response}');
    // SystemChannels.platform.invokeMethod('SystemNavigator.pop');

    await channel.shutdown();
  }

  Future<void> getVoiceDataFromService() async {
    final stub = GreeterClient(channel);

    final response = stub.getVoice(Empty());
    response.listen((VoiceReply voiceResponse) {
      print('Greeter client received: ${voiceResponse.voice}');
    });

    await channel.shutdown();
  }
}
