import 'package:club_house/store/grpc_controller.dart';
import 'package:club_house/store/microphone_and_speaker_controller.dart';
import 'package:club_house/store/variable_controller.dart';
import 'package:club_house/utils.dart';
import 'package:get/get.dart';

final microphoneAndSpeakerController =
    Get.put(MicrophoneAndSpeakerController());
final grpcController = Get.put(GrpcControllr());
final variableController = Get.put(VariableControllr());

Future<void> myGlobalInitFunction() async {
  variableController.ourUUID = await getUniqueDeviceId();
  microphoneAndSpeakerController.recorder.initialize();
  microphoneAndSpeakerController.player.initialize();
}
