import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController {
  ThemeController._();

  static final ThemeController instance = ThemeController._();

  static const String _keyTheme = "theme_mode";

  final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.system);

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();

    final mode = prefs.getString(_keyTheme) ?? "system";

    switch (mode) {
      case "light":
        themeMode.value = ThemeMode.light;
        break;

      case "dark":
        themeMode.value = ThemeMode.dark;
        break;

      default:
        themeMode.value = ThemeMode.system;
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();

    switch (mode) {
      case ThemeMode.light:
        await prefs.setString(_keyTheme, "light");
        break;

      case ThemeMode.dark:
        await prefs.setString(_keyTheme, "dark");
        break;

      case ThemeMode.system:
        await prefs.setString(_keyTheme, "system");
        break;
    }

    themeMode.value = mode;
  }
}
