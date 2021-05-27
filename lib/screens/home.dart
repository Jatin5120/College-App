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
    // getData();
    return MyPage(
      title: 'Home',
      child: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapShot) {
          if (snapShot.hasData) {
            return HomePage(snapShot: snapShot);
          } else {
            return BuildLoading(size: size);
          }
        },
      ),
    );
  }
}

class BuildLoading extends StatelessWidget {
  const BuildLoading({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return MyShimmerEffect(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          SizedBox(height: size.height / 10),
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
  late List<dynamic> industrialVisits;

  HomePage({Key? key, required this.snapShot}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double padding = (size.width / 40).roundToDouble();
    final EdgeInsets margin = EdgeInsets.all(20.0);
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
    industrialVisits = data['industrial_visits'];
    return ListView(
      children: <Widget>[
        SizedBox(height: size.height / 10),
        BuildSlideShow(margin: margin, slides: slides),
        SubHeader(title: 'Events', padding: padding, onPressed: () {}),
        BuildEvents(noticeBoard: noticeBoard, margin: margin),
        SubHeader(title: 'About', padding: padding, onPressed: () {}),
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
        BuildTestimonials(
            margin: margin, testimonials: testimonials, padding: padding),
        SubHeader(
            title: 'News & Headlines', padding: padding, onPressed: () {}),
        BuildNews(news: news, margin: margin, padding: padding),
        SubHeader(
            title: 'Industrial Visits', padding: padding, onPressed: () {}),
        for (int i = 0; i < industrialVisits.length; i++)
          BuildIndustrialVisits(
              margin: margin,
              industrialVisits: industrialVisits,
              i: i,
              padding: padding),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: OutlinedButton(
              child: Text(
                'Need Help?',
                style: Theme.of(context).textTheme.headline6,
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }
}

class BuildIndustrialVisits extends StatelessWidget {
  const BuildIndustrialVisits({
    Key? key,
    required this.margin,
    required this.industrialVisits,
    required this.i,
    required this.padding,
  }) : super(key: key);

  final EdgeInsets margin;
  final List industrialVisits;
  final int i;
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
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: UIConfigurations.bgCardBorderRadius,
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: industrialVisits[i]['images'].length,
                    itemBuilder: (context, index) {
                      return ShowImage(industrialVisits[i]['images'][index]);
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: padding * 2,
                  vertical: padding,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      industrialVisits[i]['title'],
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: padding),
                    Text(
                      industrialVisits[i]['description'],
                      style: Theme.of(context).textTheme.bodyText2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.justify,
                      maxLines: 6,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildNews extends StatelessWidget {
  const BuildNews({
    Key? key,
    required this.news,
    required this.margin,
    required this.padding,
  }) : super(key: key);

  final List news;
  final EdgeInsets margin;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: news.length,
        itemBuilder: (_, index) {
          return AspectRatio(
            aspectRatio: 3 / 2,
            child: Card(
              margin: margin,
              shape: RoundedRectangleBorder(
                  borderRadius: UIConfigurations.smallCardBorderRadius),
              child: ClipRRect(
                borderRadius: UIConfigurations.smallCardBorderRadius,
                child: Row(
                  children: [
                    AspectRatio(
                      aspectRatio: 9 / 8,
                      child: ClipRRect(
                        borderRadius: UIConfigurations.smallCardBorderRadius,
                        child: ShowImage(news[index]['imageUrl']),
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
                              news[index]['headline'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 7,
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: padding * 2,
                            ),
                            Text(
                              news[index]['date'],
                              style: Theme.of(context).textTheme.overline,
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
    required this.margin,
    required this.testimonials,
    required this.padding,
  }) : super(key: key);

  final EdgeInsets margin;
  final List testimonials;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: testimonials.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Card(
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
                      child: ShowImage(testimonials[index]['imageUrl']),
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
                              '${testimonials[index]['name']}  |  ',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            Text(
                              testimonials[index]['department'],
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: padding * 1.5,
                        ),
                        Text(
                          testimonials[index]['quote'],
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
          );
        },
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
                                              notice['links']['submissionLinks']
                                                          .length ==
                                                      1
                                                  ? 'Submit'
                                                  : 'Submit ${i + 1}',
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
