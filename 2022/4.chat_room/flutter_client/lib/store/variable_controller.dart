import 'dart:core';
import 'package:cron/cron.dart';
import 'package:get/get.dart';

class VariableControllr extends GetxController {
  String ourUUID = "";
  final cron = Cron();

  RxList<String> currentUsersUUID = RxList([]);
}
