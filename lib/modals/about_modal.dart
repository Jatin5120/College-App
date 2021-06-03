import 'common.dart';

class AboutModal {
  String? baseUrl;
  AboutData? data;

  AboutModal({this.baseUrl, this.data});

  AboutModal.fromJson(Map<String, dynamic> json) {
    baseUrl = json['baseUrl'];
    data = json['data'] != null ? AboutData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['baseUrl'] = this.baseUrl;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AboutData {
  String? title;
  String? imageUrl;
  AboutOrganization? about;
  String? vision;
  String? mission;
  List<Team?>? governingBody;
  List<Team?>? coreTeam;
  String? address;
  List<String?>? phones;
  List<String?>? emails;
  SocialMedia? socialMedia;

  AboutData(
      {this.title,
      this.imageUrl,
      this.about,
      this.vision,
      this.mission,
      this.governingBody,
      this.coreTeam,
      this.address,
      this.phones,
      this.emails,
      this.socialMedia});

  AboutData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    imageUrl = json['imageUrl'];
    about = json['about'] != null
        ? AboutOrganization.fromJson(json['about'])
        : null;
    vision = json['vision'];
    mission = json['mission'];
    if (json['governing_body'] != null) {
      governingBody = <Team>[];
      json['governing_body'].forEach((v) {
        governingBody!.add(new Team.fromJson(v));
      });
    }
    if (json['core_team'] != null) {
      coreTeam = <Team>[];
      json['core_team'].forEach((v) {
        coreTeam!.add(new Team.fromJson(v));
      });
    }
    address = json['address'];
    phones = json['phone'].cast<String?>();
    emails = json['email'].cast<String?>();
    socialMedia = json['social_media'] != null
        ? SocialMedia.fromJson(json['social_media'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = this.title;
    data['imageUrl'] = this.imageUrl;
    if (this.about != null) {
      data['about'] = this.about!.toJson();
    }
    data['vision'] = this.vision;
    data['mission'] = this.mission;
    if (this.governingBody != null) {
      data['governing_body'] =
          this.governingBody!.map((v) => v!.toJson()).toList();
    }
    if (this.coreTeam != null) {
      data['core_team'] = this.coreTeam!.map((v) => v!.toJson()).toList();
    }
    data['address'] = this.address;
    data['phone'] = this.phones;
    data['email'] = this.emails;
    if (this.socialMedia != null) {
      data['social_media'] = this.socialMedia!.toJson();
    }
    return data;
  }
}

class AboutOrganization {
  String? lkctc;
  String? trust;

  AboutOrganization({this.lkctc, this.trust});

  AboutOrganization.fromJson(Map<String, dynamic> json) {
    lkctc = json['lkctc'];
    trust = json['trust'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lkctc'] = this.lkctc;
    data['trust'] = this.trust;
    return data;
  }
}

class Team {
  String? name;
  String? designation;
  String? imageUrl;
  String? message;

  Team({this.name, this.designation, this.imageUrl, this.message});

  Team.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    designation = json['designation'];
    imageUrl = json['imageUrl'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['designation'] = this.designation;
    data['imageUrl'] = this.imageUrl;
    data['message'] = this.message;
    return data;
  }
}
