import 'package:college_app/constants/constants.dart';
import 'package:college_app/data/data.dart';
import 'package:college_app/widgets/sub_header.dart';
import 'package:college_app/widgets/swipable_image_card.dart';
import 'package:college_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AchievementScreen extends StatefulWidget {
  @override
  _AchievementScreenState createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(MyRoutes.achievements),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
          return AchievementPage(snapShot: snapShot);
        } else {
          return Center(
            child: Container(
              child: Text('Achievement Screen\nGot Data'),
            ),
          );
        }
      },
    );
  }
}

class AchievementPage extends StatefulWidget {
  const AchievementPage({
    Key? key,
    required this.snapShot,
  }) : super(key: key);

  final AsyncSnapshot<dynamic> snapShot;

  @override
  _AchievementPageState createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage> {
  late Map<String, dynamic> data;
  late Map<String, dynamic> awards;
  late Map<String, dynamic> achievements;
  late Map<String, dynamic> conferences;

  @override
  void initState() {
    super.initState();
    data = widget.snapShot.data['data'];
    awards = data['awards'];
    achievements = data['achievements'];
    conferences = data['conferences'];
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    final double padding = (size.width / 40).roundToDouble();
    return ListView(
      children: [
        SizedBox(height: size.height / 10),
        BuildSubHeader(padding: padding, title: awards['heading']),
        for (Map<String, dynamic> award in awards['awards'])
          BuildSwipableImageCard(item: award, padding: padding),
        BuildSubHeader(padding: padding, title: achievements['heading']),
        for (Map<String, dynamic> achievement in achievements['achievements'])
          BuildDescriptionCard(achievement: achievement, padding: padding),
        BuildSubHeader(padding: padding, title: conferences['heading']),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: padding * 3, vertical: padding),
          child: Text(
            conferences['description'],
            style: textTheme.bodyText1,
            textAlign: TextAlign.justify,
          ),
        ),
        for (Map<String, dynamic> conference in conferences['conferences'])
          AspectRatio(
            aspectRatio: conference['links'] != null ? 1.5 / 2 : 1,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: UIConfigurations.bgCardBorderRadius),
              child: ClipRRect(
                borderRadius: UIConfigurations.bgCardBorderRadius,
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: UIConfigurations.bgCardBorderRadius,
                        child: PageView.builder(
                          itemCount: conference['images'].length,
                          itemBuilder: (context, index) {
                            return ShowImage(conference['images'][index]);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(padding * 2),
                      child: Column(
                        children: [
                          Text(
                            conference['topic'],
                            style: textTheme.headline5,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: padding * 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (conference['links'] != null)
                                for (Map<String, dynamic> link
                                    in conference['links'])
                                  if (link['important'])
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: Text(
                                        link['display_text'],
                                      ),
                                    )
                                  else
                                    OutlinedButton(
                                      onPressed: () {},
                                      child: Text(
                                        link['display_text'],
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(height: padding * 2),
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Read more'),
                                  SizedBox(width: padding),
                                  Icon(MyIcons.arrow_down),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        SizedBox(height: size.height / 15),
      ],
    );
  }
}

class BuildDescriptionCard extends StatelessWidget {
  const BuildDescriptionCard({
    Key? key,
    required this.achievement,
    required this.padding,
  }) : super(key: key);

  final Map<String, dynamic> achievement;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
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
                  child: ShowImage(achievement['imageUrl']),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(padding * 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      '${achievement['heading']}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    SizedBox(
                      height: padding * 1.5,
                    ),
                    Text(
                      achievement['description'],
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
