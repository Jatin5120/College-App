import 'package:college_app/constants/constants.dart';
import 'package:college_app/data/my_providers/my_providers.dart';
import 'package:college_app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final List<DrawerItem> drawerItems = [
    DrawerItem(icon: MyIcons.home, title: 'Home', route: MyRoutes.home),
    DrawerItem(icon: MyIcons.about, title: 'About', route: MyRoutes.about),
    DrawerItem(
        icon: MyIcons.achievements,
        title: 'Achievements',
        route: MyRoutes.achievements),
    DrawerItem(
        icon: MyIcons.placement, title: 'Placement', route: MyRoutes.placement),
    DrawerItem(icon: MyIcons.alumni, title: 'Alumni', route: MyRoutes.alumni),
    DrawerItem(icon: MyIcons.help, title: 'Help', route: MyRoutes.help),
  ];
  late CurrentTheme currentTheme;

  @override
  void initState() {
    super.initState();
    print("Drawer initState()");
    currentTheme = Provider.of<CurrentTheme>(context, listen: false);
    currentTheme.setPreference();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double paddingHorizontal = (size.width / 6).roundToDouble();
    final double paddingVertical = (size.height / 13).roundToDouble();
    final TextTheme textTheme = Theme.of(context).textTheme;
    print("paddingHorizontal: $paddingHorizontal");
    print("paddingVertical: $paddingVertical");
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          paddingHorizontal / 2,
          paddingVertical / 1.2,
          paddingHorizontal / 2,
          paddingVertical / 2,
        ),
        child: Consumer2(
          builder: (BuildContext context, CurrentRoute currentRoute,
              DrawerState drawerState, Widget? child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      child: GestureDetector(
                        onTap: () {
                          drawerState.controller.reverse();
                          drawerState.changeState(false);
                          currentRoute.setRoute(MyRoutes.about);
                        },
                        child: Image.asset('assets/images/logo.png'),
                      ),
                      radius: paddingVertical,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                    ),
                    SizedBox(
                      height: paddingVertical / 7,
                    ),
                    Text(
                      'LKC TC',
                      style: textTheme.headline5!.copyWith(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Consumer2(
                    builder: (BuildContext context, CurrentRoute currentRoute,
                        DrawerState drawerState, Widget? child) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: drawerItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ClipRRect(
                            borderRadius:
                                UIConfigurations.smallCardBorderRadius,
                            child: Card(
                              margin: EdgeInsets.only(
                                right: paddingHorizontal * 1.5,
                                top: paddingVertical / 2.5,
                              ),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: currentTheme.activeBgColor,
                                  width: 2.0,
                                  style: currentRoute.getCurrentRoute ==
                                          drawerItems[index].route
                                      ? BorderStyle.solid
                                      : BorderStyle.none,
                                ),
                                borderRadius:
                                    UIConfigurations.smallCardBorderRadius,
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  drawerState.controller.reverse();
                                  drawerState.changeState(false);
                                  currentRoute
                                      .setRoute(drawerItems[index].route);
                                },
                                child: Tooltip(
                                  message:
                                      "Go to ${drawerItems[index].title} Screen",
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0,
                                      vertical: 16.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(drawerItems[index].icon),
                                        SizedBox(
                                          width: paddingHorizontal / 5,
                                        ),
                                        Text(
                                          drawerItems[index].title,
                                          style: textTheme.headline6,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: paddingHorizontal / 4),
                  child: Row(
                    children: [
                      Text(
                        'Choose Theme',
                        style: textTheme.headline6,
                      ),
                      SizedBox(
                        width: paddingHorizontal / 2,
                      ),
                      DropdownButton<ThemeMode>(
                        dropdownColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        value: currentTheme.currentThemeMode,
                        items: <ThemeMode>[
                          ThemeMode.light,
                          ThemeMode.dark,
                          ThemeMode.system,
                        ].map<DropdownMenuItem<ThemeMode>>(
                            (ThemeMode themeMode) {
                          return DropdownMenuItem(
                            value: themeMode,
                            child: Text(
                              themeMode.toString().substring(10).toUpperCase(),
                              style: textTheme.button,
                            ),
                          );
                        }).toList(),
                        style: textTheme.bodyText2,
                        hint: Text(
                          currentTheme.currentThemeMode
                              .toString()
                              .substring(10)
                              .toUpperCase(),
                          style: textTheme.button,
                        ),
                        onChanged: (ThemeMode? themeMode) {
                          currentTheme.setTheme(themeMode!);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class DrawerItem {
  final IconData icon;
  final String title;
  final String route;

  DrawerItem({required this.icon, required this.title, required this.route});
}
