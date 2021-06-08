import 'package:college_app/constants/constants.dart';
import 'package:college_app/data/data.dart';
import 'package:college_app/modals/modals.dart';
import 'package:college_app/utils.dart';
import 'package:college_app/widgets/widgets.dart';
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
          final PlacementModal placementModal =
              PlacementModal.fromJson(snapShot.data);
          return PlacementPage(placementModal: placementModal);
        } else {
          return _BuildLoadingPlacement();
        }
      },
    );
  }
}

class _BuildLoadingPlacement extends StatelessWidget {
  const _BuildLoadingPlacement({
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

class PlacementPage extends StatefulWidget {
  const PlacementPage({
    required this.placementModal,
    Key? key,
  }) : super(key: key);

  final PlacementModal placementModal;

  @override
  _PlacementPageState createState() => _PlacementPageState();
}

class _PlacementPageState extends State<PlacementPage> {
  late PlacementData placementData;

  late List<Coordinator?>? coordinators;
  late List<Recruiter?>? recruiters;
  late List<StudentPlaced?>? studentsPlaced;
  late Ibm? ibm;
  late List<Student?>? cse;
  late List<Student?>? ece;

  @override
  void initState() {
    super.initState();
    placementData = widget.placementModal.data!;
    coordinators = placementData.coordinators;
    recruiters = placementData.recruiters;
    studentsPlaced = placementData.studentsPlaced;
    ibm = placementData.ibm;
    cse = ibm!.cse;
    ece = ibm!.ece;
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    final double padding = (size.width / 40).roundToDouble();
    final double marginHorizontal = (size.width / 15).roundToDouble();
    final double marginVertical = (size.height / 40).roundToDouble();
    final EdgeInsets margin = UIConfigurations.margin(
      horizontal: marginHorizontal,
      vertical: marginVertical,
    );
    return ListView(
      children: [
        UIConfigurations.spaceTop(size),
        Padding(
          padding: EdgeInsets.all(padding),
          child: Text(
            'PLACEMENT CORNER',
            style: textTheme.headline4!.copyWith(
              letterSpacing: 3.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        BuildSubHeader(title: 'Placement Cell', padding: padding),
        for (Coordinator? coordinator in coordinators!)
          _BuildCoordinatorCard(coordinator: coordinator, padding: padding),
        BuildSubHeader(title: 'Students Placed', padding: padding),
        _BuildStudentsPlaced(
            studentsPlaced: studentsPlaced, padding: padding, margin: margin),
        BuildSubHeader(title: 'Recruiters', padding: padding),
        _BuildRecruiters(
            recruiters: recruiters, padding: padding, margin: margin),
        BuildSubHeader(title: 'Cleared IBM Exam', padding: padding),
        BuildSubHeader(title: 'CSE', padding: padding, isSmall: true),
        _BuildIBMStudents(students: cse, padding: padding, margin: margin),
        BuildSubHeader(title: 'ECE', padding: padding, isSmall: true),
        _BuildIBMStudents(students: ece, padding: padding, margin: margin),
        UIConfigurations.spaceBottom(size),
      ],
    );
  }
}

class _BuildIBMStudents extends StatelessWidget {
  const _BuildIBMStudents(
      {Key? key,
      required this.students,
      required this.padding,
      required this.margin})
      : super(key: key);

  final List<Student?>? students;
  final double padding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return GridView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: students!.length,
      padding: margin,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 9 / 16,
        mainAxisSpacing: padding * 2,
        crossAxisSpacing: padding * 2,
      ),
      itemBuilder: (context, index) {
        final Student student = students![index]!;
        return Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: UIConfigurations.smallCardBorderRadius,
          ),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 6 / 8,
                child: ClipRRect(
                  borderRadius: UIConfigurations.smallCardBorderRadius,
                  child: ShowImage(student.imageUrl!),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(padding / 2),
                child: Text(
                  student.name!,
                  style: textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _BuildRecruiters extends StatelessWidget {
  const _BuildRecruiters({
    Key? key,
    required this.recruiters,
    required this.padding,
    required this.margin,
  }) : super(key: key);

  final List<Recruiter?>? recruiters;
  final double padding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: recruiters!.length,
      padding: margin,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 16 / 9,
        mainAxisSpacing: padding * 2,
        crossAxisSpacing: padding * 2,
      ),
      itemBuilder: (context, index) {
        final Recruiter recruiter = recruiters![index]!;
        return CustomCard(
          margin: EdgeInsets.zero,
          borderRadius: UIConfigurations.smallCardBorderRadius,
          child: Tooltip(
            message: recruiter.name!,
            child: ShowImage(recruiter.imageUrl!),
          ),
        );
      },
    );
  }
}

class _BuildStudentsPlaced extends StatelessWidget {
  const _BuildStudentsPlaced({
    Key? key,
    required this.studentsPlaced,
    required this.padding,
    required this.margin,
  }) : super(key: key);

  final List<StudentPlaced?>? studentsPlaced;
  final double padding;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return GridView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemCount: studentsPlaced!.length,
      padding: margin,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 9 / 17,
        mainAxisSpacing: padding * 2,
        crossAxisSpacing: padding * 2,
      ),
      itemBuilder: (context, index) {
        final StudentPlaced studentPlaced = studentsPlaced![index]!;
        return CustomCard(
          margin: EdgeInsets.zero,
          borderRadius: UIConfigurations.smallCardBorderRadius,
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 5 / 7,
                child: ClipRRect(
                  borderRadius: UIConfigurations.smallCardBorderRadius,
                  child: ShowImage(studentPlaced.imageUrl!),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: padding),
                child: Column(
                  children: [
                    Text(
                      studentPlaced.name!,
                      style: textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      studentPlaced.company!,
                      style: textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _BuildCoordinatorCard extends StatelessWidget {
  const _BuildCoordinatorCard({
    Key? key,
    required this.coordinator,
    required this.padding,
  }) : super(key: key);

  final Coordinator? coordinator;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 5,
      child: CustomCard(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 3 / 4,
              child: ClipRRect(
                borderRadius: UIConfigurations.bgCardBorderRadius,
                child: ShowImage(coordinator!.imageUrl!),
              ),
            ),
            _BuildDetailsColumn(padding: padding, coordinator: coordinator),
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
    required this.coordinator,
  }) : super(key: key);

  final double padding;
  final Coordinator? coordinator;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding,
        vertical: padding * 3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            coordinator!.name!,
            style: textTheme.headline6,
          ),
          Row(
            children: [
              Icon(
                MyIcons.user,
                size: 18.0,
              ),
              SizedBox(width: padding),
              Text(
                coordinator!.designation!,
                style: textTheme.bodyText1,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    MyIcons.mail_outlined,
                    size: 12.0,
                  ),
                  SizedBox(width: padding),
                  GestureDetector(
                    onTap: () => Utils.openMail(mailTo: coordinator!.email!),
                    child: Text(
                      coordinator!.email!,
                      style: textTheme.caption,
                    ),
                  ),
                ],
              ),
              SizedBox(height: padding / 2),
              Row(
                children: [
                  Icon(
                    MyIcons.phone_outlined,
                    size: 12.0,
                  ),
                  SizedBox(width: padding),
                  GestureDetector(
                    onTap: () => Utils.openCall(phone: coordinator!.mobile!),
                    child: Text(
                      coordinator!.mobile!,
                      style: textTheme.caption,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
