import 'package:college_app/constants/constants.dart';
import 'package:flutter/material.dart';

class BuildSubHeader extends StatelessWidget {
  const BuildSubHeader({
    Key? key,
    required this.title,
    required this.padding,
    this.icon,
    this.isSmall = false,
    this.showRightArrow = false,
  }) : super(key: key);

  final String title;
  final double padding;
  final IconData? icon;
  final bool isSmall;
  final bool showRightArrow;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(
        top: isSmall ? padding : padding * 3,
        bottom: isSmall ? 0 : padding / 1.5,
        left: isSmall ? padding * 3 : 0,
        right: showRightArrow ? padding * 4 : 0,
      ),
      child: Row(
        mainAxisAlignment: isSmall
            ? showRightArrow
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start
            : MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            title,
            style: isSmall ? textTheme.headline5 : textTheme.headline4,
            textAlign: TextAlign.center,
          ),
          SizedBox(width: icon == null ? 0 : padding * 2),
          if (showRightArrow) Icon(MyIcons.arrow_right_alt),
          if (icon != null) Icon(icon),
        ],
      ),
    );
  }
}
