import 'package:flutter/material.dart';

class BuildSubHeader extends StatelessWidget {
  const BuildSubHeader({
    Key? key,
    required this.padding,
    required this.title,
    this.icon,
    this.isSmall = false,
  }) : super(key: key);

  final String title;
  final IconData? icon;
  final double padding;
  final bool? isSmall;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(top: padding * 3, bottom: padding / 1.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: isSmall! ? textTheme.headline5 : textTheme.headline4,
            textAlign: TextAlign.center,
          ),
          SizedBox(width: icon == null ? 0 : padding * 2),
          if (icon != null) Icon(icon),
        ],
      ),
    );
  }
}
