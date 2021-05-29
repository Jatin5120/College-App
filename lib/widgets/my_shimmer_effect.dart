import 'package:college_app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class MyShimmerEffect extends StatefulWidget {
  final Widget? child;

  const MyShimmerEffect({Key? key, this.child}) : super(key: key);
  @override
  _MyShimmerEffectState createState() => _MyShimmerEffectState();
}

class _MyShimmerEffectState extends State<MyShimmerEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Color?> colorOne;
  late Animation<Color?> colorTwo;
  final List<Color> selectedList =
      SchedulerBinding.instance!.window.platformBrightness == Brightness.dark
          ? [MyColors.darkShimmerColorOne, MyColors.darkShimmerColorTwo]
          : [MyColors.lightShimmerColorOne, MyColors.lightShimmerColorTwo];

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
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
        padding: const EdgeInsets.all(20.0),
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
