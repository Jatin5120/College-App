import 'package:college_app/constants/constants.dart';
import 'package:college_app/data/data.dart';
import 'package:flutter/material.dart';

class PlacementScreen extends StatefulWidget {
  @override
  _PlacementScreenState createState() => _PlacementScreenState();
}

class _PlacementScreenState extends State<PlacementScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(MyRoutes.placement),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapShot) {
        if (snapShot.hasData) {
          return Center(
            child: Container(
              child: Text('Placement Screen\nGot Data'),
            ),
          );
        } else {
          return Center(
            child: Container(
              child: Text('Placement Screen'),
            ),
          );
        }
      },
    );
  }
}
