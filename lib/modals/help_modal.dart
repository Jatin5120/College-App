import 'common.dart';

class HelpModal {
  String? website;
  String? address;
  List<String?>? phone;
  List<String?>? email;
  SocialMedia? socialMedia;
  List<UsefulLinks?>? usefulLinks;
  List<Faq?>? faq;

  HelpModal(
      {this.website,
      this.address,
      this.phone,
      this.email,
      this.socialMedia,
      this.usefulLinks,
      this.faq});

  HelpModal.fromJson(Map<String, dynamic> json) {
    website = json['website'];
    address = json['address'];
    phone = json['phone'].cast<String?>();
    email = json['email'].cast<String?>();
    socialMedia = json['social_media'] != null
        ? SocialMedia.fromJson(json['social_media'])
        : null;
    if (json['useful_links'] != null) {
      usefulLinks = <UsefulLinks>[];
      json['useful_links'].forEach((v) {
        usefulLinks!.add(UsefulLinks.fromJson(v));
      });
    }
    if (json['faq'] != null) {
      faq = <Faq>[];
      json['faq'].forEach((v) {
        faq!.add(Faq.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['website'] = this.website;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['email'] = this.email;
    if (this.socialMedia != null) {
      data['social_media'] = this.socialMedia!.toJson();
    }
    if (this.usefulLinks != null) {
      data['useful_links'] = this.usefulLinks!.map((v) => v!.toJson()).toList();
    }
    if (this.faq != null) {
      data['faq'] = this.faq!.map((v) => v!.toJson()).toList();
    }
    return data;
  }
}

class UsefulLinks {
  String? text;
  String? url;

  UsefulLinks({this.text, this.url});

  UsefulLinks.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['text'] = this.text;
    data['url'] = this.url;
    return data;
  }
}

class Faq {
  String? question;
  String? answer;

  Faq({this.question, this.answer});

  Faq.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['question'] = this.question;
    data['answer'] = this.answer;
    return data;
  }
}
