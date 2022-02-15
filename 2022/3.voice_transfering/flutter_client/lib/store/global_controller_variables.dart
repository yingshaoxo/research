import 'package:flutter_client/store/grpc_controller.dart';
import 'package:flutter_client/store/microphone_and_speaker_controller.dart';
import 'package:flutter_client/store/variable_controller.dart';
import 'package:flutter_client/utils.dart';
import 'package:get/get.dart';

final microphoneAndSpeakerController =
    Get.put(MicrophoneAndSpeakerController());
final grpcController = Get.put(GrpcControllr());
final variableController = Get.put(VariableControllr());

Future<void> my_global_init() async {
  variableController.ourUUID = await getUniqueDeviceId();
  microphoneAndSpeakerController.recorder.initialize();
  microphoneAndSpeakerController.player.initialize();
}
