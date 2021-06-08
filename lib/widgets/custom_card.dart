import 'package:college_app/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.child,
    this.borderRadius = UIConfigurations.bgCardBorderRadius,
    this.margin,
  }) : super(key: key);

  final Widget? child;
  final BorderRadius? borderRadius;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double marginHorizontal = (size.width / 15).roundToDouble();
    final double marginVertical = (size.height / 40).roundToDouble();
    return Card(
      margin: margin ??
          UIConfigurations.margin(
            horizontal: marginHorizontal,
            vertical: marginVertical,
          ),
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius!,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: child,
      ),
    );
  }
}
