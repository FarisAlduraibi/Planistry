class Course {
  final int id;
  final String name;
  final String code;
  final double credits;
  final int semester;
  final String instructor;

  Course({
    required this.id,
    required this.name,
    required this.code,
    required this.credits,
    required this.semester,
    required this.instructor,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      credits: double.tryParse(json['credits'].toString()) ?? 0.0,
      semester: json['semester'],
      instructor: json['instructor'],
    );
  }
}
