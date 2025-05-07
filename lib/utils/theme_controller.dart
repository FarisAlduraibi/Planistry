import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Create a global theme controller as a singleton
class ThemeController {
  static final ThemeController _instance = ThemeController._internal();

  factory ThemeController() => _instance;

  ThemeController._internal();

  // ValueNotifier to notify listeners when theme changes
  ValueNotifier<bool> isDarkMode = ValueNotifier<bool>(false);

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool('darkMode') ?? false;
  }

  void toggleTheme(bool value) {
    isDarkMode.value = value;
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('darkMode', value);
    });
  }
}