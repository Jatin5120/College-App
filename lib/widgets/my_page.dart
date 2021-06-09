import 'package:college_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final double positionHorizontal = (size.width / 30).roundToDouble();
    final double marginHorizontal = (size.width / 40).roundToDouble();
    final double positionVertical = (size.height / 64).roundToDouble();
    final double marginVertical = (size.height / 87).roundToDouble();
    return Consumer2(
      builder: (BuildContext context, DrawerState drawerState,
          CurrentRoute currentRoute, Widget? child) {
        return WillPopScope(
          onWillPop: () async {
            bool pop = false;
            if (currentRoute.currentRoute == MyRoutes.home)
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    elevation: UIConfigurations.elevation,
                    backgroundColor: Theme.of(context).cardTheme.color,
                    shape: RoundedRectangleBorder(
                        borderRadius: UIConfigurations.smallCardBorderRadius),
                    title: Text('Are you Sure?'),
                    content: Text('Do you want to Exit?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          pop = false;
                          Navigator.pop(context);
                        },
                        child: Text('Go Back'),
                      ),
                      TextButton(
                        onPressed: () async {
                          pop = true;
                          Navigator.pop(context);
                          await SystemChannels.platform
                              .invokeMethod<void>('SystemNavigator.pop', true);
                        },
                        child: Text('Exit'),
                      ),
                    ],
                  );
                },
              );
            else {
              currentRoute.setRoute(MyRoutes.home);
              return false;
            }
            return pop;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: GestureDetector(
                onHorizontalDragUpdate: (DragUpdateDetails details) {
                  if (details.delta.dx < -12.0 && drawerState.isOpen) {
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
                                    top: marginVertical * 2,
                                    left: marginHorizontal * 2,
                                    right: marginHorizontal * 2,
                                    child: MyAppBar(
                                      size: size,
                                      title: Text(
                                        getTitle(currentRoute.getCurrentRoute),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                      isImage: false,
                                    ),
                                  ),
                                  if (drawerState.isOpen)
                                    GestureDetector(
                                      onTap: () {
                                        drawerState.controller.reverse();
                                        drawerState.changeState(false);
                                      },
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        color: Colors.transparent,
                                      ),
                                    ),
                                ],
                              ),
                              floatingActionButton: FloatingActionButton(
                                onPressed: () => Utils.openMail(
                                    mailTo: 'info@lkcengg.edu.in',
                                    subject: 'Query: <Query Subject>',
                                    body:
                                        '<Body of Query>\n\n\nName: <Name>\nContact: <Contact Details>\n\nPlease provide contact details so that we can contact you'),
                                tooltip: 'Query',
                                child: Icon(MyIcons.message),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: positionVertical * 1.75,
                      left: positionHorizontal * 1.75,
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
            ),
          ),
        );
      },
    );
  }
}
