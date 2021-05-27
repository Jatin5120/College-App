import 'package:flutter/material.dart';

class ShaderWidget extends StatelessWidget {
  final BorderRadius? borderRadius;
  final double? aspectRatio;

  const ShaderWidget(
      {Key? key, required this.borderRadius, required this.aspectRatio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio!,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }
}
