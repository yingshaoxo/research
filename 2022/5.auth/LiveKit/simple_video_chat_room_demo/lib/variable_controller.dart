import 'dart:core';
import 'package:get/get.dart';

class VariableControllr extends GetxController {
  // RxList<String> currentUsersUUID = RxList([]);

  RxString url = "".obs;
  RxString token = "".obs;
  RxBool simulcast = true.obs;
}

final variableController = Get.put(VariableControllr());
