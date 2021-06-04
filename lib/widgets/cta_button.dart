import 'package:college_app/constants/constants.dart';
import 'package:college_app/data/data.dart';
import 'package:college_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CTAButton extends StatelessWidget {
  const CTAButton({
    Key? key,
    required this.padding,
    required this.link,
    required this.text,
    this.toolTip,
  }) : super(key: key);

  final double padding;
  final String link;
  final String text;
  final String? toolTip;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: padding * 4, vertical: padding * 2),
      child: Consumer<CurrentTheme>(
        builder: (context, currentTheme, child) {
          return Tooltip(
            message: toolTip ?? 'Open Link',
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: UIConfigurations.appBarBorderRadius),
              ),
              onPressed: () => Utils.openLink(url: link),
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Text(
                  text,
                  style: textTheme.headline5!.copyWith(
                    color: currentTheme.currentThemeMode == ThemeMode.dark
                        ? MyColors.darkForeground
                        : currentTheme.currentThemeMode == ThemeMode.light
                            ? MyColors.lightForeground
                            : MediaQuery.of(context).platformBrightness ==
                                    Brightness.dark
                                ? MyColors.darkForeground
                                : MyColors.lightForeground,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
