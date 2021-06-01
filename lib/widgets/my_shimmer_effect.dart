import 'package:college_app/constants/colors.dart';
import 'package:college_app/data/my_providers/my_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class MyShimmerEffect extends StatefulWidget {
  final Widget? child;

  const MyShimmerEffect({Key? key, this.child}) : super(key: key);
  @override
  _MyShimmerEffectState createState() => _MyShimmerEffectState();
}

class _MyShimmerEffectState extends State<MyShimmerEffect>
    with SingleTickerProviderStateMixin {
  late CurrentTheme currentTheme;
  late AnimationController controller;
  final List<Color> lightColors = [
    MyColors.lightShimmerColorOne,
    MyColors.lightShimmerColorTwo
  ];
  final List<Color> darkColors = [
    MyColors.darkShimmerColorOne,
    MyColors.darkShimmerColorTwo
  ];
  late Animation<Color?> colorOne;
  late Animation<Color?> colorTwo;
  late List<Color> selectedList;

  List<Color> getColorList() {
    switch (currentTheme.currentThemeMode) {
      case ThemeMode.light:
        return lightColors;
      case ThemeMode.dark:
        return darkColors;
      case ThemeMode.system:
        return SchedulerBinding.instance!.window.platformBrightness ==
                Brightness.dark
            ? darkColors
            : lightColors;
      default:
        return lightColors;
    }
  }

  @override
  void initState() {
    super.initState();
    currentTheme = Provider.of<CurrentTheme>(context, listen: false);
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    selectedList = getColorList();
    colorOne = ColorTween(begin: selectedList[0], end: selectedList[1])
        .animate(controller);
    colorTwo = ColorTween(begin: selectedList[1], end: selectedList[0])
        .animate(controller);

    controller.forward();

    controller.addListener(() {
      if (controller.isCompleted) {
        controller.reverse();
      } else if (controller.isDismissed) {
        controller.forward();
      }
      this.setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              colors: [
                colorOne.value!,
                colorTwo.value!,
              ],
            ).createShader(rect);
          },
          child: widget.child,
        ),
      ),
    );
  }
}
