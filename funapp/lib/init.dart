import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:funapp/tiktok/data/static_data.dart';

Future<ValueNotifier<Color>> initSettings() async {
  await initDataGenerate();
  await Settings.init(cacheProvider: SharePreferenceCache());
  final _accentColor = ValueNotifier(Colors.blueAccent);
  return _accentColor;
}
