
import 'package:classtable/data_source/course_entity.dart';
import 'package:classtable/data_source/database/Course.dart';
import 'package:classtable/items/class_table/course_list_per_day.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoursePerTime extends StatefulWidget{
  final List<Course> _courseListFullWeek;
  final int _courseNumPerDay;

  

  CoursePerTime(this._courseListFullWeek, this._courseNumPerDay);

  @override
  State<StatefulWidget> createState() {
    return CoursePerTimeState(_courseListFullWeek, _courseNumPerDay);
  }


}

class CoursePerTimeState extends State<CoursePerTime>{
  final List<Course> _courseListFullWeek;
  final int _courseNumPerDay;
  
  CoursePerTimeState(this._courseListFullWeek, this._courseNumPerDay);

  List<Course>_buildOneDay(List<Course> buss, int day){
    List<Course> bussToday = [];
    for (Course buss in buss){
      if (buss.weekDay == day){
        bussToday.add(buss);
      }
    }
    return bussToday;
  }//聚合同一天的课程

  Widget _buildWeekdayList() {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, i){
          dynamic size = MediaQuery.of(context).size;
          List<Course> _courseData =  _buildOneDay(_courseListFullWeek, i + 1);
          return Container(
            width: (size.width)/7,
            child: CourseListPerDay(_courseData, _courseNumPerDay, -size.height),
          );//按日创建课表
        });
  }


  @override
  Widget build(BuildContext context) {
    return _buildWeekdayList();
  }
}