import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentTheme extends ChangeNotifier {
  CurrentTheme();

  ThemeMode currentThemeMode = ThemeMode.system;
  String currentTheme = '${ThemeMode.system}';

  static late SharedPreferences prefs;

  setPreference() async {
    prefs = await SharedPreferences.getInstance();
    print("Shared Preference Initiated");
    currentTheme = prefs.getString('currentTheme') ?? '${ThemeMode.system}';
    currentThemeMode = currentTheme == '${ThemeMode.dark}'
        ? ThemeMode.dark
        : currentTheme == '${ThemeMode.light}'
            ? ThemeMode.light
            : ThemeMode.system;
    print("CurrenThemeMode : $currentThemeMode");
    notifyListeners();
  }

  setTheme(ThemeMode themeMode) async {
    prefs = await SharedPreferences.getInstance();
    this.currentThemeMode = themeMode;
    prefs.setString('currentTheme', '${this.currentThemeMode}');
    print("Changed CurrenThemeMode : $currentThemeMode");
    notifyListeners();
  }
}
