import 'package:classtable/data_source/database/Course.dart';
import 'package:classtable/data_source/database/course_database.dart';

class DataGenerater{
  final CourseDatabase database = CourseDatabase();//初始化一个database实例
  List<Course> course;
  static int semesterLength = 20;
  static int currWeek = 1;

  Future<void> initData() async{
    database.initDatabase();
    course = await database.queryAll();
  }

  Future<List<Course>> getTodayCourse(int week) async{
    await initData();
    List<Course> res = [];
    int weekDay = DateTime.now().weekday;
    List<Course> thisWeek = await getThisWeek(week);
    for (Course c in thisWeek){
      if (c.weekDay == weekDay){
        res.add(c);
      }
    }
    return res;
  }//请求当天的课程

  Future<List<Course>> getThisWeek(int week) async{
    await initData();
    List<Course> res = [];
    for (Course c in course){
      List<String> weeks = c.activityWeek.split(',');
      if (weeks.contains(week.toString())){
        res.add(c);
      }
    }
    return res;
  }//请求该周的课程


}