import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:funapp/tiktok/data/static_data.dart';

Future<ValueNotifier<Color>> initSettings() async {
  await Settings.init(cacheProvider: SharePreferenceCache());
  // 旧版本把 SecretKey 明文存入 SharedPreferences；启动时清除遗留值。
  await Settings.setValue<String?>('notetiktok-video-secret-key', null);
  await initDataGenerate();
  final _accentColor = ValueNotifier(Colors.blueAccent);
  return _accentColor;
}
