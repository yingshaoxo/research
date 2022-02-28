// Read saved URL and Token
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_video_chat_room_demo/variable_controller.dart';

const _storeKeyUri = 'uri';
const _storeKeyToken = 'token';
const _storeKeySimulcast = 'simulcast';

Future<void> readPrefs() async {
  final prefs = await SharedPreferences.getInstance();

  variableController.url.trigger(prefs.getString(_storeKeyUri) ?? '');
  variableController.token.trigger(prefs.getString(_storeKeyToken) ?? '');
  variableController.simulcast
      .trigger(prefs.getBool(_storeKeySimulcast) ?? true);
}

// Save URL and Token
Future<void> writePrefs() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_storeKeyUri, variableController.url.string);
  await prefs.setString(_storeKeyToken, variableController.token.string);
  await prefs.setBool(_storeKeySimulcast, variableController.simulcast.value);
}
