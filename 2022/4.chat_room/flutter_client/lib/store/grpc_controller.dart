import 'dart:core';
import 'dart:typed_data';

import 'package:club_house/src/generated/helloworld.pbgrpc.dart';
import 'package:club_house/store/global_controller_variables.dart';
import 'package:club_house/utils.dart';
import 'package:get/get.dart';
import 'package:grpc/grpc.dart';

const hostIPAddress = "10.0.2.2";
// const hostIPAddress = "192.168.50.189";
const portNumber = 40051;

class GrpcControllr extends GetxController {
  ClientChannel sendingChannel = ClientChannel(
    hostIPAddress,
    port: portNumber,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  ClientChannel receivingChannel = ClientChannel(
    hostIPAddress,
    port: portNumber,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );

  void recreateSendingChannel() {
    sendingChannel = ClientChannel(
      hostIPAddress,
      port: portNumber,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
  }

  void recreateReceivingChannel() {
    receivingChannel = ClientChannel(
      hostIPAddress,
      port: portNumber,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
  }

  ClientChannel getATempraryChannel() {
    return ClientChannel(
      hostIPAddress,
      port: portNumber,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
  }

  Future<void> test() async {
    final stub = GreeterClient(sendingChannel);
    final response = await stub.sayHello(HelloRequest()..name = 'you');
    print('Greeter client received: ${response.message}');
    await sendingChannel.shutdown();
  }

  Stream<VoiceRequest> getNewVoiceStreamForUpload(Stream stream) async* {
    await for (final value in stream) {
      VoiceRequest voiceRequest = VoiceRequest()..voice = value.cast<int>();
      voiceRequest.uuid = variableController.ourUUID;
      voiceRequest.timestamp = getCurrentTimeInMilliseconds();
      // print(voiceRequest.timestamp);
      yield voiceRequest;
    }
  }

  Future<void> sendVoiceDataOut(Stream? stream) async {
    if (stream == null) {
      return;
    }

    Stream<VoiceRequest> newStream = getNewVoiceStreamForUpload(stream);

    final stub = GreeterClient(sendingChannel);
    final response = await stub.sendVoice(newStream);
    // print('Greeter client received: ${response}');
    // SystemChannels.platform.invokeMethod('SystemNavigator.pop'); // exit app
  }

  Future<void> getVoiceDataFromService() async {
    final stub = GreeterClient(receivingChannel);

    // await microphoneAndSpeakerController.player.start();

    final response = stub.getVoice(Empty());
    response.listen((VoiceReply voiceResponse) {
      () async {
        // print(voiceResponse);
        microphoneAndSpeakerController.player
            .writeChunk(Uint8List.fromList(voiceResponse.voice));
      }();
      // print('Greeter client received: ${voiceResponse.voice}');
    });

    microphoneAndSpeakerController.isReceiving.trigger(true);
  }

  Future<void> shutdownSendingChannel() async {
    await sendingChannel.shutdown();
    recreateSendingChannel();
    microphoneAndSpeakerController.isRecording.trigger(false);
  }

  Future<void> shutdownReceivingChannel() async {
    await receivingChannel.shutdown();
    recreateReceivingChannel();
    microphoneAndSpeakerController.isReceiving.trigger(false);
  }

  Future<List<String>> getCurrentUserUUIDlist() async {
    final temporaryChannel = getATempraryChannel();
    final stub = GreeterClient(temporaryChannel);
    final response = await stub.getCurrentUsersUUID(Empty());
    print('Greeter client received: ${response.uuid}');
    await temporaryChannel.shutdown();
    return response.uuid;
  }

  Future<void> startSpeaking() async {
    final temporaryChannel = getATempraryChannel();
    final stub = GreeterClient(temporaryChannel);
    final response = await stub.startSpeaking(
        StartSpeakingRequest()..uuid = variableController.ourUUID);
    await temporaryChannel.shutdown();
  }

  Future<void> stopSpeaking() async {
    final temporaryChannel = getATempraryChannel();
    final stub = GreeterClient(temporaryChannel);
    final response = await stub
        .stopSpeaking(StopSpeakingRequest()..uuid = variableController.ourUUID);
    await temporaryChannel.shutdown();
  }
}
