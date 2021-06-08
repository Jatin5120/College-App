import 'package:college_app/constants/constants.dart';
import 'package:college_app/data/data.dart';
import 'package:college_app/modals/modals.dart';
import 'package:college_app/utils.dart';
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
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapShot) {
        if (snapShot.hasData) {
          final AchievementModal achievementModal =
              AchievementModal.fromJson(snapShot.data);
          return AchievementPage(achievementModal: achievementModal);
        } else {
          return _BuildLoadingAchievement();
        }
      },
    );
  }
}

class _BuildLoadingAchievement extends StatelessWidget {
  const _BuildLoadingAchievement({
    Key? key,
  }) : super(key: key);

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
            aspectRatio: 4 / 1,
          ),
          SizedBox(height: size.height / 25),
          ShaderWidget(
            borderRadius: UIConfigurations.bgCardBorderRadius,
            aspectRatio: 1,
          ),
          SizedBox(height: size.height / 25),
          ShaderWidget(
            borderRadius: UIConfigurations.smallCardBorderRadius,
            aspectRatio: 1,
          ),
        ],
      ),
    );
  }
}

class AchievementPage extends StatefulWidget {
  const AchievementPage({Key? key, required this.achievementModal})
      : super(key: key);

  final AchievementModal achievementModal;

  @override
  _AchievementPageState createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage> {
  late AchievementData achievementData;

  late Awards? allAward;
  late Achievements? allAchievement;
  late Conferences? allConference;

  @override
  void initState() {
    super.initState();
    achievementData = widget.achievementModal.data!;
    allAward = achievementData.award;
    allAchievement = achievementData.achievement;
    allConference = achievementData.conference;
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    final double padding = (size.width / 40).roundToDouble();
    return ListView(
      children: [
        UIConfigurations.spaceTop(size),
        BuildSubHeader(padding: padding, title: allAward!.heading!),
        for (Award? award in allAward!.awards!)
          BuildSwipableImageCard(item: award!.toJson(), padding: padding),
        BuildSubHeader(padding: padding, title: allAchievement!.heading!),
        for (Achievement? achievement in allAchievement!.achievements!)
          BuildDescriptionCard(achievement: achievement, padding: padding),
        BuildSubHeader(padding: padding, title: allConference!.heading!),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: padding * 3, vertical: padding),
          child: Text(
            allConference!.description!,
            style: textTheme.bodyText1,
            textAlign: TextAlign.justify,
          ),
        ),
        for (Conference? conference in allConference!.conferences!)
          BuildConference(conference: conference, padding: padding),
        UIConfigurations.spaceBottom(size),
      ],
    );
  }
}

class BuildConference extends StatelessWidget {
  const BuildConference({
    Key? key,
    required this.conference,
    required this.padding,
  }) : super(key: key);

  final Conference? conference;
  final double padding;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return AspectRatio(
      aspectRatio: conference!.links != null ? 1.65 / 2 : 2 / 1.8,
      child: CustomCard(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: UIConfigurations.bgCardBorderRadius,
                child: PageView.builder(
                  itemCount: conference!.images!.length,
                  itemBuilder: (context, index) {
                    return ShowImage(conference!.images![index]);
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(padding * 2),
              child: Column(
                children: [
                  Text(
                    conference!.topic!,
                    style: textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: padding),
                  if (conference!.links != null)
                    Wrap(
                      spacing: 10.0,
                      alignment: WrapAlignment.spaceEvenly,
                      children: [
                        for (Link? link in conference!.links!)
                          link!.important!
                              ? ElevatedButton(
                                  onPressed: () =>
                                      Utils.openLink(url: link.url!),
                                  child: Text(link.displayText!),
                                )
                              : OutlinedButton(
                                  onPressed: () =>
                                      Utils.openLink(url: link.url!),
                                  child: Text(link.displayText!),
                                ),
                      ],
                    ),
                  // SizedBox(height: padding * 2),
                  InkWell(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Theme.of(context).cardTheme.color,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                UIConfigurations.smallCardBorderRadius,
                          ),
                          title: Text(
                            conference!.topic!,
                            textAlign: TextAlign.center,
                          ),
                          content: AspectRatio(
                            aspectRatio: 3 / 4,
                            child: Scrollbar(
                              child: ListView(
                                children: [
                                  Text(conference!.description!),
                                ],
                              ),
                            ),
                          ),
                          actionsPadding: EdgeInsets.symmetric(
                              horizontal: padding * 2, vertical: padding),
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Read more',
                            style: textTheme.button,
                          ),
                          SizedBox(width: padding / 2),
                          Icon(MyIcons.arrow_down),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildDescriptionCard extends StatelessWidget {
  const BuildDescriptionCard({
    Key? key,
    required this.achievement,
    required this.padding,
  }) : super(key: key);

  final Achievement? achievement;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: CustomCard(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: UIConfigurations.bgCardBorderRadius,
              child: AspectRatio(
                aspectRatio: 20 / 9,
                child: ShowImage(achievement!.imageUrl),
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
                    '${achievement!.heading!}',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: padding * 1.5,
                  ),
                  Text(
                    achievement!.description!,
                    style: Theme.of(context).textTheme.bodyText2,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 7,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
