class ScheduleItem {
  final String courseId;
  final String courseName;
  final String topic;
  final String details;
  final DateTime startTime;
  final DateTime endTime;

  ScheduleItem({
    required this.courseId,
    required this.courseName,
    required this.topic,
    required this.details,
    required this.startTime,
    required this.endTime,
  });
} 