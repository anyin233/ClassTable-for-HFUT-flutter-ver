import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Course.dart';

class CourseDatabase {
  static Future<Database> database;

  Future<void> initDatabase() async{
    database = openDatabase(
        join(await getDatabasesPath(), 'course_database'),
      onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE Course(id INTEGER PRIMARY KEY AUTOINCREMENT, course_id Text, name TEXT, teacher TEXT, room TEXT, activity_week TEXT, start_unit INTEGER, week_day INTEGER)"
          );
      },
      version: 1
    );
  }//初始化数据库

  Future<void> insertCourse(List<Course> course) async{
    await initDatabase();
    final Database db = await database;

    for(Course c in course){
      print(c.name);
      db.insert('Course', c.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<void> deleteCourses() async{
    await initDatabase();
    final Database db =  await database;

    db.execute("DELETE FROM Course");
  }

  Future<List<Course>> queryAll() async{
    await initDatabase();
    final Database db = await database;

    final List<Map<String ,dynamic>> data = await db.query("Course");

    return List.generate(data.length, (i){
      return Course(
        id: data[i]['id'],
        courseId: data[i]['course_id'],
        name: data[i]['name'],
        teacher: data[i]['teacher'],
        room: data[i]['room'],
        activityWeek: data[i]['activity_week'],
        startUnit: data[i]['start_unit'],
        weekDay: data[i]['week_day']
      );
    });
  }//查询全部课程

}