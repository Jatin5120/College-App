import 'package:college_app/constants/constants.dart';
import 'package:college_app/data/data.dart';
import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  @override
  _HelpScreenState createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(MyRoutes.help),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          return Center(
            child: Container(
              child: Text('Help Screen\nGot Data'),
            ),
          );
        } else {
          return Center(
            child: Container(
              child: Text('Help Screen'),
            ),
          );
        }
      },
    );
  }
}
