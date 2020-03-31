class Course{
  final int id;
  final String courseId;
  final String name;
  final String teacher;
  final String room;
  final String activityWeek;
  final int startUnit;
  final int weekDay;

  Course({this.id, this.courseId, this.name, this.teacher, this.room,
      this.activityWeek, this.startUnit, this.weekDay});

  Map<String, dynamic> toMap(){
    return {
      "course_id":courseId,
      "name":name,
      "teacher": teacher,
      "room":room,
      "activity_week":activityWeek,
      "start_unit":startUnit,
      "week_day":weekDay
    };
  }
}