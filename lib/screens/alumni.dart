import 'package:college_app/constants/constants.dart';
import 'package:college_app/data/data.dart';
import 'package:college_app/modals/modals.dart';
import 'package:college_app/utils.dart';
import 'package:college_app/widgets/widgets.dart';
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
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapShot) {
        if (snapShot.hasData) {
          final AlumniModal alumniModal = AlumniModal.fromJson(snapShot.data);
          return AlumniPage(alumniModal: alumniModal);
        } else {
          return _BuildLoadingAlumni();
        }
      },
    );
  }
}

class _BuildLoadingAlumni extends StatelessWidget {
  const _BuildLoadingAlumni({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MyShimmerEffect(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          SizedBox(height: size.height / 10),
          ShaderWidget(
            borderRadius: UIConfigurations.appBarBorderRadius,
            aspectRatio: 5 / 1,
          ),
          SizedBox(height: size.height / 25),
          ShaderWidget(
            borderRadius: UIConfigurations.smallCardBorderRadius,
            aspectRatio: 7 / 1,
          ),
          SizedBox(height: size.height / 25),
          ShaderWidget(
            borderRadius: UIConfigurations.appBarBorderRadius,
            aspectRatio: 10 / 1,
          ),
          SizedBox(height: size.height / 25),
          ShaderWidget(
            borderRadius: UIConfigurations.bgCardBorderRadius,
            aspectRatio: 9 / 5,
          ),
          SizedBox(height: size.height / 25),
          ShaderWidget(
            borderRadius: UIConfigurations.bgCardBorderRadius,
            aspectRatio: 9 / 5,
          ),
          SizedBox(height: size.height / 25),
          ShaderWidget(
            borderRadius: UIConfigurations.bgCardBorderRadius,
            aspectRatio: 9 / 5,
          ),
        ],
      ),
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
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    final double padding = (size.width / 40).roundToDouble();
    return ListView(
      children: [
        UIConfigurations.spaceTop(size),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: padding * 2,
            vertical: padding,
          ),
          child: Text(
            'Want to do something for the college? Want to be part of it even after getting placed?',
            style: textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ),
        CTAButton(
          padding: padding,
          link: alumniData.link!,
          text: 'Join Alumni Programme',
          toolTip: 'Open Form for Joining',
        ),
        BuildSubHeader(title: 'College Alumni', padding: padding),
        BuildSubHeader(
          title: 'Civil Department',
          padding: padding,
          isSmall: true,
        ),
        for (int i = 0; i < ce!.length; i++)
          _BuildAlumniCard(
              student: ce![i], padding: padding, isEven: i % 2 == 0),
        BuildSubHeader(
          title: 'Computer Science Department',
          padding: padding,
          isSmall: true,
        ),
        for (int i = 0; i < cse!.length; i++)
          _BuildAlumniCard(
              student: cse![i], padding: padding, isEven: i % 2 == 0),
        BuildSubHeader(
          title: 'Electronics Department',
          padding: padding,
          isSmall: true,
        ),
        for (int i = 0; i < ece!.length; i++)
          _BuildAlumniCard(
              student: ece![i], padding: padding, isEven: i % 2 == 0),
        BuildSubHeader(
          title: 'Mechanical Department',
          padding: padding,
          isSmall: true,
        ),
        for (int i = 0; i < me!.length; i++)
          _BuildAlumniCard(
              student: me![i], padding: padding, isEven: i % 2 == 0),
        UIConfigurations.spaceBottom(size),
      ],
    );
  }
}

class _BuildAlumniCard extends StatelessWidget {
  const _BuildAlumniCard({
    Key? key,
    required this.student,
    required this.padding,
    required this.isEven,
  }) : super(key: key);

  final Branch? student;
  final double padding;
  final bool isEven;

  @override
  Widget build(BuildContext context) {
    final MainAxisAlignment mainAxisAlignment =
        isEven ? MainAxisAlignment.start : MainAxisAlignment.end;
    return AspectRatio(
      aspectRatio: 9 / 5,
      child: CustomCard(
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            if (!isEven)
              _BuildDetailsColumn(
                  padding: padding, student: student, isEven: isEven),
            AspectRatio(
              aspectRatio: 3 / 4,
              child: ClipRRect(
                borderRadius: UIConfigurations.bgCardBorderRadius,
                child: ShowImage(student!.imageUrl!),
              ),
            ),
            if (isEven)
              _BuildDetailsColumn(
                  padding: padding, student: student, isEven: isEven),
          ],
        ),
      ),
    );
  }
}

class _BuildDetailsColumn extends StatelessWidget {
  const _BuildDetailsColumn({
    Key? key,
    required this.padding,
    required this.student,
    required this.isEven,
  }) : super(key: key);

  final double padding;
  final Branch? student;
  final bool isEven;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final CrossAxisAlignment crossAxisAlignment =
        isEven ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: padding,
          vertical: padding * 2,
        ),
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: crossAxisAlignment,
              children: [
                Text(
                  student!.name!,
                  style: textTheme.headline6,
                  softWrap: true,
                  textAlign: isEven ? TextAlign.left : TextAlign.right,
                ),
                SizedBox(height: padding / 2),
                Text(
                  student!.batch!,
                  style: textTheme.subtitle1,
                  softWrap: true,
                  textAlign: isEven ? TextAlign.left : TextAlign.right,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: crossAxisAlignment,
              children: [
                Text(
                  student!.job!,
                  style: textTheme.bodyText1,
                  softWrap: true,
                  textAlign: isEven ? TextAlign.left : TextAlign.right,
                ),
                SizedBox(height: padding / 2),
                Text(
                  student!.company!,
                  style: textTheme.subtitle1,
                  softWrap: true,
                  textAlign: isEven ? TextAlign.left : TextAlign.right,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: crossAxisAlignment,
              children: [
                Row(
                  mainAxisAlignment:
                      isEven ? MainAxisAlignment.start : MainAxisAlignment.end,
                  children: [
                    Icon(
                      MyIcons.mail_outlined,
                      size: 12.0,
                    ),
                    SizedBox(width: padding),
                    GestureDetector(
                      onTap: () => Utils.openMail(mailTo: student!.email!),
                      child: Text(
                        student!.email!,
                        style: textTheme.caption,
                        softWrap: true,
                        textAlign: isEven ? TextAlign.left : TextAlign.right,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: padding / 2),
                Row(
                  mainAxisAlignment:
                      isEven ? MainAxisAlignment.start : MainAxisAlignment.end,
                  children: [
                    Icon(
                      MyIcons.phone_outlined,
                      size: 12.0,
                    ),
                    SizedBox(width: padding),
                    GestureDetector(
                      onTap: () => Utils.openCall(phone: student!.mobile!),
                      child: Text(
                        student!.mobile!,
                        style: textTheme.caption,
                        softWrap: true,
                        textAlign: isEven ? TextAlign.left : TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
