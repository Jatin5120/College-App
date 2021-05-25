import 'package:flutter/material.dart';
import 'package:college_app/screens/screens.dart';
import 'package:college_app/constants/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LKCTC Mobile App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: MyThemeData.darkThemeData,
      theme: MyThemeData.lightThemeData,
      scrollBehavior:
          ScrollBehavior().copyWith(physics: BouncingScrollPhysics()),
      home: HomeScreen(),
    );
  }
}
