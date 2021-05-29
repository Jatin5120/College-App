import 'package:college_app/data/data.dart';
import 'package:college_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:college_app/constants/constants.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CurrentTheme()),
        ChangeNotifierProvider(create: (context) => CurrentRoute()),
        ChangeNotifierProvider(create: (context) => DrawerState()),
      ],
      builder: (context, child) {
        final CurrentTheme currentTheme = context.watch<CurrentTheme>();
        return MaterialApp(
          title: 'LKCTC Mobile App',
          debugShowCheckedModeBanner: false,
          themeMode: currentTheme.currentThemeMode,
          darkTheme: MyThemeData.darkThemeData,
          theme: MyThemeData.lightThemeData,
          // onGenerateRoute: RouteNavigator.generateRoute,
          scrollBehavior:
              ScrollBehavior().copyWith(physics: BouncingScrollPhysics()),
          home: MyPage(),
        );
      },
    );
  }
}
