class AlumniModal {
  String? baseUrl;
  AlumniData? data;

  AlumniModal({this.baseUrl, this.data});

  AlumniModal.fromJson(Map<String, dynamic> json) {
    baseUrl = json['baseUrl'];
    data = json['data'] != null ? AlumniData.fromJson(json['data']) : null;
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

class AlumniData {
  String? link;
  Alumni? alumni;

  AlumniData({this.link, this.alumni});

  AlumniData.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    alumni = json['alumni'] != null ? Alumni.fromJson(json['alumni']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['link'] = this.link;
    if (this.alumni != null) {
      data['alumni'] = this.alumni!.toJson();
    }
    return data;
  }
}

class Alumni {
  List<Branch?>? ce;
  List<Branch?>? cse;
  List<Branch?>? ece;
  List<Branch?>? me;

  Alumni({this.ce, this.cse, this.ece, this.me});

  Alumni.fromJson(Map<String, dynamic> json) {
    if (json['ce'] != null) {
      ce = <Branch>[];
      json['ce'].forEach((v) {
        ce!.add(Branch.fromJson(v));
      });
    }
    if (json['cse'] != null) {
      cse = <Branch>[];
      json['cse'].forEach((v) {
        cse!.add(Branch.fromJson(v));
      });
    }
    if (json['ece'] != null) {
      ece = <Branch>[];
      json['ece'].forEach((v) {
        ece!.add(Branch.fromJson(v));
      });
    }
    if (json['me'] != null) {
      me = <Branch>[];
      json['me'].forEach((v) {
        me!.add(Branch.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.ce != null) {
      data['ce'] = this.ce!.map((v) => v!.toJson()).toList();
    }
    if (this.cse != null) {
      data['cse'] = this.cse!.map((v) => v!.toJson()).toList();
    }
    if (this.ece != null) {
      data['ece'] = this.ece!.map((v) => v!.toJson()).toList();
    }
    if (this.me != null) {
      data['me'] = this.me!.map((v) => v!.toJson()).toList();
    }
    return data;
  }
}

class Branch {
  String? name;
  String? batch;
  String? job;
  String? company;
  String? email;
  String? mobile;
  String? imageUrl;

  Branch(
      {this.name,
      this.batch,
      this.job,
      this.company,
      this.email,
      this.mobile,
      this.imageUrl});

  Branch.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    batch = json['batch'];
    job = json['job'];
    company = json['company'];
    email = json['email'];
    mobile = json['mobile'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['batch'] = this.batch;
    data['job'] = this.job;
    data['company'] = this.company;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
