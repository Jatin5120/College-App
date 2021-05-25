import 'package:flutter/material.dart';
import 'package:college_app/constants/constants.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key? key,
    this.title,
    this.size,
    this.isImage = false,
  }) : super(key: key);

  final Widget? title;
  final Size? size;
  final bool? isImage;

  @override
  Widget build(BuildContext context) {
    late double padding;
    if (size != null) {
      padding = size!.width - size!.width * 0.75;
    }
    return Material(
      elevation: 10,
      borderRadius: UIConfigurations.appBarBorderRadius,
      child: ClipRRect(
        borderRadius: UIConfigurations.appBarBorderRadius,
        child: AppBar(
          title: Container(
            padding: isImage ?? false
                ? EdgeInsets.symmetric(
                    horizontal: padding,
                  )
                : const EdgeInsets.all(0),
            child: title ?? const Text(''),
          ),
          actions: [
            IconButton(
              padding: const EdgeInsets.only(right: 12.0),
              tooltip: 'Search',
              icon: Icon(
                MyIcons.search,
                size: 20,
              ),
              onPressed: () {},
            ),
          ],
          centerTitle: true,
        ),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  final String? title;

  const TitleText(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double fontSize = (size.width / 15).roundToDouble();
    return Text(
      title!,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        letterSpacing: -2,
      ),
    );
  }
}
