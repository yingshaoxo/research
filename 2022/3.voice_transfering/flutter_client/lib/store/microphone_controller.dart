import 'dart:async';
import 'dart:core';
import 'dart:math';

import 'package:flutter_client/store/global_controller_variables.dart';
import 'package:get/get.dart';
import 'package:mic_stream/mic_stream.dart';
import 'package:sound_stream/sound_stream.dart';

class MicrophoneControllr extends GetxController {
  // final Rx<BalanceObject> currentBalanceObject =
  //     BalanceObject(userId: '', name: '', balance: 0).obs;

  // final RxList<OneStockOfUs> stockListOwnedByUser = RxList<OneStockOfUs>();

  final Rx<bool> isRecording = false.obs;

  // final AUDIO_FORMAT = AudioFormat.ENCODING_PCM_16BIT;
  final RecorderStream recorder = RecorderStream();
  final PlayerStream player = PlayerStream();

  Stream? recorderStream;

  Future<void> initilizeFunction() async {}

  Future<bool> startListening() async {
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
        await grpcController.sendVoiceDataOut(recorderStream);
      } on Exception catch (_) {
        print('service is not avaliable');
      }
    }();

    print("STARRT LISTENING");

    return true;
  }

  bool stopListening() {
    if (!isRecording.value) return false;

    () async {
      if (isRecording.value) {
        recorder.stop();
      }
      // grpcController.shutdownTheChannel();
    }();

    print("STOP LISTENING");

    return true;
  }
}
