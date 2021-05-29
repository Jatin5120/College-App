import 'package:college_app/constants/constants.dart';
import 'package:college_app/data/data.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(MyRoutes.about),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapShot) {
        if (snapShot.hasData) {
          return AboutPage();
        } else {
          return Center(
            child: Container(
              child: Text('About Screen'),
            ),
          );
        }
      },
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('About Screen\nGot Data'),
      ),
    );
  }
}
