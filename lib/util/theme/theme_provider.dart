import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) => ThemeNotifier());

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.dark) {
    _loadTheme();
  }

  static const String _themeKey = 'theme_mode';

  // ignore: deprecated_member_use
  final brightness = SchedulerBinding.instance.window.platformBrightness;

  bool get isDarkMode => state == ThemeMode.dark;

  void setLightMode() {
    _setTheme(ThemeMode.light);
  }

  void setDarkMode() {
    _setTheme(ThemeMode.dark);
  }

  void setSystemMode() {
    _setTheme(ThemeMode.system);
  }

  void updateThemeMode(ThemeMode? themeMode) {
    if (themeMode == null || themeMode == state) return;
    _setTheme(themeMode);
  }

  void toggleTheme() {
    _setTheme(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  void _setTheme(ThemeMode themeMode) {
    state = themeMode;
    _saveTheme(themeMode);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(_themeKey);
    if (savedTheme != null) {
      state = ThemeMode.values.firstWhere(
        (e) => e.toString() == savedTheme,
        orElse: () => ThemeMode.dark,
      );
    }
  }

  Future<void> _saveTheme(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, themeMode.toString());
  }
}
