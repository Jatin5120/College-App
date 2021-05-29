import 'package:college_app/constants/constants.dart';
import 'package:college_app/data/data.dart';
import 'package:flutter/material.dart';

class AlumniScreen extends StatefulWidget {
  @override
  _AlumniScreenState createState() => _AlumniScreenState();
}

class _AlumniScreenState extends State<AlumniScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(MyRoutes.alumni),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          return Center(
            child: Container(
              child: Text('Alumni Screen\nGot Data'),
            ),
          );
        } else {
          return Center(
            child: Container(
              child: Text('Alumni Screen'),
            ),
          );
        }
      },
    );
  }
}
