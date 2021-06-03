class Link {
  String? displayText;
  bool? important;
  String? url;

  Link({this.displayText, this.important, this.url});

  Link.fromJson(Map<String, dynamic> json) {
    displayText = json['display_text'];
    important = json['important'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['display_text'] = this.displayText;
    data['important'] = this.important;
    data['url'] = this.url;
    return data;
  }
}

class SocialMedia {
  String? facebook;
  String? twitter;
  String? instagram;
  String? linkedin;

  SocialMedia({this.facebook, this.twitter, this.instagram, this.linkedin});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    facebook = json['facebook'];
    twitter = json['twitter'];
    instagram = json['instagram'];
    linkedin = json['linkedin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['instagram'] = this.instagram;
    data['linkedin'] = this.linkedin;
    return data;
  }
}
