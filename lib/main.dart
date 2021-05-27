import 'package:college_app/data/theme.dart';
import 'package:flutter/material.dart';
import 'package:college_app/screens/screens.dart';
import 'package:college_app/constants/constants.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CurrentTheme>(
      create: (context) => CurrentTheme(),
      child: Consumer<CurrentTheme>(
        builder: (context, currentTheme, child) {
          return MaterialApp(
            title: 'LKCTC Mobile App',
            debugShowCheckedModeBanner: false,
            themeMode: currentTheme.currentThemeMode,
            darkTheme: MyThemeData.darkThemeData,
            theme: MyThemeData.lightThemeData,
            scrollBehavior:
                ScrollBehavior().copyWith(physics: BouncingScrollPhysics()),
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}
