import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:college_app/constants/constants.dart';
import 'package:college_app/data/data.dart';
import 'package:college_app/screens/screens.dart';
import 'package:college_app/widgets/widgets.dart';

class MyPage extends StatefulWidget {
  MyPage({Key? key, this.title, this.child}) : super(key: key);

  final String? title;
  final Widget? child;

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  late Duration duration;
  late Animation<double> scaleAnimation;
  late Animation<double> buttonAnimation;
  late Animation<double> radiusAnimation;
  late DrawerState _drawerState;

  final Map<String, Widget> pages = {
    MyRoutes.home: HomeScreen(),
    MyRoutes.about: AboutScreen(),
    MyRoutes.achievements: AchievementScreen(),
    MyRoutes.placement: PlacementScreen(),
    MyRoutes.alumni: AlumniScreen(),
    MyRoutes.help: HelpScreen(),
    MyRoutes.courses: CourseScreen(),
  };

  void initializeAnimation() {
    duration = const Duration(milliseconds: 300);
    _drawerState.initializeState(
      isOpen: false,
      controller: AnimationController(vsync: this, duration: duration),
    );
    scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.6).animate(_drawerState.controller);
    buttonAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_drawerState.controller);
  }

  void drawerAnimation() {
    if (_drawerState.isOpen) {
      _drawerState.controller.reverse();
    } else {
      _drawerState.controller.forward();
    }
    _drawerState.changeState(!_drawerState.isOpen);
  }

  String getTitle(String route) {
    return '${route.substring(1, 2).toUpperCase()}' + '${route.substring(2)}';
  }

  @override
  void initState() {
    super.initState();
    _drawerState = Provider.of<DrawerState>(context, listen: false);
    initializeAnimation();
  }

  @override
  void dispose() {
    _drawerState.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double position = (size.width / 30).roundToDouble();
    final double margin = (size.width / 40).roundToDouble();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Consumer2(
          builder: (BuildContext context, DrawerState drawerState,
              CurrentRoute currentRoute, Widget? child) {
            return GestureDetector(
              onHorizontalDragUpdate: (DragUpdateDetails details) {
                if (details.delta.dx < -5.0 && drawerState.isOpen) {
                  print(details.delta.dx);
                  drawerState.controller.reverse();
                  drawerState.changeState(false);
                }
              },
              child: Stack(
                children: [
                  MyDrawer(),
                  AnimatedPositioned(
                    top: 0,
                    bottom: 0,
                    right: drawerState.isOpen ? -size.width * 0.6 : 0,
                    left: drawerState.isOpen ? size.width * 0.6 : 0,
                    duration: duration,
                    child: ScaleTransition(
                      scale: scaleAnimation,
                      child: Material(
                        animationDuration: duration,
                        elevation: UIConfigurations.elevation,
                        borderRadius: drawerState.isOpen
                            ? UIConfigurations.bgCardBorderRadius
                            : BorderRadius.zero,
                        child: ClipRRect(
                          borderRadius: drawerState.isOpen
                              ? UIConfigurations.bgCardBorderRadius
                              : BorderRadius.zero,
                          child: Scaffold(
                            body: Stack(
                              children: [
                                pages[currentRoute.getCurrentRoute]!,
                                Positioned(
                                  top: margin,
                                  left: margin,
                                  right: margin,
                                  child: MyAppBar(
                                    size: size,
                                    title: Text(
                                      getTitle(currentRoute.getCurrentRoute),
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    isImage: false,
                                  ),
                                ),
                              ],
                            ),
                            floatingActionButton: FloatingActionButton(
                              onPressed: () {},
                              tooltip: 'query',
                              child: Icon(MyIcons.message),
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
            );
          },
        ),
      ),
    );
  }
}
