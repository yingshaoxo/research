import 'dart:core';
import 'package:club_house/store/global_controller_variables.dart';
import 'package:get/get.dart';
import 'package:sound_stream/sound_stream.dart';

class MicrophoneAndSpeakerController extends GetxController {
  final Rx<bool> isRecording = false.obs;
  final Rx<bool> isReceiving = false.obs;

  final RecorderStream recorder = RecorderStream();
  final PlayerStream player = PlayerStream();

  Stream? recorderStream;

  Future<void> initilizeFunction() async {}

  Future<bool> startRecording() async {
    recorder.status.listen((status) {
      if (status == SoundStreamStatus.Playing) {
        isRecording.trigger(true);
      } else {
        isRecording.trigger(false);
      }
    });

    recorderStream = recorder.audioStream
        .asyncMap((event) => List<int>.from(event.buffer.asUint8List()));

    () async {
      await recorder.start();
      try {
        // print("recording started?");
        await grpcController.sendVoiceDataOut(recorderStream);
      } on Exception catch (_) {
        // print('service is not avaliable');
      }
    }();

    print("STARRT LISTENING");

    return true;
  }

  bool stopRecording() {
    if (!isRecording.value) return false;

    () async {
      if (isRecording.value) {
        await recorder.stop();
        await grpcController.shutdownSendingChannel();
      }
    }();

    print("STOP LISTENING");

    return true;
  }

  Future<bool> startSpeaking() async {
    player.status.listen((status) {
      if (status == SoundStreamStatus.Playing) {
        isReceiving.trigger(true);
      } else {
        isReceiving.trigger(false);
      }
    });

    () async {
      await player.start();
      await grpcController.getVoiceDataFromService();
    }();

    print("STARRT speaking");

    return true;
  }

  bool stopSpeaking() {
    if (!isReceiving.value) return false;

    () async {
      if (isReceiving.value) {
        await player.stop();
        await grpcController.shutdownReceivingChannel();
      }
    }();

    print("STOP Speaking");

    return true;
  }
}
