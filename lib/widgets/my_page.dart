import 'package:college_app/constants/constants.dart';
import 'package:college_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  MyPage({Key? key, required this.title, required this.child})
      : super(key: key);

  final String? title;
  final Widget? child;

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  late Duration duration;
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  late Animation<double> buttonAnimation;
  late Animation<double> radiusAnimation;
  late bool isOpen;

  void initializeAnimation() {
    isOpen = false;
    duration = const Duration(milliseconds: 300);
    controller = AnimationController(vsync: this, duration: duration);
    scaleAnimation = Tween<double>(begin: 1.0, end: 0.6).animate(controller);
    buttonAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(controller);
  }

  void drawerAnimation() {
    if (isOpen)
      controller.reverse();
    else
      controller.forward();
    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  void initState() {
    super.initState();
    initializeAnimation();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double position = (size.width / 30).roundToDouble();
    final double margin = (size.width / 40).roundToDouble();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            MyDrawer(),
            AnimatedPositioned(
              top: 0,
              bottom: 0,
              right: isOpen ? -size.width * 0.6 : 0,
              left: isOpen ? size.width * 0.6 : 0,
              duration: duration,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: Material(
                  animationDuration: duration,
                  elevation: UIConfigurations.elevation,
                  borderRadius: isOpen
                      ? UIConfigurations.bgCardBorderRadius
                      : BorderRadius.zero,
                  child: ClipRRect(
                    borderRadius: isOpen
                        ? UIConfigurations.bgCardBorderRadius
                        : BorderRadius.zero,
                    child: Scaffold(
                      body: Stack(
                        children: [
                          widget.child!,
                          Positioned(
                            top: margin,
                            left: margin,
                            right: margin,
                            child: MyAppBar(
                              size: size,
                              title: Text(
                                widget.title!,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              isImage: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: position,
              left: position,
              child: IconButton(
                icon: AnimatedIcon(
                  icon: AnimatedIcons.close_menu,
                  progress: buttonAnimation,
                ),
                onPressed: () => drawerAnimation(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'query',
        child: Icon(MyIcons.message),
      ),
    );
  }
}
