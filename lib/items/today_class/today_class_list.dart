import 'package:classtable/data_source/course_entity.dart';
import 'package:classtable/data_source/database/Course.dart';
import 'package:classtable/items/today_class/today_class_item.dart';
import 'package:flutter/material.dart';

class TodayClassList extends StatelessWidget{
  final List<Course> _todayClass;

  TodayClassList(this._todayClass);

  Widget _buildTodayClassList(){
    _todayClass.sort((a, b){
      return a.startUnit - b.startUnit;
    });
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _todayClass.length,
      itemBuilder: (context, index){
      return Container(
        height: 100,
        child: TodayClassItem(_todayClass[index]),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildTodayClassList();
  }

}