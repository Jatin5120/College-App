import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentTheme extends ChangeNotifier {
  CurrentTheme();

  bool isDark = false;
  bool _isInitialized = false;
  ThemeMode currentThemeMode = ThemeMode.light;

  static late SharedPreferences prefs;

  setPreference() async {
    prefs = await SharedPreferences.getInstance();
    print("Shared Preference Initiated");
    _isInitialized = prefs.containsKey('isDark');
    isDark = prefs.getBool('isDark') ?? false;
    currentThemeMode = _isInitialized
        ? isDark
            ? ThemeMode.dark
            : ThemeMode.light
        : ThemeMode.system;
    print('isDark: $isDark');
    notifyListeners();
  }

  setTheme(ThemeMode themeMode) async {
    prefs = await SharedPreferences.getInstance();
    this.currentThemeMode = themeMode;
    notifyListeners();
  }
}
