class Course {
  final int id;
  final String name;
  final String code;
  final double credits;
  final int semester;
  final String instructor;
  final String description;
  final int chapters;
  final int quizzes;
  final int assignments;
  final List<dynamic> files;

  Course({
    required this.id,
    required this.name,
    required this.code,
    required this.credits,
    required this.semester,
    required this.instructor,
    required this.description,
    required this.chapters,
    required this.quizzes,
    required this.assignments,
    required this.files,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      credits: double.tryParse(json['credits'].toString()) ?? 0.0,
      semester: json['semester'],
      instructor: json['instructor'],
      description: json['description'] ?? '',
      chapters: json['chapters'] ?? 0,
      quizzes: json['quizzes'] ?? 0,
      assignments: json['assignments']?.length ?? 0,
      files: json['files'] ?? [],
    );
  }
}
