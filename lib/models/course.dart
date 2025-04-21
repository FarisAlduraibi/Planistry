class Course {
  final String id;
  final String name;
  final String description;
  final int chapters;
  final int quizzes;
  final int assignments;
  final List<String> files;

  Course({
    required this.id,
    required this.name,
    required this.description,
    required this.chapters,
    required this.quizzes,
    required this.assignments,
    required this.files,
  });
}