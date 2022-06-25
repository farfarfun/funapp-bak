import 'package:flutter/material.dart';
import 'package:noteapp/page/route.dart';
import 'package:noteapp/tiktok/views/setting.dart';

//
void main() {
  //runApp(const HomePageDetail());
  //runApp(const HomePageDetail());
  initSettings().then((accentColor) {
    runApp(RouteDetails());
  });
//  runApp(RouteDetails());
}
