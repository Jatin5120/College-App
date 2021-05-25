import 'package:college_app/constants/constants.dart';
import 'package:flutter/material.dart';

class ShowSlides extends StatelessWidget {
  final EdgeInsets? margin;
  final double? aspectRatio;
  final Widget child;
  final bool? inplaceSliding;
  const ShowSlides({
    Key? key,
    required this.margin,
    required this.aspectRatio,
    required this.child,
    this.inplaceSliding = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: inplaceSliding!
          ? BoxDecoration(
              borderRadius: UIConfigurations.bgCardBorderRadius,
            )
          : null,
      child: Material(
        elevation: UIConfigurations.elevation,
        borderRadius: UIConfigurations.bgCardBorderRadius,
        child: AspectRatio(
          aspectRatio: aspectRatio!,
          child: ClipRRect(
            borderRadius: inplaceSliding!
                ? UIConfigurations.bgCardBorderRadius
                : BorderRadius.zero,
            child: child,
          ),
        ),
      ),
    );
  }
}
