import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    colorSchemeSeed: Colors.blue,

    scaffoldBackgroundColor: Colors.white,

    appBarTheme: const AppBarTheme(centerTitle: true),

    cardTheme: CardThemeData(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.dark,

    colorSchemeSeed: Colors.blue,

    scaffoldBackgroundColor: const Color(0xff121212),

    appBarTheme: const AppBarTheme(centerTitle: true),

    cardTheme: CardThemeData(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
  );
}
