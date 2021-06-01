import 'package:college_app/constants/constants.dart';
import 'package:college_app/data/data.dart';
import 'package:college_app/utils.dart';
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
          return AboutPage(snapShot: snapShot);
        } else {
          return BuildLoadingAbout();
        }
      },
    );
  }
}

class BuildLoadingAbout extends StatelessWidget {
  const BuildLoadingAbout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MyShimmerEffect(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          SizedBox(height: size.height / 8),
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
  AboutPage({Key? key, required this.snapShot}) : super(key: key);

  final AsyncSnapshot<dynamic> snapShot;

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late Map<String, dynamic> data;
  late Map<String, dynamic> about;
  late List<dynamic> governingBody;
  late List<dynamic> coreTeam;
  late String address;
  late List<dynamic> phones;
  late List<dynamic> emails;
  late Map<String, dynamic> socialMedia;

  @override
  void initState() {
    super.initState();
    data = widget.snapShot.data['data'];
    about = data['about'];
    governingBody = data['governing_body'];
    coreTeam = data['core_team'];
    address = data['address'];
    phones = data['phone'];
    emails = data['email'];
    socialMedia = data['social_media'];
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;
    final double padding = (size.width / 40).roundToDouble();
    return ListView(
      children: [
        SizedBox(height: size.height / 8),
        Text(
          data['title'],
          style: textTheme.headline4!.copyWith(fontWeight: FontWeight.w600),
          overflow: TextOverflow.clip,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: size.width / 12),
        AspectRatio(
          aspectRatio: 15 / 9,
          child: Card(
            margin: UIConfigurations.margin,
            shape: RoundedRectangleBorder(
              borderRadius: UIConfigurations.bgCardBorderRadius,
            ),
            child: ClipRRect(
              borderRadius: UIConfigurations.bgCardBorderRadius,
              child: ShowImage(data['imageUrl']),
            ),
          ),
        ),
        BuildSubHeader(title: 'About', padding: padding),
        BuildAboutSection(padding: padding, about: about),
        BuildSubHeader(title: 'Vision', padding: padding, icon: MyIcons.vision),
        BuildParagraph(padding: padding, paragraph: data['vision']),
        BuildSubHeader(
            title: 'Mission', padding: padding, icon: MyIcons.mission),
        BuildParagraph(padding: padding, paragraph: data['mission']),
        BuildSubHeader(title: 'Governing Body', padding: padding),
        BuildTeamCard(team: governingBody, padding: padding, isCoreTeam: false),
        BuildSubHeader(title: 'Core Team', padding: padding, icon: Icons.group),
        BuildTeamCard(team: coreTeam, padding: padding, isCoreTeam: true),
        BuildSubHeader(
            title: 'Contacts', padding: padding, icon: Icons.contacts),
        BuildContacts(
            padding: padding,
            address: address,
            phones: phones,
            emails: emails,
            socialMedia: socialMedia),
        SizedBox(height: size.height / 15),
      ],
    );
  }
}

class BuildTeamCard extends StatelessWidget {
  const BuildTeamCard({
    Key? key,
    required this.team,
    required this.padding,
    required this.isCoreTeam,
  }) : super(key: key);

  final List team;
  final double padding;
  final bool isCoreTeam;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return AspectRatio(
      aspectRatio: 1,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: team.length,
        itemBuilder: (context, index) {
          return Card(
            margin: UIConfigurations.margin,
            shape: RoundedRectangleBorder(
              borderRadius: UIConfigurations.bgCardBorderRadius,
            ),
            child: ClipRRect(
              borderRadius: UIConfigurations.bgCardBorderRadius,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: UIConfigurations.bgCardBorderRadius,
                    child: AspectRatio(
                      aspectRatio: 5 / 3,
                      child: ShowImage(team[index]['imageUrl']),
                    ),
                  ),
                  if (!isCoreTeam) SizedBox(height: padding * 3),
                  Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      children: [
                        Text(
                          team[index]['name'],
                          style: textTheme.headline4,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          team[index]['designation'],
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
                            title: Text(team[index]['name']),
                            content: AspectRatio(
                              aspectRatio: 3 / 4,
                              child: ListView(
                                children: [
                                  Text(team[index]['message']),
                                ],
                              ),
                            ),
                            actions: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
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
          );
        },
      ),
    );
  }
}

class BuildContacts extends StatelessWidget {
  const BuildContacts({
    Key? key,
    required this.padding,
    required this.address,
    required this.phones,
    required this.emails,
    required this.socialMedia,
  }) : super(key: key);

  final double padding;
  final String address;
  final List phones;
  final List emails;
  final Map<String, dynamic> socialMedia;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding * 3,
        vertical: padding,
      ),
      child: Column(
        children: <Widget>[
          BuildContactsRow(
            padding: padding,
            label: address,
            icon: Icon(MyIcons.location),
            linkType: LinkType.location,
          ),
          for (String phone in phones)
            BuildContactsRow(
              padding: padding,
              label: phone,
              icon: Icon(MyIcons.phone, size: 20.0),
              linkType: LinkType.phone,
            ),
          for (String email in emails)
            BuildContactsRow(
              padding: padding,
              label: email,
              icon: Icon(MyIcons.mail, size: 20.0),
              linkType: LinkType.mail,
            ),
          Padding(
            padding: EdgeInsets.all(padding * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BuildSocial(socialMedia: socialMedia, media: 'facebook'),
                BuildSocial(socialMedia: socialMedia, media: 'twitter'),
                BuildSocial(socialMedia: socialMedia, media: 'instagram'),
                BuildSocial(socialMedia: socialMedia, media: 'linkedin'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BuildSocial extends StatelessWidget {
  const BuildSocial({
    Key? key,
    required this.socialMedia,
    required this.media,
  }) : super(key: key);

  final Map<String, dynamic> socialMedia;
  final String media;

  @override
  Widget build(BuildContext context) {
    final String url = socialMedia[media];
    return InkWell(
      onTap: () => Utils.openLink(url: url),
      child: Image.asset(
        'assets/images/$media.png',
        height: 40.0,
        width: 40.0,
      ),
    );
  }
}

class BuildContactsRow extends StatelessWidget {
  const BuildContactsRow({
    Key? key,
    required this.padding,
    required this.label,
    required this.icon,
    required this.linkType,
  }) : super(key: key);

  final double padding;
  final String label;
  final Icon icon;
  final LinkType linkType;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Row(
        children: [
          icon,
          SizedBox(width: padding * 2),
          InkWell(
            onTap: () {
              switch (linkType) {
                case LinkType.location:
                  Utils.openMap();
                  break;
                case LinkType.mail:
                  Utils.openMail(
                    mailTo: label,
                    subject: '<Enter your Subject here>',
                    body:
                        '<Enter your body here>\n\nDo mention your details where we can contact you.',
                  );
                  break;
                case LinkType.phone:
                  Utils.openCall(phone: label);
                  break;
              }
            },
            child: Text(
              label,
              style: textTheme.bodyText1,
            ),
          )
        ],
      ),
    );
  }
}

class BuildParagraph extends StatelessWidget {
  const BuildParagraph({
    Key? key,
    required this.padding,
    required this.paragraph,
  }) : super(key: key);

  final double padding;
  final String paragraph;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding * 3,
        vertical: padding,
      ),
      child: Text(
        paragraph,
        style: textTheme.bodyText1,
        textAlign: TextAlign.justify,
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
  final Map<String, dynamic> about;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
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
            about['lkctc'],
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
            about['trust'],
            style: textTheme.bodyText1,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
