import 'package:college_app/constants/constants.dart';
import 'package:college_app/data/data.dart';
import 'package:college_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AchievementScreen extends StatefulWidget {
  @override
  _AchievementScreenState createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(MyRoutes.achievement),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          return Center(
            child: Container(
              child: Text('Achievement Screen\nGot Data'),
            ),
          );
        } else {
          return Center(
            child: Container(
              child: Text('Achievement Screen\nGot Data'),
            ),
          );
        }
      },
    );
  }
}
