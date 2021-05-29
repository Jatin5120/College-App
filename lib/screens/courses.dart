import 'package:college_app/constants/constants.dart';
import 'package:college_app/data/data.dart';
import 'package:college_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CourseScreen extends StatefulWidget {
  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(MyRoutes.courses),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          return Center(
            child: Container(
              child: Text('Courses Screen\nGot Data'),
            ),
          );
        } else {
          return Center(
            child: Container(
              child: Text('Courses Screen'),
            ),
          );
        }
      },
    );
  }
}
