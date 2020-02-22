import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dash_button_app/screens/main_screen.dart';
import 'package:dash_button_app/util/const.dart';
import 'package:shared/env.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static String _pkg = "dash_button_app";
  static String get pkg => Env.getPackage(_pkg);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: isDark ? Constants.darkPrimary : Constants.lightPrimary,
      statusBarIconBrightness: isDark?Brightness.light:Brightness.dark,
    ));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: isDark ? Constants.darkTheme : Constants.lightTheme,
      home: MainScreen(),
    );
  }
}

