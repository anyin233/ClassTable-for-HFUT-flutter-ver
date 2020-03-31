class LoginMessage {
  int code;
  String msg;
  String salt;
  Obj obj;
  String token;
  String error;

  LoginMessage(
      {this.code, this.msg, this.salt, this.obj, this.token, this.error});

  LoginMessage.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    salt = json['salt'];
    obj = json['obj'] != null ? new Obj.fromJson(json['obj']) : null;
    token = json['token'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['salt'] = this.salt;
    if (this.obj != null) {
      data['obj'] = this.obj.toJson();
    }
    data['token'] = this.token;
    data['error'] = this.error;
    return data;
  }
}

class Obj {
  BusinessData businessData;
  String errCode;
  String errMsg;
  String userKey;

  Obj({this.businessData, this.errCode, this.errMsg, this.userKey});

  Obj.fromJson(Map<String, dynamic> json) {
    businessData = json['business_data'] != null
        ? new BusinessData.fromJson(json['business_data'])
        : null;
    errCode = json['err_code'];
    errMsg = json['err_msg'];
    userKey = json['userKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.businessData != null) {
      data['business_data'] = this.businessData.toJson();
    }
    data['err_code'] = this.errCode;
    data['err_msg'] = this.errMsg;
    data['userKey'] = this.userKey;
    return data;
  }
}

class BusinessData {
  String accountEmail;
  String adminclassName;
  String ancestralAddr;
  String birthday;
  String departName;
  String directionName;
  String gender;
  String majorName;
  String mobilePhone;
  String userCode;
  String userName;

  BusinessData(
      {this.accountEmail,
        this.adminclassName,
        this.ancestralAddr,
        this.birthday,
        this.departName,
        this.directionName,
        this.gender,
        this.majorName,
        this.mobilePhone,
        this.userCode,
        this.userName});

  BusinessData.fromJson(Map<String, dynamic> json) {
    accountEmail = json['account_email'];
    adminclassName = json['adminclass_name'];
    ancestralAddr = json['ancestral_addr'];
    birthday = json['birthday'];
    departName = json['depart_name'];
    directionName = json['direction_name'];
    gender = json['gender'];
    majorName = json['major_name'];
    mobilePhone = json['mobile_phone'];
    userCode = json['user_code'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account_email'] = this.accountEmail;
    data['adminclass_name'] = this.adminclassName;
    data['ancestral_addr'] = this.ancestralAddr;
    data['birthday'] = this.birthday;
    data['depart_name'] = this.departName;
    data['direction_name'] = this.directionName;
    data['gender'] = this.gender;
    data['major_name'] = this.majorName;
    data['mobile_phone'] = this.mobilePhone;
    data['user_code'] = this.userCode;
    data['user_name'] = this.userName;
    return data;
  }

  @override
  String toString() {
    return 'BusinessData{accountEmail: $accountEmail, adminclassName: $adminclassName, ancestralAddr: $ancestralAddr, birthday: $birthday, departName: $departName, directionName: $directionName, gender: $gender, majorName: $majorName, mobilePhone: $mobilePhone, userCode: $userCode, userName: $userName}';
  }


}
