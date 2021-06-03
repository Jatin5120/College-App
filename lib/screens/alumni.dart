import 'package:college_app/constants/constants.dart';
import 'package:college_app/data/data.dart';
import 'package:college_app/modals/modals.dart';
import 'package:college_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AlumniScreen extends StatefulWidget {
  @override
  _AlumniScreenState createState() => _AlumniScreenState();
}

class _AlumniScreenState extends State<AlumniScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(MyRoutes.alumni),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapShot) {
        if (snapShot.hasData) {
          final AlumniModal alumniModal = AlumniModal.fromJson(snapShot.data);
          return AlumniPage(alumniModal: alumniModal);
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

class AlumniPage extends StatefulWidget {
  const AlumniPage({
    Key? key,
    required this.alumniModal,
  }) : super(key: key);

  final AlumniModal alumniModal;

  @override
  _AlumniPageState createState() => _AlumniPageState();
}

class _AlumniPageState extends State<AlumniPage> {
  late AlumniData alumniData;

  late List<Branch?>? ce;
  late List<Branch?>? cse;
  late List<Branch?>? ece;
  late List<Branch?>? me;

  @override
  void initState() {
    super.initState();
    alumniData = widget.alumniModal.data!;
    ce = alumniData.alumni!.ce;
    cse = alumniData.alumni!.cse;
    ece = alumniData.alumni!.ece;
    me = alumniData.alumni!.me;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    final double padding = (size.width / 40).roundToDouble();
    return ListView(
      children: [
        SizedBox(height: size.height / 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding * 2),
          child: Text(
            'Want to do something for the college? Want to be part of it even after getting placed?',
            style: textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ),
        BuildJoinButton(padding: padding, alumniData: alumniData),
      ],
    );
  }
}

class BuildJoinButton extends StatelessWidget {
  const BuildJoinButton({
    Key? key,
    required this.padding,
    required this.alumniData,
  }) : super(key: key);

  final double padding;
  final AlumniData alumniData;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: padding * 4, vertical: padding * 2),
      child: Consumer<CurrentTheme>(
        builder: (context, currentTheme, child) {
          return Tooltip(
            message: 'Open Form for Joining',
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: UIConfigurations.appBarBorderRadius),
              ),
              onPressed: () => Utils.openLink(url: alumniData.link!),
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Text(
                  'Join Alumni Programme',
                  style: textTheme.headline5!.copyWith(
                    color: currentTheme.currentThemeMode == ThemeMode.dark
                        ? MyColors.darkForeground
                        : currentTheme.currentThemeMode == ThemeMode.light
                            ? MyColors.lightForeground
                            : MediaQuery.of(context).platformBrightness ==
                                    Brightness.dark
                                ? MyColors.darkForeground
                                : MyColors.lightForeground,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
