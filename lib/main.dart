import 'package:flutter/material.dart';
import 'package:myapp/screens/splash_screen.dart';
import 'package:myapp/screens/utils/app_themes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      home: SplashScreen(),
    );
  }
}
