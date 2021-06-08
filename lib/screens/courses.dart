import 'package:college_app/constants/constants.dart';
import 'package:college_app/data/data.dart';
import 'package:college_app/modals/modals.dart';
import 'package:college_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseScreen extends StatefulWidget {
  final Courses allCourses;

  const CourseScreen({Key? key, required this.allCourses}) : super(key: key);

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  static const List<MyCourses> courseList = [
    MyCourses.bSc,
    MyCourses.bTech,
    MyCourses.bVoc,
    MyCourses.diploma,
  ];

  int currentIndex = 0;
  String getName(route) =>
      '${route.substring(1, 2).toUpperCase()}' + '${route.substring(2)}';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double marginHorizontal = (size.width / 40).roundToDouble();
    final double marginVertical = (size.height / 87).roundToDouble();
    final double padding = (size.width / 40).roundToDouble();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: SafeArea(
        child: Stack(
          children: [
            CoursesPage(allCourses: widget.allCourses, size: size),
            Positioned(
              top: marginVertical * 2,
              left: marginHorizontal * 2,
              right: marginHorizontal * 2,
              child: MyAppBar(
                size: size,
                title: Text(
                  getName(MyRoutes.courses),
                  style: Theme.of(context).textTheme.headline5,
                ),
                isImage: false,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
          _BuildBottomNavBar(padding: padding, courseList: courseList),
    );
  }
}

class _BuildBottomNavBar extends StatelessWidget {
  const _BuildBottomNavBar({
    Key? key,
    required this.padding,
    required this.courseList,
  }) : super(key: key);

  final double padding;
  final List<MyCourses> courseList;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double marginHorizontal = (size.width / 20).roundToDouble();
    final double marginVertical = (size.height / 40).roundToDouble();
    final EdgeInsets margin = EdgeInsets.symmetric(
        horizontal: marginHorizontal, vertical: marginVertical / 2);
    return CustomCard(
      margin: margin.copyWith(top: 0),
      borderRadius: UIConfigurations.appBarBorderRadius,
      child: Consumer<CourseProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: padding / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: courseList.map((course) {
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      provider.changeCourse(course);
                      provider.changeIndex(0);
                      provider.resetController();
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(coursesIconMap[course]!,
                            color: course == provider.currentCourse
                                ? Theme.of(context).iconTheme.color
                                : MyColors.inactiveColor),
                        if (course == provider.currentCourse)
                          Text(coursesMap[course]!),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}

class CoursesPage extends StatefulWidget {
  const CoursesPage({
    Key? key,
    required this.allCourses,
    required this.size,
  }) : super(key: key);

  final Courses allCourses;
  final Size size;

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  late ScrollController _scrollController;
  late List<Course?>? courseData;
  late Map<MyCourses, List<Course?>?> courseDataMap;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // _scrollController = ScrollController(initialScrollOffset: widget.size.width / 4, keepScrollOffset: true);
    courseDataMap = {
      MyCourses.bSc: widget.allCourses.bsc,
      MyCourses.bTech: widget.allCourses.btech,
      MyCourses.bVoc: widget.allCourses.bvoc,
      MyCourses.diploma: widget.allCourses.diploma,
    };
  }

  void jumpToPosition(int index) {
    final double totalWidth =
        _scrollController.position.maxScrollExtent + widget.size.width;

    final double jumpValue = index / courseData!.length * totalWidth;

    _scrollController.jumpTo(jumpValue);
    // _scrollController.position.moveTo(to)
  }

  @override
  Widget build(BuildContext context) {
    final double padding = (widget.size.width / 40).roundToDouble();
    final TextTheme textTheme = Theme.of(context).textTheme;
    // final double totalWidth =
    //     _scrollController.position.maxScrollExtent + widget.size.width;
    // print(1 / courseData!.length * totalWidth);
    return Consumer2(
      builder: (context, CourseProvider courseProvider,
          CurrentTheme currentTheme, child) {
        courseData = courseDataMap[courseProvider.currentCourse];
        final Course activeCourse = courseData![courseProvider.currentIndex]!;
        return ListView(
          controller: courseProvider.screenController,
          children: [
            UIConfigurations.spaceTop(widget.size),
            Container(
              height: widget.size.height / 11,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: padding),
              child: ListView.builder(
                // controller: _scrollController,
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                itemCount: courseData!.length,
                itemBuilder: (_, index) {
                  final Course data = courseData![index]!;
                  return GestureDetector(
                    onTap: () {
                      courseProvider.changeIndex(index);
                      // jumpToPosition(courseProvider.currentIndex);
                    },
                    child: Card(
                      color: courseProvider.currentIndex == index
                          ? currentTheme.activeBgColor
                          : null,
                      margin: EdgeInsets.symmetric(
                        vertical: padding,
                        horizontal: padding * 2,
                      ),
                      shape: StadiumBorder(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: padding * 2,
                          vertical: padding / 2,
                        ),
                        child: Center(
                          child: Text(
                            data.name!,
                            style: courseProvider.currentIndex == index
                                ? textTheme.bodyText1!.copyWith(
                                    color: currentTheme.activeColor,
                                    fontWeight: FontWeight.w600,
                                  )
                                : textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            AspectRatio(
              aspectRatio: 4 / 3,
              child: CustomCard(
                child: ShowImage(activeCourse.imageUrl!),
              ),
            ),
            Text(
              activeCourse.name!,
              style: textTheme.headline4,
              textAlign: TextAlign.center,
              softWrap: true,
            ),
            BuildSubHeader(
              title: 'Vision',
              padding: padding,
              icon: MyIcons.vision,
            ),
            BuildParagraph(
              paragraph: activeCourse.vision!,
              padding: padding,
            ),
            BuildSubHeader(
              title: 'Mission',
              padding: padding,
              icon: MyIcons.mission,
            ),
            BuildParagraph(
              paragraph: activeCourse.mission!,
              padding: padding,
            ),
            BuildSubHeader(
              title: 'Eligibility',
              padding: padding,
            ),
            BuildParagraph(
              paragraph: activeCourse.eligibility!,
              padding: padding,
            ),
            BuildSubHeader(
              title: 'Opportunities',
              padding: padding,
            ),
            BuildParagraph(
              paragraph: activeCourse.opportunities!,
              padding: padding,
            ),
            BuildSubHeader(
              title: 'Career',
              padding: padding,
            ),
            BuildParagraph(
              paragraph: activeCourse.career!,
              padding: padding,
            ),
            UIConfigurations.spaceBottom(widget.size),
          ],
        );
      },
    );
  }
}
