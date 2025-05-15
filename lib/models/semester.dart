import 'course.dart';
class Semester {
  final int id;
  final String name;
  bool isActive;
  final List<Course> courses;

  Semester({
    required this.id,
    required this.name,
    required this.isActive,
    required this.courses,
  });

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
      id: json['id'],
      name: json['name'],
      isActive: json['is_active'],
      courses: (json['courses'] as List)
          .map((course) => Course.fromJson(course))
          .toList(),
    );
  }
}
