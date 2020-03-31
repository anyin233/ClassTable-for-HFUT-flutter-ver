class Course_Entity {
	int code;
	String msg;
	Null salt;
	Null token;
	Obj obj;
	Null error;

	Course_Entity({this.code, this.msg, this.salt, this.token, this.obj, this.error});

	Course_Entity.fromJson(Map<String, dynamic> json) {
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
	List<BusinessData> businessData;
	String errCode;
	String errMsg;

	Obj({this.businessData, this.errCode, this.errMsg});

	Obj.fromJson(Map<String, dynamic> json) {
		if (json['business_data'] != null) {
			businessData = new List<BusinessData>();
			json['business_data'].forEach((v) {
				businessData.add(new BusinessData.fromJson(v));
			});
		}
		errCode = json['err_code'];
		errMsg = json['err_msg'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.businessData != null) {
			data['business_data'] = this.businessData.map((v) => v.toJson()).toList();
		}
		data['err_code'] = this.errCode;
		data['err_msg'] = this.errMsg;
		return data;
	}
}

class BusinessData {
	String activityId;
	String activityWeek;
	String activityWeekstate;
	String courseName;
	String endTime;
	int endUnit;
	bool isConflict;
	String lessonCode;
	List<Rooms> rooms;
	String startTime;
	int startUnit;
	int teachclassStdcount;
	List<Teachers> teachers;
	int weekday;

	BusinessData(
			{this.activityId,
				this.activityWeek,
				this.activityWeekstate,
				this.courseName,
				this.endTime,
				this.endUnit,
				this.isConflict,
				this.lessonCode,
				this.rooms,
				this.startTime,
				this.startUnit,
				this.teachclassStdcount,
				this.teachers,
				this.weekday});

	BusinessData.fromJson(Map<String, dynamic> json) {
		activityId = json['activity_id'];
		activityWeek = json['activity_week'];
		activityWeekstate = json['activity_weekstate'];
		courseName = json['course_name'];
		endTime = json['end_time'];
		endUnit = json['end_unit'];
		isConflict = json['is_conflict'];
		lessonCode = json['lesson_code'];
		if (json['rooms'] != null) {
			rooms = new List<Rooms>();
			json['rooms'].forEach((v) {
				rooms.add(new Rooms.fromJson(v));
			});
		}
		startTime = json['start_time'];
		startUnit = json['start_unit'];
		teachclassStdcount = json['teachclass_stdcount'];
		if (json['teachers'] != null) {
			teachers = new List<Teachers>();
			json['teachers'].forEach((v) {
				teachers.add(new Teachers.fromJson(v));
			});
		}
		weekday = json['weekday'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['activity_id'] = this.activityId;
		data['activity_week'] = this.activityWeek;
		data['activity_weekstate'] = this.activityWeekstate;
		data['course_name'] = this.courseName;
		data['end_time'] = this.endTime;
		data['end_unit'] = this.endUnit;
		data['is_conflict'] = this.isConflict;
		data['lesson_code'] = this.lessonCode;
		if (this.rooms != null) {
			data['rooms'] = this.rooms.map((v) => v.toJson()).toList();
		}
		data['start_time'] = this.startTime;
		data['start_unit'] = this.startUnit;
		data['teachclass_stdcount'] = this.teachclassStdcount;
		if (this.teachers != null) {
			data['teachers'] = this.teachers.map((v) => v.toJson()).toList();
		}
		data['weekday'] = this.weekday;
		return data;
	}
}

class Rooms {
	String campusName;
	String code;
	String floorName;
	String name;

	Rooms({this.campusName, this.code, this.floorName, this.name});

	Rooms.fromJson(Map<String, dynamic> json) {
		campusName = json['campus_name'];
		code = json['code'];
		floorName = json['floor_name'];
		name = json['name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['campus_name'] = this.campusName;
		data['code'] = this.code;
		data['floor_name'] = this.floorName;
		data['name'] = this.name;
		return data;
	}
}

class Teachers {
	String code;
	String name;

	Teachers({this.code, this.name});

	Teachers.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		name = json['name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		data['name'] = this.name;
		return data;
	}
}
