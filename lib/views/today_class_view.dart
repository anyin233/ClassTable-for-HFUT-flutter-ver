import 'package:classtable/data_source/course_entity.dart';
import 'package:classtable/data_source/data_generater/data_generater.dart';
import 'package:classtable/data_source/database/Course.dart';
import 'package:classtable/data_source/database/course_database.dart';
import 'package:classtable/items/today_class/today_class_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class TodayClassView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    DataGenerater generater = DataGenerater();
    //List<BusinessData> todayCourse = TestHelper.getTodayClasses(1);
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {

        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FutureBuilder(
              future: generater.getTodayCourse(DataGenerater.currWeek),
              builder: (BuildContext context, AsyncSnapshot<List<Course>> snapshot) {
                if (snapshot.hasData){
                  return TodayClassList(snapshot.data);
                }else{
                  return TodayClassList([]);
                }
              },

            )
          ],
        );
      },

    );
  }

}