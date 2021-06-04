import 'package:college_app/constants/constants.dart';
import 'package:college_app/modals/common.dart';
import 'package:college_app/utils.dart';
import 'package:flutter/material.dart';

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
  final String? address;
  final List<String?>? phones;
  final List<String?>? emails;
  final SocialMedia? socialMedia;

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
            label: address!,
            icon: Icon(MyIcons.location),
            linkType: LinkType.location,
          ),
          for (String? phone in phones!)
            BuildContactsRow(
              padding: padding,
              label: phone!,
              icon: Icon(MyIcons.phone, size: 20.0),
              linkType: LinkType.phone,
            ),
          for (String? email in emails!)
            BuildContactsRow(
              padding: padding,
              label: email!,
              icon: Icon(MyIcons.mail, size: 20.0),
              linkType: LinkType.mail,
            ),
          Padding(
            padding: EdgeInsets.all(padding * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BuildSocial(url: socialMedia!.facebook!, media: 'facebook'),
                BuildSocial(url: socialMedia!.twitter!, media: 'twitter'),
                BuildSocial(url: socialMedia!.instagram!, media: 'instagram'),
                BuildSocial(url: socialMedia!.linkedin!, media: 'linkedin'),
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
    required this.url,
    required this.media,
  }) : super(key: key);

  final String? url;
  final String media;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Utils.openLink(url: url!),
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
