import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );
    colorOne = ColorTween(begin: Colors.grey[100], end: Colors.grey[500])
        .animate(controller);
    colorTwo = ColorTween(begin: Colors.grey[500], end: Colors.grey[100])
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
