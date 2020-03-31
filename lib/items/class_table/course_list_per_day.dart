
import 'package:classtable/data_source/course_entity.dart';
import 'package:classtable/data_source/database/Course.dart';
import 'package:classtable/items/class_table/course_item.dart';
import 'package:flutter/material.dart';

class CourseListPerDay extends StatelessWidget {
  final List<Course> courseList;
  final int _classesPerDay;
  final double _screenHeight;

  CourseListPerDay(this.courseList, this._classesPerDay, this._screenHeight);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildCourseList();
  }

  Widget _buildCourseList() {
    double height = _screenHeight /~ (_classesPerDay);
    int _counter = 0;
    courseList.sort((a, b) {
      return a.startUnit - b.startUnit;
    });//根据课程开始的时间进行排序
    return ListView.builder(
      //shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _classesPerDay,//将Item数量设置为当天课程的总量
      itemBuilder: (context, i) {
        if (_counter < courseList.length && i == courseList[_counter].startUnit ~/ 2) {
          Course data = courseList[_counter];
          _counter += 1;//发现匹配的课程，指针向后移动一位
          int colorId = data.courseId.substring(4, 5) == "0" ? 1 : int.parse(data.courseId.substring(4, 5));
          return Container(
            height: height,
            width: 200,
            child: CourseTableItem(
                data.name,
                data.teacher,
                data.room,
                colorId),
          ); //返回该位置的课程
        } else {
          return Container(
            height: height,
            width: 200,
            child: CourseTableItem("", "", "", 0),
          );//当位置不匹配的时候返回一个空白的课程块
        }

    });
  }
}
