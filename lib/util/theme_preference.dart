import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  // ignore: constant_identifier_names
  static const THEME_KEY = "theme_key";

  setThemeMode(ThemeMode themeMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(THEME_KEY, themeMode.toString());
  }

  Future<ThemeMode> getThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? themeMode = prefs.getString(THEME_KEY);
    if (themeMode == ThemeMode.light.toString()) {
      return ThemeMode.light;
    } else if (themeMode == ThemeMode.dark.toString()) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }
}
