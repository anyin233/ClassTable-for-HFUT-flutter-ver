import 'package:classtable/data_source/course_entity.dart';
import 'package:classtable/data_source/database/course_database.dart';
import 'package:classtable/items/class_table/course_list_per_time.dart';
import 'package:classtable/test/test_helper.dart';
import 'package:classtable/views/class_table_view.dart';
import 'package:classtable/views/login_view.dart';
import 'package:classtable/views/today_class_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data_source/data_generater/data_generater.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<BusinessData> buss = Course_Entity.fromJson(TestHelper.jsonData).obj.businessData;
  int _currSelected = 0;
  var _shp;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _shp = SharedPreferences.getInstance();
  }

  void onBottomBarTap(int selected){
    setState(() {
      _currSelected = selected;
    });
  }

  static final List<Widget> _viewList = <Widget>[
    TodayClassView(),
    ClassTableView(5),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _shp,
          builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
            String startOn = "1970-01-01";
            if (snapshot.hasData){
              startOn = snapshot.data.getString("semesterStartOn") == null ? "1970-01-01" : snapshot.data.getString("semesterStartOn");
              DataGenerater.semesterLength = snapshot.data.getInt("semesterLength") ?? 20;
            }
            if (startOn != "1970-01-01"){
              DateTime today = DateTime.now();
              DateTime startDay = DateTime.parse(startOn);
              Duration weekDay = today.difference(startDay);
              DataGenerater.currWeek = (weekDay.inDays /~ 7) + 1 > 0 ? 1 : (weekDay.inDays ~/ 7) + 1;
            }else{
              DataGenerater.currWeek = 1;
            }
            return _viewList[_currSelected];
          },

        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onBottomBarTap,
        currentIndex: _currSelected,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assistant_photo),
            title: Text('今日')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_view_day),
            title: Text('课程表')
          )
        ],
      ),

    );
  }
}
