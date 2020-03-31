import 'dart:math';

import 'package:flutter/material.dart';

class CourseTableItem extends StatelessWidget{
  final String _courseName;
  final String _courseTeacher;
  final String _coursePlace;
  final int _colorId;

  static final List<Color> colorList = <Color>[
    Colors.white,//无课程的时候使用white
    Colors.green[200],
    Colors.pink[200],
    Colors.blue[200],
    Colors.yellow[200],
    Colors.red[300],
    Colors.lightBlue[300],
    Colors.purple[200],
    Colors.cyan,
    Colors.blueAccent,
  ];

  @override
  Widget build(BuildContext context) {
    double _fontSize = 11;
    double _smallFontSize = 10;
    Random random = new Random();
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500 + random.nextInt(500)),
      opacity: 1.0,
      child: GestureDetector(
        child: Card(
          margin: EdgeInsets.all(1),
          child: Container(
            color: colorList[_colorId],
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    _courseName.length <= 10 ? _courseName : _courseName.substring(0, 10) + "...",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: _fontSize
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    _courseTeacher,
                    style: TextStyle(
                        fontSize: _smallFontSize
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    _coursePlace,
                    style: TextStyle(
                        fontSize: _smallFontSize
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  CourseTableItem(this._courseName, this._courseTeacher, this._coursePlace, this._colorId);
}
