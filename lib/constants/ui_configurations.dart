import 'package:flutter/material.dart';
import 'colors.dart';

class UIConfigurations {
  const UIConfigurations._();

  static const double elevation = 10;

  static const BorderRadius appBarBorderRadius =
      BorderRadius.all(Radius.circular(10.0));
  static const BorderRadius smallCardBorderRadius =
      BorderRadius.all(Radius.circular(15.0));
  static const BorderRadius bgCardBorderRadius =
      BorderRadius.all(Radius.circular(20.0));

  static Widget spaceTop(Size size) => SizedBox(height: size.height / 10);
  static Widget spaceBottom(Size size) => SizedBox(height: size.height / 15);

  static EdgeInsets margin(
          {required double horizontal, required double vertical}) =>
      EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);

  static const IconThemeData darkIconTheme =
      IconThemeData(color: MyColors.lightForeground);
  static const IconThemeData lightIconTheme =
      IconThemeData(color: MyColors.selectedColor);

  static const List<BoxShadow> lightShadow = [
    BoxShadow(
        color: MyColors.lightShadowColor, offset: Offset(4, 4), blurRadius: 15)
  ];
  static const List<BoxShadow> darkShadow = [
    BoxShadow(
        color: MyColors.darkShadowColor, offset: Offset(4, 4), blurRadius: 15)
  ];
}
