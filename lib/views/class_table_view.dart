import 'package:classtable/data_source/course_entity.dart';
import 'package:classtable/data_source/data_generater/data_generater.dart';
import 'package:classtable/data_source/database/Course.dart';
import 'package:classtable/data_source/network/request_data.dart';
import 'package:classtable/items/class_table/course_list_per_time.dart';
import 'package:classtable/views/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../test/test_helper.dart';

class ClassTableView extends StatefulWidget {
  final int _classPerDay;

  ClassTableView(this._classPerDay);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ClassTableViewState(_classPerDay);
  }
}

class ClassTableViewState extends State<ClassTableView> {
  final int _classPerDay;
  static Future<List<Course>> courseList;
  DataGenerater generater = DataGenerater();
  int _tempWeek = DataGenerater.currWeek;
  static int length = DataGenerater.semesterLength;

  ClassTableViewState(this._classPerDay);

  Route _createRouteToClassTableView() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => LoginView(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    courseList = generater.getThisWeek(_tempWeek);
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FutureBuilder(
            future: courseList,
            builder:
                (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
              switch (snapshot.connectionState){
                case ConnectionState.done:{
                  return
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 120,
                      child: CoursePerTime(snapshot.data, _classPerDay),

                  );
                }
                default:{
                  return Container(

                  );
                }
              }
            },
          ),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width / 2,
            child: Card(
              elevation: 24,
              margin: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  FlatButton.icon(
                      onPressed: () {
                        setState(() {
                          if (_tempWeek > 1){
                            _tempWeek -= 1;
                            courseList = generater.getThisWeek(_tempWeek);
                          }
                        });
                      },
                      icon: Icon(Icons.keyboard_arrow_left),
                      label: Text("")),
                  Expanded(
                    child: Text(
                      _tempWeek.toString(),
                      style: TextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  FlatButton.icon(
                      onPressed: () {
                        setState(() {
                          if (_tempWeek < length){
                            _tempWeek += 1;
                            courseList = generater.getThisWeek(_tempWeek);
                          }
                        });
                      },
                      icon: Icon(Icons.keyboard_arrow_right),
                      label: Text(""))
                ],
              ),
            ),
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.account_circle),
        onPressed: () {
          Navigator.of(context).push(_createRouteToClassTableView());
        },
      ),
    );
  }
}
