import 'package:flutter/material.dart';
import 'package:gr/Services/api_service.dart';
import 'package:gr/models/semester.dart';
import 'package:gr/models/course.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  List<Semester> semesters = [];
  bool isLoading = true;

  final TextEditingController _semesterCodeController = TextEditingController();
  final TextEditingController _courseCodeController = TextEditingController();
  final TextEditingController _courseNameController = TextEditingController();
  String? _selectedSemesterForCourse;

  Course? _editingCourse;
  Semester? _originalSemester;

  @override
  void initState() {
    super.initState();
    fetchSemesters();
  }

  Future<void> fetchSemesters() async {
    try {
      final data = await ApiService.getSemesters();
      setState(() {
        semesters = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      print('Failed to load semesters: \$e');
    }
  }

  @override
  void dispose() {
    _semesterCodeController.dispose();
    _courseCodeController.dispose();
    _courseNameController.dispose();
    super.dispose();
  }

  void _showCreateSemesterDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dialogBackgroundColor = isDark ? Colors.grey[850] : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: dialogBackgroundColor,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Create Semester',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _semesterCodeController,
                decoration: InputDecoration(
                  labelText: 'Semester Code',
                  hintText: 'e.g. 452',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  labelStyle: TextStyle(color: isDark ? Colors.grey[300] : null),
                  hintStyle: TextStyle(color: isDark ? Colors.grey[500] : null),
                ),
                style: TextStyle(color: textColor),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_semesterCodeController.text.isNotEmpty) {
                    try {
                      final newSemester = Semester(
                        id: 0, // Placeholder, backend assigns real ID
                        name: _semesterCodeController.text,
                        isActive: false,
                        courses: [],
                      );

                      await ApiService.createSemester(newSemester); // 🔁 Send to API
                      await fetchSemesters();                      // 🔄 Refresh UI
                      _semesterCodeController.clear();
                      Navigator.pop(context);
                    } catch (e) {
                      print('Failed to create semester: $e');
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddCourseDialog({Course? courseToEdit, Semester? semester}) {
    _editingCourse = courseToEdit;
    _originalSemester = semester;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dialogBackgroundColor = isDark ? Colors.grey[850] : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

    if (courseToEdit != null && semester != null) {
      _courseCodeController.text = courseToEdit.code;
      _courseNameController.text = courseToEdit.name;
      _selectedSemesterForCourse = semester.id.toString();
    } else {
      _courseCodeController.clear();
      _courseNameController.clear();
      _selectedSemesterForCourse = semesters.first.id.toString();
    }

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: dialogBackgroundColor,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  courseToEdit != null ? 'Edit Course' : 'Add Course',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _courseCodeController,
                  decoration: InputDecoration(
                    labelText: 'Course Code',
                    hintText: 'ex: CS451',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  style: TextStyle(color: textColor),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _courseNameController,
                  decoration: InputDecoration(
                    labelText: 'Course Name',
                    hintText: 'ex: Computer Security',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  style: TextStyle(color: textColor),
                ),
                const SizedBox(height: 16),
                Text('Semester', style: TextStyle(fontSize: 16, color: textColor)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.blue.withOpacity(0.2) : Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedSemesterForCourse ??
                        semesters.first.id.toString(), // fallback if null
                    onChanged: (String? newValue) {
                      setDialogState(() {
                        _selectedSemesterForCourse = newValue;
                      });
                    },
                    items: semesters
                        .map<DropdownMenuItem<String>>((Semester semester) {
                      return DropdownMenuItem<String>(
                        value: semester.id.toString(),
                        child: Text('${semester.name}'),
                      );
                    }).toList(),
                    isExpanded: true,
                    underline: Container(),
                    dropdownColor: isDark ? Colors.grey[850] : Colors.white,
                    icon: Icon(Icons.arrow_drop_down,
                        color: isDark ? Colors.white70 : Colors.black54),
                  )

                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (courseToEdit != null)
                      ElevatedButton(
                        onPressed: () {
                          _deleteCourse(courseToEdit, semester!);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Delete'),
                      ),
                    ElevatedButton(
                      onPressed: () {
                        final newCourse = Course(
                          id: DateTime.now().millisecondsSinceEpoch,
                          name: _courseNameController.text,
                          code: _courseCodeController.text,
                          credits: 1.0,
                          semester: int.parse(_selectedSemesterForCourse!),
                          instructor: 'Unknown',
                        );

                        if (courseToEdit != null && semester != null) {
                          _updateCourse(courseToEdit, newCourse, semester);
                        } else {
                          _addCourse(newCourse);
                        }

                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(courseToEdit != null ? 'Update' : 'Add'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addCourse(Course course) async {
    try {
      await ApiService.createCourse(course);           // ✅ Call API
      await fetchSemesters();                          // 🔁 Refresh UI
    } catch (e) {
      print('Failed to add course: $e');
    }
  }

  Future<void> _updateCourse(Course oldCourse, Course newCourse, Semester oldSemester) async {
    try {
      await ApiService.updateCourse(oldCourse.id, newCourse);  // ✅ Update on backend
      await fetchSemesters();                                  // 🔁 Refresh UI
    } catch (e) {
      print('Failed to update course: $e');
    }
  }

  Future<void> _deleteCourse(Course course, Semester semester) async {
    try {
      await ApiService.deleteCourse(course.id);   // ✅ Delete from backend
      await fetchSemesters();                     // 🔁 Refresh UI
    } catch (e) {
      print('Failed to delete course: $e');
    }
  }


  void _toggleSemesterActive(Semester semester) {
    setState(() {
      for (var s in semesters) {
        if (s.id == semester.id) {
          s.isActive = !s.isActive;
        } else {
          s.isActive = false;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final secondaryTextColor = Theme.of(context).textTheme.bodyMedium!.color!;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Courses',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  Text(
                    'Manage your course list by semester',
                    style: TextStyle(fontSize: 14, color: secondaryTextColor),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: semesters.length,
                itemBuilder: (context, index) {
                  final semester = semesters[index];
                  return SemesterSection(
                    semester: semester,
                    onToggleActive: () => _toggleSemesterActive(semester),
                    onEditCourse: (course) => _showAddCourseDialog(courseToEdit: course, semester: semester),
                    isDarkMode: isDark,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: _showAddCourseDialog,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Course'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDark ? Colors.blue[900] : Colors.blue[100],
                      foregroundColor: isDark ? Colors.white : Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _showCreateSemesterDialog,
                    child: const Text('Create Semester'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SemesterSection extends StatelessWidget {
  final Semester semester;
  final VoidCallback onToggleActive;
  final Function(Course) onEditCourse;
  final bool isDarkMode;

  const SemesterSection({
    Key? key,
    required this.semester,
    required this.onToggleActive,
    required this.onEditCourse,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final secondaryTextColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Text('${semester.name}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor)),
              const Spacer(),
              TextButton(
                onPressed: onToggleActive,
                child: Text(
                  semester.isActive ? 'Activated' : 'Not Active',
                  style: TextStyle(color: semester.isActive ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        if (semester.isActive)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: semester.courses.length,
            itemBuilder: (context, index) {
              final course = semester.courses[index];
              return ListTile(
                title: Text(course.code, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                subtitle: Text(course.name, style: TextStyle(color: secondaryTextColor)),
                trailing: IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => onEditCourse(course),
                  color: secondaryTextColor,
                ),
              );
            },
          ),
      ],
    );
  }
}