import 'package:flutter/material.dart';

class BuildParagraph extends StatelessWidget {
  const BuildParagraph({
    Key? key,
    required this.paragraph,
    required this.padding,
    this.textAlign,
  }) : super(key: key);

  final double padding;
  final String paragraph;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding * 3,
        vertical: padding,
      ),
      child: Text(
        paragraph,
        style: textTheme.bodyText1,
        textAlign: textAlign ?? TextAlign.justify,
      ),
    );
  }
}
