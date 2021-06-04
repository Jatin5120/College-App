import 'package:flutter/material.dart';
import 'colors.dart';

class UIConfigurations {
  const UIConfigurations._();

  static const double elevation = 10;

  static BorderRadius appBarBorderRadius = BorderRadius.circular(10);
  static BorderRadius smallCardBorderRadius = BorderRadius.circular(15);
  static BorderRadius bgCardBorderRadius = BorderRadius.circular(20);

  static Widget spaceTop(Size size) => SizedBox(height: size.height / 10);
  static Widget spaceBottom(Size size) => SizedBox(height: size.height / 15);

  static const EdgeInsets margin = EdgeInsets.all(20.0);

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
