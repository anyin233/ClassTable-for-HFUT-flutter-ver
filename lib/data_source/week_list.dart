class WeekList {
  int code;
  String msg;
  String salt;
  String token;
  Obj obj;
  String error;

  WeekList({this.code, this.msg, this.salt, this.token, this.obj, this.error});

  WeekList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    salt = json['salt'];
    token = json['token'];
    obj = json['obj'] != null ? new Obj.fromJson(json['obj']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['salt'] = this.salt;
    data['token'] = this.token;
    if (this.obj != null) {
      data['obj'] = this.obj.toJson();
    }
    data['error'] = this.error;
    return data;
  }
}

class Obj {
  BusinessData businessData;
  String errCode;
  String errMsg;

  Obj({this.businessData, this.errCode, this.errMsg});

  Obj.fromJson(Map<String, dynamic> json) {
    businessData = json['business_data'] != null
        ? new BusinessData.fromJson(json['business_data'])
        : null;
    errCode = json['err_code'];
    errMsg = json['err_msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.businessData != null) {
      data['business_data'] = this.businessData.toJson();
    }
    data['err_code'] = this.errCode;
    data['err_msg'] = this.errMsg;
    return data;
  }
}

class BusinessData {
  String curSemesterCode;
  int curWeekIndex;
  List<Semesters> semesters;

  BusinessData({this.curSemesterCode, this.curWeekIndex, this.semesters});

  BusinessData.fromJson(Map<String, dynamic> json) {
    curSemesterCode = json['cur_semester_code'];
    curWeekIndex = json['cur_week_index'];
    if (json['semesters'] != null) {
      semesters = new List<Semesters>();
      json['semesters'].forEach((v) {
        semesters.add(new Semesters.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cur_semester_code'] = this.curSemesterCode;
    data['cur_week_index'] = this.curWeekIndex;
    if (this.semesters != null) {
      data['semesters'] = this.semesters.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Semesters {
  String code;
  String name;
  String season;
  int weekStartAt;
  List<Weeks> weeks;
  String year;

  Semesters(
      {this.code,
        this.name,
        this.season,
        this.weekStartAt,
        this.weeks,
        this.year});

  Semesters.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    season = json['season'];
    weekStartAt = json['week_start_at'];
    if (json['weeks'] != null) {
      weeks = new List<Weeks>();
      json['weeks'].forEach((v) {
        weeks.add(new Weeks.fromJson(v));
      });
    }
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['season'] = this.season;
    data['week_start_at'] = this.weekStartAt;
    if (this.weeks != null) {
      data['weeks'] = this.weeks.map((v) => v.toJson()).toList();
    }
    data['year'] = this.year;
    return data;
  }
}

class Weeks {
  String beginOn;
  String endOn;
  int index;

  Weeks({this.beginOn, this.endOn, this.index});

  Weeks.fromJson(Map<String, dynamic> json) {
    beginOn = json['begin_on'];
    endOn = json['end_on'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['begin_on'] = this.beginOn;
    data['end_on'] = this.endOn;
    data['index'] = this.index;
    return data;
  }
}