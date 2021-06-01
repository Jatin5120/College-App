import 'package:url_launcher/url_launcher.dart';

class Utils {
  static Future _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Cannot Launch $url");
    }
  }

  static Future openLink({required String url}) => _launchUrl(url);

  static Future openMail(
      {required String mailTo, String? subject, String? body}) async {
    final String sub =
        subject == null ? '' : "subject=${Uri.encodeFull(subject)}";
    final String bod = body == null ? '' : "body=${Uri.encodeFull(body)}";
    final String parameter = (sub == '' && bod == '') ? '' : '?$sub&$bod';
    final String url = "mailto:$mailTo$parameter";
    await _launchUrl(url);
  }

  static Future openMap() async {
    final String lat = '31.3100078250989';
    final String long = '75.5998485977711';
    final String mapLink =
        'https://www.google.com/maps/place/Lyallpur+Khalsa+College+of+Engineering/@31.3099839,75.5998114,17.59z/data=!4m5!3m4!1s0x391a5bcafd49b20d:0x37964acc19f66dca!8m2!3d31.3098016!4d75.5998486';

    final String googleMapsUrl = "comgooglemaps://?center=$lat,$long";
    final String appleMapsUrl = "https://maps.apple.com/?q=$lat,$long";

    if (await canLaunch(mapLink)) {
      await launch(mapLink);
    } else if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else if (await canLaunch(appleMapsUrl)) {
      await launch(appleMapsUrl, forceSafariVC: false);
    } else {
      print("Couldn't launch URL");
    }
  }

  static Future openCall({required String phone}) async {
    final String url = 'tel:$phone';
    await _launchUrl(url);
  }
}
