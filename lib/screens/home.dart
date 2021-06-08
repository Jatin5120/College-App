import 'dart:async';
import 'package:college_app/modals/modals.dart';
import 'package:college_app/screens/screens.dart';
import 'package:college_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:college_app/constants/constants.dart';
import 'package:college_app/data/data.dart';
import 'package:college_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(MyRoutes.home),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapShot) {
        if (snapShot.hasData) {
          final HomeModal homeModel = HomeModal.fromJson(snapShot.data);
          return HomePage(homeModel: homeModel);
        } else {
          return _BuildLoadingHome();
        }
      },
    );
  }
}

class _BuildLoadingHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MyShimmerEffect(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          UIConfigurations.spaceTop(size),
          ShaderWidget(
            borderRadius: UIConfigurations.bgCardBorderRadius,
            aspectRatio: 3 / 2,
          ),
          SizedBox(height: size.height / 25),
          ShaderWidget(
            borderRadius: UIConfigurations.appBarBorderRadius,
            aspectRatio: 10 / 1,
          ),
          SizedBox(height: size.height / 25),
          ShaderWidget(
            borderRadius: UIConfigurations.smallCardBorderRadius,
            aspectRatio: 3 / 2,
          ),
          SizedBox(height: size.height / 25),
          ShaderWidget(
            borderRadius: UIConfigurations.appBarBorderRadius,
            aspectRatio: 10 / 1,
          ),
          SizedBox(height: size.height / 25),
          ShaderWidget(
            borderRadius: UIConfigurations.bgCardBorderRadius,
            aspectRatio: 1,
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.homeModel}) : super(key: key);

  final HomeModal homeModel;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeData homeData;

  late List<String?>? slides;
  late List<NoticeBoard?>? noticeBoard;
  late About? about;
  late Courses? courses;
  late List<Course?>? bSc;
  late List<Course?>? bTech;
  late List<Course?>? bVoc;
  late List<Course?>? diploma;
  late List<Testimonials?>? testimonials;
  late List<News?>? news;
  late List<IndustrialVisits?>? industrialVisits;

  @override
  void initState() {
    super.initState();
    homeData = widget.homeModel.data!;
    slides = homeData.slideShow!;
    noticeBoard = homeData.noticeBoard!.reversed.toList();
    about = homeData.about!;
    courses = homeData.courses!;
    bSc = courses!.bsc!;
    bTech = courses!.btech!;
    bVoc = courses!.bvoc!;
    diploma = courses!.diploma!;
    testimonials = homeData.testimonials!;
    news = homeData.news!;
    industrialVisits = homeData.industrialVisits!;
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
      children: <Widget>[
        UIConfigurations.spaceTop(size),
        BuildSlideShow(slides: slides),
        BuildSubHeader(
            title: 'Events', padding: padding, icon: Icons.event_outlined),
        BuildEvents(noticeBoard: noticeBoard!),
        BuildSubHeader(title: 'About', padding: padding),
        BuildAbout(about: about, padding: padding),
        BuildSubHeader(
            title: 'Courses', padding: padding, icon: MyIcons.courses),
        BuildSubHeader(
          title: 'B.Sc',
          padding: padding,
          isSmall: true,
          showRightArrow: true,
        ),
        SmallDetailCard(
          padding: padding,
          allCourses: courses,
          courseTitle: 'B.Sc',
          myCourses: MyCourses.bSc,
          courses: bSc,
          margin: margin,
        ),
        BuildSubHeader(
          title: 'B.Tech',
          padding: padding,
          isSmall: true,
          showRightArrow: true,
        ),
        SmallDetailCard(
          padding: padding,
          allCourses: courses,
          courseTitle: 'B.Tech',
          myCourses: MyCourses.bTech,
          courses: bTech,
          margin: margin,
        ),
        BuildSubHeader(
          title: 'B.Voc',
          padding: padding,
          isSmall: true,
          showRightArrow: true,
        ),
        SmallDetailCard(
          padding: padding,
          allCourses: courses,
          courseTitle: 'B.Voc',
          myCourses: MyCourses.bVoc,
          courses: bVoc,
          margin: margin,
        ),
        BuildSubHeader(
          title: 'Diploma',
          padding: padding,
          isSmall: true,
          showRightArrow: true,
        ),
        SmallDetailCard(
          padding: padding,
          allCourses: courses,
          courseTitle: 'Diploma',
          myCourses: MyCourses.diploma,
          courses: diploma,
          margin: margin,
        ),
        BuildSubHeader(
            title: 'Testimonials', padding: padding, icon: Icons.edit_outlined),
        BuildTestimonials(testimonials: testimonials, padding: padding),
        BuildSubHeader(
          title: 'News & Headlines',
          padding: padding,
          icon: Icons.library_books_outlined,
        ),
        BuildNews(news: news, padding: padding),
        BuildSubHeader(
          title: 'Industrial Visits',
          padding: padding,
          icon: Icons.place_outlined,
        ),
        for (IndustrialVisits? visit in industrialVisits!)
          BuildSwipableImageCard(item: visit!.toJson(), padding: padding),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Consumer2(
              builder: (context, CurrentRoute currentRoute,
                  DrawerState drawerState, child) {
                return OutlinedButton(
                  child: Text(
                    'Need Help?',
                    style: textTheme.headline6,
                  ),
                  onPressed: () {
                    drawerState.controller.forward();
                    drawerState.changeState(true);
                    Timer(Duration(milliseconds: 300), () {
                      currentRoute.setRoute(MyRoutes.help);
                    });
                    Timer(Duration(milliseconds: 300), () {
                      drawerState.controller.reverse();
                      drawerState.changeState(false);
                    });
                  },
                );
              },
            ),
          ),
        ),
        UIConfigurations.spaceBottom(size),
      ],
    );
  }
}

class BuildNews extends StatelessWidget {
  const BuildNews({
    Key? key,
    required this.news,
    required this.padding,
  }) : super(key: key);

  final List<News?>? news;
  final double padding;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: news!.length,
        itemBuilder: (_, index) {
          return AspectRatio(
            aspectRatio: 3 / 2,
            child: CustomCard(
              borderRadius: UIConfigurations.smallCardBorderRadius,
              child: Row(
                children: [
                  AspectRatio(
                    aspectRatio: 9 / 8,
                    child: ClipRRect(
                      borderRadius: UIConfigurations.smallCardBorderRadius,
                      child: ShowImage(news![index]!.imageUrl!),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            news![index]!.headline!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 7,
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(
                            height: padding * 2,
                          ),
                          Text(
                            news![index]!.date!,
                            style: textTheme.overline,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 7,
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BuildTestimonials extends StatelessWidget {
  const BuildTestimonials({
    Key? key,
    required this.testimonials,
    required this.padding,
  }) : super(key: key);

  final List<Testimonials?>? testimonials;
  final double padding;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return AspectRatio(
      aspectRatio: 1,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: testimonials!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CustomCard(
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: UIConfigurations.bgCardBorderRadius,
                  child: AspectRatio(
                    aspectRatio: 20 / 9,
                    child: ShowImage(testimonials![index]!.imageUrl),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(padding * 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              MyIcons.user,
                              size: 16.0,
                            ),
                          ),
                          Text(
                            '${testimonials![index]!.name!}  |  ',
                            style: textTheme.headline5,
                          ),
                          Text(
                            testimonials![index]!.department!,
                            style: textTheme.subtitle1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: padding * 1.5,
                      ),
                      Text(
                        testimonials![index]!.quote!,
                        style: textTheme.bodyText2,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 7,
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class SmallDetailCard extends StatelessWidget {
  const SmallDetailCard({
    Key? key,
    required this.padding,
    required this.courseTitle,
    required this.myCourses,
    required this.courses,
    required this.margin,
    required this.allCourses,
  }) : super(key: key);

  final double padding;
  final String courseTitle;
  final MyCourses myCourses;
  final List<Course?>? courses;
  final EdgeInsets margin;
  final Courses? allCourses;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final BorderRadius? borderRadius = UIConfigurations.smallCardBorderRadius;
    final Size size = MediaQuery.of(context).size;
    final double marginVertical = (size.height / 40).roundToDouble();
    return AspectRatio(
      aspectRatio: 5 / 2,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: courses!.length,
        itemBuilder: (context, index) {
          final Course course = courses![index]!;
          return AspectRatio(
            aspectRatio: 5 / 2,
            child: Consumer<CourseProvider>(
              builder: (context, provider, child) => GestureDetector(
                onTap: () {
                  provider.changeCourse(myCourses);
                  provider.changeIndex(index);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CourseScreen(allCourses: allCourses!),
                    ),
                  );
                },
                child: CustomCard(
                  margin: margin.copyWith(top: marginVertical / 2),
                  borderRadius: borderRadius ?? BorderRadius.zero,
                  child: Row(
                    children: [
                      AspectRatio(
                        aspectRatio: 4 / 3,
                        child: ClipRRect(
                          borderRadius: borderRadius ?? BorderRadius.zero,
                          child: ShowImage(course.imageUrl!),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                            padding * 2,
                            padding,
                            padding,
                            padding,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                courseTitle,
                                style: textTheme.subtitle1,
                              ),
                              SizedBox(
                                height: padding,
                              ),
                              Text(
                                course.name!,
                                style: textTheme.headline6,
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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

class BuildAbout extends StatelessWidget {
  const BuildAbout({
    Key? key,
    required this.about,
    required this.padding,
  }) : super(key: key);

  final About? about;
  final double padding;

  void onTap({
    required CurrentRoute currentRoute,
    required DrawerState drawerState,
  }) {
    drawerState.controller.forward();
    drawerState.changeState(true);
    Timer(Duration(milliseconds: 300), () {
      currentRoute.setRoute(MyRoutes.about);
    });
    Timer(Duration(milliseconds: 300), () {
      drawerState.controller.reverse();
      drawerState.changeState(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Consumer2(
      builder:
          (context, CurrentRoute currentRoute, DrawerState drawerState, child) {
        return AspectRatio(
          aspectRatio: 1,
          child: CustomCard(
            child: InkWell(
              onTap: () =>
                  onTap(currentRoute: currentRoute, drawerState: drawerState),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: UIConfigurations.bgCardBorderRadius,
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ShowImage(about!.imageUrl),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: padding * 2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          about!.title!,
                          style: textTheme.headline5,
                        ),
                        IconButton(
                          onPressed: () => onTap(
                              currentRoute: currentRoute,
                              drawerState: drawerState),
                          icon: Icon(MyIcons.arrow_right),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: padding * 2,
                    ),
                    child: Text(
                      about!.description!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class BuildEvents extends StatelessWidget {
  const BuildEvents({
    Key? key,
    required this.noticeBoard,
  }) : super(key: key);

  final List<NoticeBoard?>? noticeBoard;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: noticeBoard!.length,
        itemBuilder: (_, index) {
          final NoticeBoard notice = noticeBoard![index]!;
          return AspectRatio(
            aspectRatio: 3 / 2,
            child: CustomCard(
              borderRadius: UIConfigurations.smallCardBorderRadius,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: UIConfigurations.smallCardBorderRadius,
                      child: ShowImage(notice.imageUrl!),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  notice.topic!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                if (notice.lastDate != null)
                                  Text(
                                    notice.lastDate!,
                                    style: textTheme.overline,
                                  ),
                                Text(
                                  notice.description!,
                                  style: textTheme.caption,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                ),
                              ],
                            ),
                          ),
                          if (notice.links != null)
                            notice.links!.length == 1
                                ? notice.links![0]!.important!
                                    ? ElevatedButton(
                                        onPressed: () => Utils.openLink(
                                            url: notice.links![0]!.url!),
                                        child: Text(
                                            notice.links![0]!.displayText!),
                                      )
                                    : OutlinedButton(
                                        onPressed: () => Utils.openLink(
                                            url: notice.links![0]!.url!),
                                        child: Text(
                                            notice.links![0]!.displayText!),
                                      )
                                : OutlinedButton(
                                    child: Text(
                                      'Links',
                                    ),
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor:
                                              Theme.of(context).cardTheme.color,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: UIConfigurations
                                                .smallCardBorderRadius,
                                          ),
                                          title: Text('Links'),
                                          content: AspectRatio(
                                            aspectRatio: 4 / 3,
                                            child: Wrap(
                                              spacing: 10.0,
                                              alignment:
                                                  WrapAlignment.spaceEvenly,
                                              children: [
                                                for (Link? link
                                                    in notice.links!)
                                                  link!.important!
                                                      ? ElevatedButton(
                                                          onPressed: () =>
                                                              Utils.openLink(
                                                                  url: link
                                                                      .url!),
                                                          child: Text(link
                                                              .displayText!),
                                                        )
                                                      : OutlinedButton(
                                                          onPressed: () =>
                                                              Utils.openLink(
                                                                  url: link
                                                                      .url!),
                                                          child: Text(link
                                                              .displayText!),
                                                        ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            TextButton.icon(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              label: Text('Close'),
                                              icon: Icon(Icons.close),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class BuildSlideShow extends StatelessWidget {
  final List<String?>? slides;

  const BuildSlideShow({Key? key, this.slides}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: slides!.length,
        itemBuilder: (_, index) {
          final String url = slides![index]!;
          return AspectRatio(
            aspectRatio: 16 / 9,
            child: CustomCard(
              child: ShowImage(url),
            ),
          );
        },
      ),
    );
  }
}
