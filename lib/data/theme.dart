import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentTheme extends ChangeNotifier {
  CurrentTheme._();

  bool isDark = false;
  // late MyAnimation myAnimation;
  // ThemeData currentThemeData = ThemeData.light();
  static late SharedPreferences prefs;

  setPreference() async {
    prefs = await SharedPreferences.getInstance();
    print("Shared Preference Initiated");
    isDark = prefs.getBool('isDark') ?? false;
    print('isDark: $isDark');
    // myAnimation = MyAnimation(isDark);
    // currentThemeData = isDark ? ThemeData.dark() : ThemeData.light();
    notifyListeners();
  }

  changeTheme() async {
    isDark = !isDark;
    prefs = await SharedPreferences.getInstance();
    print("Theme Changed");
    // currentThemeData = isDark ? ThemeData.dark() : ThemeData.light();
    prefs.setBool('isDark', isDark);
    print('isDark: $isDark');
    notifyListeners();
  }
}
