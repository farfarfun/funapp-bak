import 'package:flutter/material.dart';
import 'package:funapp/tiktok/pages/home_page.dart';
import 'package:funapp/tiktok/style/style.dart';

/// 创建短视频功能的 Material 应用。
///
/// [baseUrl] 是短视频后端的接口根地址。
class TikTokApp extends StatelessWidget {
  /// 短视频后端的接口根地址。
  String baseUrl;

  /// 使用 [baseUrl] 创建短视频应用。
  TikTokApp(this.baseUrl, {Key? key}) : super(key: key);

  /// 应用基础主题。
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
