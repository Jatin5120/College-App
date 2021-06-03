class PlacementModal {
  String? baseUrl;
  PlacementData? data;

  PlacementModal({this.baseUrl, this.data});

  PlacementModal.fromJson(Map<String, dynamic> json) {
    baseUrl = json['baseUrl'];
    data = json['data'] != null ? PlacementData.fromJson(json['data']) : null;
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

class PlacementData {
  List<Coordinator?>? coordinator;
  List<Recruiters?>? recruiters;
  List<StudentsPlaced?>? studentsPlaced;
  Ibm? ibm;

  PlacementData(
      {this.coordinator, this.recruiters, this.studentsPlaced, this.ibm});

  PlacementData.fromJson(Map<String, dynamic> json) {
    if (json['coordinator'] != null) {
      coordinator = <Coordinator>[];
      json['coordinator'].forEach((v) {
        coordinator!.add(Coordinator.fromJson(v));
      });
    }
    if (json['recruiters'] != null) {
      recruiters = <Recruiters>[];
      json['recruiters'].forEach((v) {
        recruiters!.add(Recruiters.fromJson(v));
      });
    }
    if (json['studentsPlaced'] != null) {
      studentsPlaced = <StudentsPlaced>[];
      json['studentsPlaced'].forEach((v) {
        studentsPlaced!.add(StudentsPlaced.fromJson(v));
      });
    }
    ibm = json['ibm'] != null ? Ibm.fromJson(json['ibm']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.coordinator != null) {
      data['coordinator'] = this.coordinator!.map((v) => v!.toJson()).toList();
    }
    if (this.recruiters != null) {
      data['recruiters'] = this.recruiters!.map((v) => v!.toJson()).toList();
    }
    if (this.studentsPlaced != null) {
      data['studentsPlaced'] =
          this.studentsPlaced!.map((v) => v!.toJson()).toList();
    }
    if (this.ibm != null) {
      data['ibm'] = this.ibm!.toJson();
    }
    return data;
  }
}

class Coordinator {
  String? name;
  String? designation;
  String? email;
  String? mobile;
  String? imageUrl;

  Coordinator(
      {this.name, this.designation, this.email, this.mobile, this.imageUrl});

  Coordinator.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    designation = json['designation'];
    email = json['email'];
    mobile = json['mobile'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['designation'] = this.designation;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}

class Recruiters {
  String? name;
  String? imageUrl;

  Recruiters({this.name, this.imageUrl});

  Recruiters.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}

class StudentsPlaced {
  String? name;
  String? imageUrl;
  String? company;

  StudentsPlaced({this.name, this.imageUrl, this.company});

  StudentsPlaced.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageUrl = json['imageUrl'];
    company = json['company'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    data['company'] = this.company;
    return data;
  }
}

class Ibm {
  List<Students?>? ce;
  List<Students?>? cse;
  List<Students?>? ece;
  List<Students?>? me;

  Ibm({this.ce, this.cse, this.ece, this.me});

  Ibm.fromJson(Map<String, dynamic> json) {
    ce = json['ce'];
    if (json['cse'] != null) {
      cse = <Students>[];
      json['cse'].forEach((v) {
        cse!.add(Students.fromJson(v));
      });
    }
    if (json['ece'] != null) {
      ece = <Students>[];
      json['ece'].forEach((v) {
        ece!.add(Students.fromJson(v));
      });
    }
    me = json['me'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['ce'] = this.ce;
    if (this.cse != null) {
      data['cse'] = this.cse!.map((v) => v!.toJson()).toList();
    }
    if (this.ece != null) {
      data['ece'] = this.ece!.map((v) => v!.toJson()).toList();
    }
    data['me'] = this.me;
    return data;
  }
}

class Students {
  String? name;
  String? imageUrl;

  Students({this.name, this.imageUrl});

  Students.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
