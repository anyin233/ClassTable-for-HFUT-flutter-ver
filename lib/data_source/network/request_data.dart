import 'dart:convert';


import 'package:classtable/data_source/course_entity.dart' as ce;
import 'package:classtable/data_source/database/Course.dart';
import 'package:classtable/data_source/login_entity.dart';
import 'package:classtable/data_source/week_list.dart';
import 'package:dio/dio.dart' ;


class RequestData {
  static Dio dio = Dio(new BaseOptions(
    baseUrl: "http://jxglstu.hfut.edu.cn:7070/appservice/",
    headers: headers
  ));


  static var headers = <String ,dynamic>{
    "User-Agent": "Mozilla/5.0 (Linux; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/80.0.3987.149 Mobile Safari/537.36",
    "Content-Type": "application/x-www-form-urlencoded",
    "X-Requested-With": "edu.hfut.eams.mobile",
    "Accept-Encoding": "gzip, deflate",
    "Accept-Language": "en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7"
  };

  static const String urlPrefix = "http://jxglstu.hfut.edu.cn:7070/appservice/";
  static List<Course> translateBusinessData(List<ce.BusinessData> source){
    List<Course> courses = [];
    for (ce.BusinessData data in source){
      courses.add(
        Course(
          courseId: data.activityId,
          name: data.courseName,
          teacher: data.teachers.length == 0 ? "" : data.teachers[0].name,
          room: data.rooms.length == 0 ? "" : data.rooms[0].name,
          weekDay: data.weekday,
          startUnit: data.startUnit,
          activityWeek: data.activityWeek
        )
      );
    }
    return courses;
  }

  static Future<LoginMessage> getLoginMessage(String username, String password) async{
    var coder = Base64Codec();
    String passwordCoded = coder.encode(password.codeUnits);
    Map<String, String> body = <String, String>{
      'username':username,
      'password':passwordCoded,
      'identity':0.toString()
    };
    var form = FormData.fromMap(body);
    Response response;

    try{
      response = await dio.post(
          "home/appLogin/login.action",
          data: form
      );
    }catch(e, stack){
      return null;
    }

    return LoginMessage.fromJson(response.data);
  }//获取个人信息

  static Future<List<Course>> getWeekSchedule(String userKey, int semesterCode) async{
    Map<String, dynamic> body = <String, dynamic>{
      'userKey': userKey,
      'identity': 0,
      'projectId': 2,
      'semestercode': '0' + semesterCode.toString(),
      'weekIndex': 1
    };
    var form = FormData.fromMap(body);

    var response = await dio.post(
      'home/schedule/getWeekSchedule.action',
      data: form
    );

    return translateBusinessData(ce.Course_Entity.fromJson(response.data).obj.businessData);
  }//获取课表

  static Future<WeekList> getWeekList(String userKey) async{
    final Map<String, String> body = <String, String>{
      'userKey': userKey,
      'projectId': '2'
    };

    var form = FormData.fromMap(body);
    var response = await dio.post(
      'home/publicdata/getSemesterAndWeekList.action',
      data: form
    );

    return WeekList.fromJson(response.data);
  }//获取周列表，并确定当前学期

}