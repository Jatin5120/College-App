import 'package:college_app/constants/constants.dart';
import 'package:college_app/data/data.dart';
import 'package:college_app/modals/modals.dart';
import 'package:college_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(MyRoutes.about),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapShot) {
        if (snapShot.hasData) {
          final AboutModal aboutModal = AboutModal.fromJson(snapShot.data);
          return AboutPage(aboutModal: aboutModal);
        } else {
          return _BuildLoadingAbout();
        }
      },
    );
  }
}

class _BuildLoadingAbout extends StatelessWidget {
  const _BuildLoadingAbout({
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
            aspectRatio: 2 / 3,
          ),
        ],
      ),
    );
  }
}

class AboutPage extends StatefulWidget {
  AboutPage({Key? key, required this.aboutModal}) : super(key: key);

  final AboutModal aboutModal;

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late AboutData aboutData;

  late AboutOrganization? about;
  late List<Team?>? governingBody;
  late List<Team?>? coreTeam;
  late String? address;
  late List<String?>? phones;
  late List<String?>? emails;
  late SocialMedia? socialMedia;

  @override
  void initState() {
    super.initState();
    aboutData = widget.aboutModal.data!;
    about = aboutData.about!;
    governingBody = aboutData.governingBody!;
    coreTeam = aboutData.coreTeam!;
    address = aboutData.address!;
    phones = aboutData.phones;
    emails = aboutData.emails!;
    socialMedia = aboutData.socialMedia!;
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
          padding: EdgeInsets.symmetric(vertical: padding),
          child: Text(
            aboutData.title!,
            style: textTheme.headline4!.copyWith(fontWeight: FontWeight.w600),
            overflow: TextOverflow.clip,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: size.height / 40),
        AspectRatio(
          aspectRatio: 15 / 9,
          child: CustomCard(
            child: ShowImage(aboutData.imageUrl!),
          ),
        ),
        BuildSubHeader(title: 'About', padding: padding),
        BuildAboutSection(padding: padding, about: about),
        BuildSubHeader(title: 'Vision', padding: padding, icon: MyIcons.vision),
        BuildParagraph(padding: padding, paragraph: aboutData.vision!),
        BuildSubHeader(
            title: 'Mission', padding: padding, icon: MyIcons.mission),
        BuildParagraph(padding: padding, paragraph: aboutData.mission!),
        BuildSubHeader(title: 'Governing Body', padding: padding),
        BuildTeamCard(
            teams: governingBody, padding: padding, isCoreTeam: false),
        BuildSubHeader(title: 'Core Team', padding: padding, icon: Icons.group),
        BuildTeamCard(teams: coreTeam, padding: padding, isCoreTeam: true),
        BuildSubHeader(
            title: 'Contacts', padding: padding, icon: Icons.contacts),
        BuildContacts(
          padding: padding,
          address: address,
          phones: phones,
          emails: emails,
          socialMedia: socialMedia,
        ),
        UIConfigurations.spaceBottom(size),
      ],
    );
  }
}

class BuildTeamCard extends StatelessWidget {
  const BuildTeamCard({
    Key? key,
    required this.teams,
    required this.padding,
    required this.isCoreTeam,
  }) : super(key: key);

  final List<Team?>? teams;
  final double padding;
  final bool isCoreTeam;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return AspectRatio(
      aspectRatio: 1,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: teams!.length,
        itemBuilder: (context, index) {
          final Team team = teams![index]!;
          return CustomCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 5 / 3,
                  child: ClipRRect(
                    borderRadius: UIConfigurations.bgCardBorderRadius,
                    child: ShowImage(team.imageUrl!),
                  ),
                ),
                if (!isCoreTeam) SizedBox(height: padding * 3),
                Padding(
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    children: [
                      Text(
                        team.name!,
                        style: textTheme.headline4,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        team.designation!,
                        style: textTheme.headline5,
                      ),
                    ],
                  ),
                ),
                if (isCoreTeam)
                  OutlinedButton(
                    child: Text(
                      'Show Message',
                    ),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Theme.of(context).cardTheme.color,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                UIConfigurations.smallCardBorderRadius,
                          ),
                          title: Text(team.name!),
                          content: AspectRatio(
                            aspectRatio: 3 / 4,
                            child: ListView(
                              children: [
                                Text(team.message!),
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
          );
        },
      ),
    );
  }
}

class BuildAboutSection extends StatelessWidget {
  const BuildAboutSection({
    Key? key,
    required this.padding,
    required this.about,
  }) : super(key: key);

  final double padding;
  final AboutOrganization? about;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding * 3,
        vertical: padding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'LKCTC',
            style: textTheme.headline5,
          ),
          SizedBox(height: padding),
          Text(
            about!.lkctc!,
            style: textTheme.bodyText1,
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: padding * 3),
          Text(
            'TRUST',
            style: textTheme.headline5,
          ),
          SizedBox(height: padding),
          Text(
            about!.trust!,
            style: textTheme.bodyText1,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
