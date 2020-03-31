import 'package:classtable/data_source/course_entity.dart';

class CourseProcess{
  List<BusinessData> splitCourseByWeek(List<BusinessData> courses, int week){
    List<BusinessData> temp;
    for (BusinessData course in courses){
      List<String> weeks = course.activityWeek.split(',');
      if (weeks.contains(week.toString())){
        temp.add(course);
      }
    }
    return temp;
  }//切分每周的课程
}