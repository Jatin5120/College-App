import 'package:college_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:college_app/widgets/widgets.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
// import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final url = 'http://192.168.1.1:80/';
  late Map<String, dynamic> data;

  Future<Map<String, dynamic>> getData() async {
    // http.Response response = await http.get(Uri.parse(url));
    try {
      print("Reading");
      String jsonResult = await rootBundle.loadString("assets/api/home.json");
      data = json.decode(jsonResult);
      // print(data);
      String test = data['baseUrl'];
      print(test);
      return data;
    } catch (e) {
      debugPrint("Didn't get data\nError: $e");
      return {'data': "No data"};
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double padding = (size.width / 40).roundToDouble();
    final EdgeInsets margin = EdgeInsets.symmetric(horizontal: 20);
    // getData();
    return MyPage(
      title: 'Home',
      child: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapShot) {
          if (snapShot.hasData) {
            return HomePage(snapShot: snapShot);
          } else {
            return Container(
              child: Center(
                child: Text('No data'),
              ),
            );
          }
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  final AsyncSnapshot<dynamic> snapShot;
  late Map<String, dynamic> data;
  late List<dynamic> slides;
  late List<dynamic> noticeBoard;
  late Map<String, dynamic> about;
  late List<dynamic> bsc;
  late List<dynamic> btech;
  late List<dynamic> bvoc;
  late List<dynamic> diploma;
  late List<dynamic> testimonials;
  late List<dynamic> news;

  HomePage({Key? key, required this.snapShot}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double padding = (size.width / 40).roundToDouble();
    final EdgeInsets margin = EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 20.0,
    );
    data = snapShot.data['data'];
    slides = data['slideShow'];
    noticeBoard = data['noticeBoard'].reversed.toList();
    about = data['about'];
    bsc = data['courses']['bsc'];
    btech = data['courses']['btech'];
    bvoc = data['courses']['bvoc'];
    diploma = data['courses']['diploma'];
    testimonials = data['testimonials'];
    news = data['news'];
    return ListView(
      children: <Widget>[
        SizedBox(height: size.height / 10),
        BuildSlideShow(margin: margin, slides: slides),
        SubHeader(title: 'Events', padding: padding, onPressed: () {}),
        BuildEvents(noticeBoard: noticeBoard, margin: margin),
        BuildAbout(margin: margin, about: about, padding: padding),
        SubHeader(title: 'Courses', padding: padding, onPressed: () {}),
        for (int i = 0; i < bsc.length; i++)
          SmallDetailCard(
            margin: margin,
            padding: padding,
            borderRadius: UIConfigurations.smallCardBorderRadius,
            courseTitle: 'B.Sc',
            name: bsc[i]['name'],
            imageUrl: bsc[i]['imageUrl'],
          ),
        for (int i = 0; i < btech.length; i++)
          SmallDetailCard(
            margin: margin,
            padding: padding,
            borderRadius: UIConfigurations.smallCardBorderRadius,
            courseTitle: 'B.Tech',
            name: btech[i]['name'],
            imageUrl: btech[i]['imageUrl'],
          ),
        for (int i = 0; i < bvoc.length; i++)
          SmallDetailCard(
            margin: margin,
            padding: padding,
            borderRadius: UIConfigurations.smallCardBorderRadius,
            courseTitle: 'B.Voc',
            name: bvoc[i]['name'],
            imageUrl: bvoc[i]['imageUrl'],
          ),
        for (int i = 0; i < diploma.length; i++)
          SmallDetailCard(
            margin: margin,
            padding: padding,
            borderRadius: UIConfigurations.smallCardBorderRadius,
            courseTitle: 'Diploma',
            name: diploma[i]['name'],
            imageUrl: diploma[i]['imageUrl'],
          ),
        SubHeader(title: 'Testimonials', padding: padding, onPressed: () {}),
        for (int i = 0; i < testimonials.length; i++)
          BuildTestimonial(
              margin: margin, testimonial: testimonials[i], padding: padding),
      ],
    );
  }
}

class BuildTestimonial extends StatelessWidget {
  const BuildTestimonial({
    Key? key,
    required this.margin,
    required this.testimonial,
    required this.padding,
  }) : super(key: key);

  final EdgeInsets margin;
  final Map<String, dynamic> testimonial;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        margin: margin,
        shape: RoundedRectangleBorder(
            borderRadius: UIConfigurations.bgCardBorderRadius),
        child: ClipRRect(
          borderRadius: UIConfigurations.bgCardBorderRadius,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: UIConfigurations.bgCardBorderRadius,
                child: AspectRatio(
                  aspectRatio: 20 / 9,
                  child: ShowImage(testimonial['imageUrl']),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: padding * 2,
                  vertical: padding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      testimonial['name'],
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      testimonial['department'],
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: padding * 1.5,
                    ),
                    Text(
                      testimonial['quote'],
                      style: Theme.of(context).textTheme.bodyText2,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 7,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SmallDetailCard extends StatelessWidget {
  const SmallDetailCard({
    Key? key,
    required this.margin,
    required this.padding,
    required this.courseTitle,
    required this.name,
    required this.imageUrl,
    this.borderRadius,
  }) : super(key: key);

  final EdgeInsets margin;
  final double padding;
  final String courseTitle;
  final String name;
  final String imageUrl;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5 / 2,
      child: Card(
        margin: margin.copyWith(top: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.zero,
        ),
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.zero,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 4 / 3,
                child: ClipRRect(
                  borderRadius: borderRadius ?? BorderRadius.zero,
                  child: ShowImage(imageUrl),
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
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(
                        height: padding,
                      ),
                      Text(
                        name,
                        style: Theme.of(context).textTheme.headline6,
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
    );
  }
}

class BuildAbout extends StatelessWidget {
  const BuildAbout({
    Key? key,
    required this.margin,
    required this.about,
    required this.padding,
  }) : super(key: key);

  final EdgeInsets margin;
  final Map<String, dynamic> about;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        margin: margin,
        shape: RoundedRectangleBorder(
          borderRadius: UIConfigurations.bgCardBorderRadius,
        ),
        child: ClipRRect(
          borderRadius: UIConfigurations.bgCardBorderRadius,
          child: InkWell(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: UIConfigurations.bgCardBorderRadius,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ShowImage(about['imageUrl']),
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
                        about['title'],
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      IconButton(
                        onPressed: () {},
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
                    about['description'],
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BuildEvents extends StatelessWidget {
  const BuildEvents({
    Key? key,
    required this.noticeBoard,
    required this.margin,
  }) : super(key: key);

  final List noticeBoard;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: noticeBoard.length,
        itemBuilder: (_, index) {
          final Map<String, dynamic> notice = noticeBoard[index];
          return AspectRatio(
            aspectRatio: 3 / 2,
            child: Card(
              margin: margin,
              shape: RoundedRectangleBorder(
                borderRadius: UIConfigurations.smallCardBorderRadius,
              ),
              child: ClipRRect(
                borderRadius: UIConfigurations.smallCardBorderRadius,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ClipRRect(
                        borderRadius: UIConfigurations.smallCardBorderRadius,
                        child: ShowImage(notice['imageUrl']),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              notice['topic'],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              notice['lastDate'] ?? '',
                              style: Theme.of(context).textTheme.overline,
                            ),
                            Text(
                              notice['description'],
                              style: Theme.of(context).textTheme.bodyText2,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                            ),
                            notice['links'] != null
                                ? Wrap(
                                    spacing: 10.0,
                                    alignment: WrapAlignment.spaceEvenly,
                                    children: [
                                      if (notice['links']['registration'] !=
                                          null)
                                        OutlinedButton(
                                          child: Text('Register'),
                                          onPressed: () {},
                                        ),
                                      if (notice['links']['rules'] != null)
                                        TextButton(
                                          child: Text('Rules'),
                                          onPressed: () {},
                                        ),
                                      if (notice['links']['submissionLinks'] !=
                                          null)
                                        for (int i = 0;
                                            i <
                                                notice['links']
                                                        ['submissionLinks']
                                                    .length;
                                            i++)
                                          ElevatedButton(
                                            child: Text(
                                              'Submit ${i + 1}',
                                              style: TextStyle().copyWith(
                                                color: MediaQuery
                                                            .platformBrightnessOf(
                                                                context) ==
                                                        Brightness.dark
                                                    ? MyColors.darkForeground
                                                    : null,
                                              ),
                                            ),
                                            onPressed: () {},
                                          ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BuildSlideShow extends StatelessWidget {
  final EdgeInsets? margin;
  final List<dynamic>? slides;

  const BuildSlideShow({Key? key, this.margin, this.slides}) : super(key: key);
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
            child: Card(
              margin: margin,
              shape: RoundedRectangleBorder(
                borderRadius: UIConfigurations.bgCardBorderRadius,
              ),
              elevation: UIConfigurations.elevation,
              child: ClipRRect(
                borderRadius: UIConfigurations.bgCardBorderRadius,
                child: ShowImage(url),
              ),
            ),
          );
        },
      ),
    );
  }
}
