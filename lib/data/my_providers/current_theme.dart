import 'package:college_app/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrentTheme extends ChangeNotifier {
  CurrentTheme();

  ThemeMode currentThemeMode = ThemeMode.system;
  String currentTheme = '${ThemeMode.system}';
  Color activeColor = MyColors.lightForeground;
  Color activeBgColor = MyColors.darkForeground;

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
    activeColor = currentThemeMode == ThemeMode.dark
        ? MyColors.darkForeground
        : currentThemeMode == ThemeMode.light
            ? MyColors.lightForeground
            : SchedulerBinding.instance!.window.platformBrightness ==
                    Brightness.dark
                ? MyColors.darkForeground
                : MyColors.lightForeground;
    activeBgColor = currentThemeMode == ThemeMode.dark
        ? MyColors.lightForeground
        : currentThemeMode == ThemeMode.light
            ? MyColors.selectedColor
            : SchedulerBinding.instance!.window.platformBrightness ==
                    Brightness.dark
                ? MyColors.lightForeground
                : MyColors.selectedColor;
    print("CurrenThemeMode : $currentThemeMode");
    notifyListeners();
  }

  setTheme(ThemeMode themeMode) async {
    prefs = await SharedPreferences.getInstance();
    this.currentThemeMode = themeMode;
    activeColor = currentThemeMode == ThemeMode.dark
        ? MyColors.darkForeground
        : currentThemeMode == ThemeMode.light
            ? MyColors.lightForeground
            : SchedulerBinding.instance!.window.platformBrightness ==
                    Brightness.dark
                ? MyColors.darkForeground
                : MyColors.lightForeground;
    activeBgColor = currentThemeMode == ThemeMode.dark
        ? MyColors.lightForeground
        : currentThemeMode == ThemeMode.light
            ? MyColors.selectedColor
            : SchedulerBinding.instance!.window.platformBrightness ==
                    Brightness.dark
                ? MyColors.lightForeground
                : MyColors.selectedColor;
    prefs.setString('currentTheme', '${this.currentThemeMode}');
    print("Changed CurrenThemeMode : $currentThemeMode");
    notifyListeners();
  }
}

/*

currentTheme.currentThemeMode ==
      ThemeMode.dark
  ? MyColors.lightForeground
  : currentTheme.currentThemeMode ==
          ThemeMode.light
      ? MyColors.selectedColor
      : MediaQuery.of(context)
                  .platformBrightness ==
              Brightness.dark
          ? MyColors.lightForeground
          : MyColors.selectedColor

 */
