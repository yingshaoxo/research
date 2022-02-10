import 'dart:async';
import 'dart:core';
import 'dart:math';

import 'package:flutter_client/store/global_controller_variables.dart';
import 'package:get/get.dart';
import 'package:mic_stream/mic_stream.dart';

class MicrophoneControllr extends GetxController {
  // final Rx<BalanceObject> currentBalanceObject =
  //     BalanceObject(userId: '', name: '', balance: 0).obs;

  // final RxList<OneStockOfUs> stockListOwnedByUser = RxList<OneStockOfUs>();

  final Rx<bool> isRecording = false.obs;

  final AUDIO_FORMAT = AudioFormat.ENCODING_PCM_16BIT;

  late int bytesPerSample;
  late int samplesPerSecond;

  int? localMax;
  int? localMin;

  Stream? stream;
  late StreamSubscription listener;

  List<int> visibleSamples = [];
  List<int>? currentSamples = [];

  Future<void> initilizeFunction() async {}

  Future<bool> startListening() async {
    print("STARRT LISTENING");
    if (isRecording.value) return false;
    // if this is the first time invoking the microphone()
    // method to get the stream, we don't yet have access
    // to the sampleRate and bitDepth properties
    print("wait for stream");
    stream = await MicStream.microphone(
        audioSource: AudioSource.DEFAULT,
        sampleRate: 16000,
        channelConfig: ChannelConfig.CHANNEL_IN_MONO,
        audioFormat: AUDIO_FORMAT);
    // after invoking the method for the first time, though, these will be available;
    // It is not necessary to setup a listener first, the stream only needs to be returned first
    print(
        "Start Listening to the microphone, sample rate is ${await MicStream.sampleRate}, bit depth is ${await MicStream.bitDepth}, bufferSize: ${await MicStream.bufferSize}");
    bytesPerSample = ((await MicStream.bitDepth)! / 8).toInt();
    samplesPerSecond = (await MicStream.sampleRate)!.toInt();
    localMax = null;
    localMin = null;

    isRecording.trigger(true);

    visibleSamples = [];
    listener = stream!.listen(_calculateIntensitySamples);

    () async {
      await grpcController.sendVoiceDataOut(stream);
    }();

    return true;
  }

  bool stopListening() {
    if (!isRecording.value) return false;

    print("Stop Listening to the microphone");
    listener.cancel();

    isRecording.trigger(false);
    currentSamples = null;

    return true;
  }

  void _calculateIntensitySamples(samples) {
    //960 is the number of samples in a second
    // print(samples);
    mySampleHandler(samples);

    currentSamples ??= [];
    int currentSample = 0;
    eachWithIndex(samples, (i, int sample) {
      currentSample += sample;
      if ((i % bytesPerSample) == bytesPerSample - 1) {
        currentSamples!.add(currentSample);
        currentSample = 0;
      }
    });

    if (currentSamples!.length >= samplesPerSecond / 10) {
      visibleSamples
          .add(currentSamples!.map((i) => i).toList().reduce((a, b) => a + b));
      localMax ??= visibleSamples.last;
      localMin ??= visibleSamples.last;
      localMax = max(localMax!, visibleSamples.last);
      localMin = min(localMin!, visibleSamples.last);
      currentSamples = [];
      // setState(() {});
    }
  }

  Iterable<T> eachWithIndex<E, T>(
      Iterable<T> items, E Function(int index, T item) f) {
    var index = 0;

    for (final item in items) {
      f(index, item);
      index = index + 1;
    }

    return items;
  }

  void mySampleHandler(List<int> byte) {
    List<int> result = <int>[];
    for (var f in byte) {
      intToByte(result, f);
    }

    print(result);
  }

  void intToByte(List<int> result, int i) {
    result.add(i & 0x00FF);
    result.add((i >> 8) & 0x000000FF);
    result.add((i >> 16) & 0x000000FF);
    result.add((i >> 24) & 0x000000FF);
  }
}
