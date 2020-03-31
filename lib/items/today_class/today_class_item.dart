import 'package:classtable/data_source/course_entity.dart';
import 'package:classtable/data_source/database/Course.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodayClassItem extends StatelessWidget{
  final Course _curClass;

  TodayClassItem(this._curClass);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 20),
            child: Text(
              '第' + (_curClass.startUnit ~/ 2 + 1).toString() + '节',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  _curClass.name.length < 14 ? _curClass.name : _curClass.name.substring(0, 14) + "...",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ),
              ),
              Container(
                child: Text(
                  _curClass.room,
                  style: TextStyle(
                    fontSize: 15
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
