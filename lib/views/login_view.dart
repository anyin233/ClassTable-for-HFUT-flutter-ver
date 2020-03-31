import 'package:classtable/data_source/data_generater/data_generater.dart';
import 'package:classtable/data_source/database/Course.dart';
import 'package:classtable/data_source/database/course_database.dart';
import 'package:classtable/data_source/login_entity.dart';
import 'package:classtable/data_source/network/request_data.dart';
import 'package:classtable/data_source/week_list.dart';
import 'package:classtable/views/class_table_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatelessWidget {
  final username = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding:
                  EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: username,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    border: OutlineInputBorder(),
                    hintText: "请输入学号"),
              ),
            ),
            Container(
              padding:
                  EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 30),
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  border: OutlineInputBorder(),
                  hintText: "请输入密码",
                ),
                obscureText: true,
              ),
            ),
            Container(child: _LoginButton(username, password))
          ],
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final TextEditingController username;
  final TextEditingController password;

  _LoginButton(this.username, this.password);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return OutlineButton(
      child: Text('Submit'),
      onPressed: () async {
        if (username.text == '' || password.text == '') {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('请输入正确的账号和密码'),
          ));
        }
        LoginMessage msg =
            await RequestData.getLoginMessage(username.text, password.text);
        if (msg == null) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("当前网络出现了点问题，请确认是否连接到互联网或者学校封网"),
          ));
        } else {
          SharedPreferences shp = await SharedPreferences.getInstance();
          if (msg.code != 200) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text("登录失败，请检查账号或者密码")));
          } else {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("登录成功，开始获取课表"),
            ));
            var userKey = msg.obj.userKey;
            shp.setString("userKey", userKey);
            WeekList weekList = await RequestData.getWeekList(userKey);
            String semesterCode = weekList.obj.businessData.curSemesterCode;
            String startDay = "1970-01-01";
            int semesterLength = 20;
            for (Semesters semester in weekList.obj.businessData.semesters) {
              if (semester.code == semesterCode) {
                startDay = semester.weeks[0].beginOn;
                semesterLength = semester.weeks.length;
                break;
              }
            } //获取开学日期
            shp.setString("semesterStartOn", startDay);
            shp.setInt("semesterLength", semesterLength);
            ClassTableViewState.length = semesterLength;
            DataGenerater.semesterLength = semesterLength;
            List<Course> course = await RequestData.getWeekSchedule(
                userKey, int.parse(semesterCode));
            CourseDatabase database = CourseDatabase();
            if ((await database.queryAll()).isNotEmpty){
              await database.deleteCourses();
            }
            await database.insertCourse(course); //将课表放入数据库中
            Scaffold.of(context)
            .removeCurrentSnackBar();
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(("获取成功"))));
            Navigator.pop(context);
          }
        }
      },
    );
  }
}
