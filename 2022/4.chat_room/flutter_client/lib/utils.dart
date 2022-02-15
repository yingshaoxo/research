import 'dart:io';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fixnum/fixnum.dart';

Future<String> getUniqueDeviceId() async {
  var deviceInfo = DeviceInfoPlugin();
  String? theId = "123e4567-e89b-12d3-a456-426614174000";
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    theId = iosDeviceInfo.identifierForVendor; // unique ID on iOS
  } else {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    theId = androidDeviceInfo.androidId; // unique ID on Android
  }
  return theId!;
}

Int64 getCurrentTimeInMilliseconds() {
  return Int64(DateTime.now().millisecondsSinceEpoch);
}

int getARandomNumber(min, max) {
  return min + Random().nextInt(max - min);
}
