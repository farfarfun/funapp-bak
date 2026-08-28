import 'package:flutter/material.dart';
import 'package:funapp/init.dart';
import 'package:funapp/page/route.dart';


//
void main() {
  //runApp(const HomePageDetail());
  //runApp(const HomePageDetail());
  initSettings().then((accentColor) {
    runApp(RouteDetails());
  });
//  runApp(RouteDetails());
}
