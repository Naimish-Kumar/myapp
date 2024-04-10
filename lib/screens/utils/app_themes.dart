import 'package:flutter/material.dart';

class AppThemes {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF5B0E2D),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Color(0xFF5B0E2D), // dark purple
      iconTheme: IconThemeData(color: Colors.white),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFFE53935), // red
      textTheme: ButtonTextTheme.primary,
    ),
    iconTheme: const IconThemeData(color: Color(0xFF5B0E2D)), // dark purple
    textTheme: const TextTheme(
      headline1: TextStyle(color: Color(0xFF5B0E2D)), // dark purple
      bodyText1: TextStyle(color: Colors.black),
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: const Color(0xFFE53935))
        .copyWith(background: Colors.white),
    // Add other properties as needed
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF1A237E), // bright red
    backgroundColor: const Color(0xFF121212), // dark background
    scaffoldBackgroundColor: const Color(0xFF121212), // dark background
    appBarTheme: const AppBarTheme(
      color: Color(0xFF1A237E), // dark blue
      iconTheme: IconThemeData(color: Colors.white),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFFB71C1C), // bright red
      textTheme: ButtonTextTheme.primary,
    ),
    iconTheme: const IconThemeData(color: Color(0xFF1A237E)), // dark blue
    textTheme: const TextTheme(
      headline1: TextStyle(color: Color(0xFF1A237E)), // dark blue
      bodyText1: TextStyle(color: Colors.white),
    ),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFFB71C1C)),
    // Add other properties as needed
  );
}
