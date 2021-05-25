import 'package:college_app/constants/constants.dart';
import 'package:flutter/material.dart';

class SubHeader extends StatelessWidget {
  final double? padding;
  final VoidCallback? onPressed;
  final String? title;

  const SubHeader(
      {Key? key,
      required this.padding,
      required this.onPressed,
      required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        (padding ?? 0) * 3,
        (padding ?? 0) * 3,
        (padding ?? 0) * 2,
        0.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title!,
            style: Theme.of(context).textTheme.headline6,
          ),
          IconButton(
            icon: Icon(MyIcons.arrow_right),
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
