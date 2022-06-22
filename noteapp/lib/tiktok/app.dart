import 'package:flutter/material.dart';
import 'package:noteapp/tiktok/pages/homePage.dart';
import 'package:noteapp/tiktok/style/style.dart';

class TikTokApp extends StatelessWidget {
  String baseUrl;
  TikTokApp(this.baseUrl);

  final ThemeData theme = ThemeData();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tiktok',
      theme: theme.copyWith(
        brightness: Brightness.dark,
        hintColor: Colors.white,
        colorScheme: theme.colorScheme.copyWith(secondary: Colors.white),
        primaryColor: ColorPlate.orange,
        scaffoldBackgroundColor: ColorPlate.back1,
        dialogBackgroundColor: ColorPlate.back2,
        textTheme: const TextTheme(
          bodyText1: StandardTextStyle.normal,
        ),
      ),
      home: HomePage(baseUrl),
    );
  }
}
