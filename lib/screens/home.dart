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
    final Size size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: fetchData(MyRoutes.home),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapShot) {
        if (snapShot.hasData) {
          return HomePage(snapShot: snapShot);
        } else {
          return BuildLoadingHome(size: size);
        }
      },
    );
  }
}

class BuildLoadingHome extends StatelessWidget {
  const BuildLoadingHome({
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

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.snapShot}) : super(key: key);

  final AsyncSnapshot<dynamic> snapShot;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  @override
  void initState() {
    super.initState();
    data = widget.snapShot.data['data'];
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
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double padding = (size.width / 40).roundToDouble();
    return ListView(
      children: <Widget>[
        SizedBox(height: size.height / 10),
        BuildSlideShow(slides: slides),
        BuildSubHeaderHome(title: 'Events', padding: padding, onPressed: () {}),
        BuildEvents(noticeBoard: noticeBoard),
        BuildSubHeaderHome(title: 'About', padding: padding, onPressed: () {}),
        BuildAbout(about: about, padding: padding),
        BuildSubHeaderHome(
            title: 'Courses', padding: padding, onPressed: () {}),
        for (int i = 0; i < bsc.length; i++)
          SmallDetailCard(
            padding: padding,
            borderRadius: UIConfigurations.smallCardBorderRadius,
            courseTitle: 'B.Sc',
            name: bsc[i]['name'],
            imageUrl: bsc[i]['imageUrl'],
          ),
        for (int i = 0; i < btech.length; i++)
          SmallDetailCard(
            padding: padding,
            borderRadius: UIConfigurations.smallCardBorderRadius,
            courseTitle: 'B.Tech',
            name: btech[i]['name'],
            imageUrl: btech[i]['imageUrl'],
          ),
        for (int i = 0; i < bvoc.length; i++)
          SmallDetailCard(
            padding: padding,
            borderRadius: UIConfigurations.smallCardBorderRadius,
            courseTitle: 'B.Voc',
            name: bvoc[i]['name'],
            imageUrl: bvoc[i]['imageUrl'],
          ),
        for (int i = 0; i < diploma.length; i++)
          SmallDetailCard(
            padding: padding,
            borderRadius: UIConfigurations.smallCardBorderRadius,
            courseTitle: 'Diploma',
            name: diploma[i]['name'],
            imageUrl: diploma[i]['imageUrl'],
          ),
        BuildSubHeaderHome(
            title: 'Testimonials', padding: padding, onPressed: () {}),
        BuildTestimonials(testimonials: testimonials, padding: padding),
        BuildSubHeaderHome(
            title: 'News & Headlines', padding: padding, onPressed: () {}),
        BuildNews(news: news, padding: padding),
        BuildSubHeaderHome(
            title: 'Industrial Visits', padding: padding, onPressed: () {}),
        for (Map<String, dynamic> visit in industrialVisits)
          BuildSwipableImageCard(item: visit, padding: padding),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Consumer<CurrentRoute>(
              builder: (context, currentRoute, child) {
                return OutlinedButton(
                  child: Text(
                    'Need Help?',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  onPressed: () => currentRoute.setRoute(MyRoutes.about),
                );
              },
            ),
          ),
        ),
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

  final List news;
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
    required this.testimonials,
    required this.padding,
  }) : super(key: key);

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
    required this.padding,
    required this.courseTitle,
    required this.name,
    required this.imageUrl,
    this.borderRadius,
  }) : super(key: key);

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
        margin: UIConfigurations.margin.copyWith(top: 10),
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
    required this.about,
    required this.padding,
  }) : super(key: key);

  final Map<String, dynamic> about;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrentRoute>(
      builder: (context, currentRoute, child) {
        return AspectRatio(
          aspectRatio: 1,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: UIConfigurations.bgCardBorderRadius,
            ),
            child: ClipRRect(
              borderRadius: UIConfigurations.bgCardBorderRadius,
              child: InkWell(
                onTap: () => currentRoute.setRoute(MyRoutes.about),
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
                            onPressed: () =>
                                currentRoute.setRoute(MyRoutes.about),
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
      },
    );
  }
}

class BuildEvents extends StatelessWidget {
  const BuildEvents({
    Key? key,
    required this.noticeBoard,
  }) : super(key: key);

  final List noticeBoard;

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
  final List<dynamic>? slides;

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
            child: Card(
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
