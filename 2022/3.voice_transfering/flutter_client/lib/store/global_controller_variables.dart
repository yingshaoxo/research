import 'package:flutter_client/store/grpc_controller.dart';
import 'package:flutter_client/store/microphone_controller.dart';
import 'package:get/get.dart';

final microphoneController = Get.put(MicrophoneControllr());
final grpcController = Get.put(GrpcControllr());

void my_global_init() {
  microphoneController.recorder.initialize();
  microphoneController.player.initialize();
}
