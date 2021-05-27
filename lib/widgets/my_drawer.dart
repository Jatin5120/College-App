import 'package:college_app/constants/constants.dart';
import 'package:college_app/data/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  MyDrawer({Key? key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final List<DrawerItem> drawerItems = [
    DrawerItem(icon: MyIcons.home, title: 'Home', onTap: () {}),
    DrawerItem(icon: MyIcons.about, title: 'About', onTap: () {}),
    DrawerItem(icon: MyIcons.achievements, title: 'Achievements', onTap: () {}),
    DrawerItem(icon: MyIcons.placement, title: 'Placement', onTap: () {}),
    DrawerItem(icon: MyIcons.alumni, title: 'Alumni', onTap: () {}),
    DrawerItem(icon: MyIcons.help, title: 'Help', onTap: () {}),
  ];
  bool isDark = true;
  late CurrentTheme currentTheme;

  @override
  void initState() {
    super.initState();
    currentTheme = Provider.of<CurrentTheme>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double padding = size.width / 6;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: padding / 2,
          vertical: padding / 1.2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  child: Image.asset('assets/images/logo.png'),
                  radius: padding,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
                SizedBox(
                  height: padding / 7,
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
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: drawerItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: UIConfigurations.smallCardBorderRadius,
                    child: Card(
                      margin: EdgeInsets.only(
                        right: padding * 1.5,
                        top: padding / 2.5,
                      ),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: UIConfigurations.smallCardBorderRadius,
                      ),
                      child: InkWell(
                        onTap: drawerItems[index].onTap,
                        onLongPress: () => Tooltip(
                          message: drawerItems[index].title,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24.0,
                            vertical: 16.0,
                          ),
                          child: Row(
                            children: [
                              Icon(drawerItems[index].icon),
                              SizedBox(
                                width: padding / 5,
                              ),
                              Text(
                                drawerItems[index].title,
                                style: textTheme.headline6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: padding / 4),
              child: Row(
                children: [
                  Text(
                    'Choose Theme',
                    style: textTheme.headline6,
                  ),
                  SizedBox(
                    width: padding / 2,
                  ),
                  DropdownButton<ThemeMode>(
                    dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                    items: <ThemeMode>[
                      ThemeMode.light,
                      ThemeMode.dark,
                      ThemeMode.system,
                    ].map<DropdownMenuItem<ThemeMode>>((ThemeMode themeMode) {
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
            )
          ],
        ),
      ),
    );
  }
}

class DrawerItem {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  DrawerItem({required this.icon, required this.title, required this.onTap});
}
