import 'package:flutter_client/store/grpc_controller.dart';
import 'package:flutter_client/store/microphone_and_speaker_controller.dart';
import 'package:get/get.dart';

final microphoneAndSpeakerController =
    Get.put(MicrophoneAndSpeakerController());
final grpcController = Get.put(GrpcControllr());

void my_global_init() {
  microphoneAndSpeakerController.recorder.initialize();
  microphoneAndSpeakerController.player.initialize();
}
