import 'dart:ui';

import 'package:college_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class MyThemeData {
  const MyThemeData._();

  static ThemeData lightThemeData = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: MyColors.selectedColor,
    accentColor: MyColors.lightAccentColor,
    shadowColor: MyColors.lightShadowColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: MyColors.lightForeground,
      backgroundColor: MyColors.lightSecondaryColor,
      splashColor: MyColors.lightSplashColor,
      elevation: UIConfigurations.elevation,
    ),
    iconTheme: UIConfigurations.lightIconTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: MyColors.lightForeground,
      shadowColor: MyColors.lightShadowColor,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      elevation: UIConfigurations.elevation,
      centerTitle: true,
      iconTheme: UIConfigurations.lightIconTheme,
      actionsIconTheme: UIConfigurations.lightIconTheme,
    ),
    cardTheme: CardTheme(
      color: MyColors.lightForeground,
      elevation: UIConfigurations.elevation,
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: MyColors.selectedColor)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: MyColors.selectedColor,
        textStyle: TextStyle(color: MyColors.lightForeground),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: MyColors.selectedColor,
        side: BorderSide(color: MyColors.selectedColor),
      ),
    ),
    scaffoldBackgroundColor: MyColors.lightBackground,
    textTheme: TextTheme(
      headline1: GoogleFonts.exo(
        color: MyColors.selectedColor,
        fontSize: 81,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
      ),
      headline2: GoogleFonts.exo(
        color: MyColors.selectedColor,
        fontSize: 50,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
      ),
      headline3: GoogleFonts.exo(
        color: MyColors.selectedColor,
        fontSize: 40,
        fontWeight: FontWeight.w400,
      ),
      headline4: GoogleFonts.exo(
        color: MyColors.selectedColor,
        fontSize: 29,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      headline5: GoogleFonts.exo(
        color: MyColors.selectedColor,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      headline6: GoogleFonts.exo(
        color: MyColors.selectedColor,
        fontSize: 17,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      subtitle1: GoogleFonts.exo(
        color: MyColors.selectedColor,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      ),
      subtitle2: GoogleFonts.exo(
        color: MyColors.selectedColor,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      bodyText1: GoogleFonts.quicksand(
        color: MyColors.selectedColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyText2: GoogleFonts.quicksand(
        color: MyColors.selectedColor,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      button: GoogleFonts.quicksand(
        color: MyColors.selectedColor,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
      ),
      caption: GoogleFonts.quicksand(
        color: MyColors.selectedColor,
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      overline: GoogleFonts.quicksand(
        color: MyColors.selectedColor,
        fontSize: 9,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
      ),
    ),
  );

  static ThemeData darkThemeData = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: MyColors.selectedColor,
    accentColor: MyColors.darkAccentColor,
    shadowColor: MyColors.darkShadowColor,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      foregroundColor: MyColors.lightForeground,
      backgroundColor: MyColors.darkSecondaryColor,
      splashColor: MyColors.darkSplashColor,
      elevation: UIConfigurations.elevation,
    ),
    iconTheme: UIConfigurations.darkIconTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: MyColors.darkForeground,
      shadowColor: MyColors.darkShadowColor,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      elevation: UIConfigurations.elevation,
      centerTitle: true,
      iconTheme: UIConfigurations.darkIconTheme,
      actionsIconTheme: UIConfigurations.darkIconTheme,
    ),
    cardTheme: CardTheme(
      color: MyColors.darkForeground,
      elevation: UIConfigurations.elevation,
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(primary: MyColors.lightForeground)),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: MyColors.lightForeground,
        textStyle: TextStyle(color: MyColors.darkForeground),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        primary: MyColors.lightForeground,
        side: BorderSide(color: MyColors.lightForeground),
      ),
    ),
    scaffoldBackgroundColor: MyColors.darkBackground,
    textTheme: TextTheme(
      headline1: GoogleFonts.exo(
        color: MyColors.selectedColor,
        fontSize: 81,
        fontWeight: FontWeight.w300,
        letterSpacing: -1.5,
      ),
      headline2: GoogleFonts.exo(
        color: MyColors.lightForeground,
        fontSize: 50,
        fontWeight: FontWeight.w300,
        letterSpacing: -0.5,
      ),
      headline3: GoogleFonts.exo(
        color: MyColors.lightForeground,
        fontSize: 40,
        fontWeight: FontWeight.w400,
      ),
      headline4: GoogleFonts.exo(
        color: MyColors.lightForeground,
        fontSize: 29,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      headline5: GoogleFonts.exo(
        color: MyColors.lightForeground,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
      headline6: GoogleFonts.exo(
        color: MyColors.lightForeground,
        fontSize: 17,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
      ),
      subtitle1: GoogleFonts.exo(
        color: MyColors.lightForeground,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
      ),
      subtitle2: GoogleFonts.exo(
        color: MyColors.lightForeground,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
      ),
      bodyText1: GoogleFonts.quicksand(
        color: MyColors.lightForeground,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
      ),
      bodyText2: GoogleFonts.quicksand(
        color: MyColors.lightForeground,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
      ),
      button: GoogleFonts.quicksand(
        color: MyColors.lightForeground,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.25,
      ),
      caption: GoogleFonts.quicksand(
        color: MyColors.lightForeground,
        fontSize: 10,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
      ),
      overline: GoogleFonts.quicksand(
        color: MyColors.lightForeground,
        fontSize: 9,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.5,
      ),
    ),
  );
}
