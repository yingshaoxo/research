import 'dart:core';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_client/src/generated/helloworld.pbgrpc.dart';
import 'package:flutter_client/store/global_controller_variables.dart';
import 'package:get/get.dart';
import 'package:grpc/grpc.dart';

import 'package:stream_transform/stream_transform.dart';

class GrpcControllr extends GetxController {
  final Rx<bool> isReceiving = false.obs;
  AudioPlayer audioPlayer = AudioPlayer();

  final channel = ClientChannel(
    // '127.0.0.1',
    "10.0.2.2",
    // "192.168.50.189",
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
      VoiceRequest voiceRequest = VoiceRequest()..voice = value.cast<int>();
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

    await microphoneController.player.start();

    final response = stub.getVoice(Empty());
    response.listen((VoiceReply voiceResponse) {
      () async {
        microphoneController.player
            .writeChunk(Uint8List.fromList(voiceResponse.voice));
      }();
      print('Greeter client received: ${voiceResponse.voice}');
    });
  }

  Future<void> shutdownTheChannel() async {
    await channel.shutdown();
  }
}
