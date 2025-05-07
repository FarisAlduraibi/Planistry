import 'package:flutter/material.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  // Model classes
  List<Semester> semesters = [
    Semester(
      code: '451',
      isActive: true,
      courses: [
        Course(code: 'CS 432', name: 'Artificial Intelligence'),
        Course(code: 'CS 348', name: 'Optimization Techniques'),
        Course(code: 'CS 471', name: 'Web Technologies'),
        Course(code: 'CS 451', name: 'Computer Security'),
      ],
    ),
    Semester(code: '442', isActive: false, courses: []),
    Semester(code: '441', isActive: false, courses: []),
  ];

  // Controller for adding new semester
  final TextEditingController _semesterCodeController = TextEditingController();

  // Controllers for adding/editing courses
  final TextEditingController _courseCodeController = TextEditingController();
  final TextEditingController _courseNameController = TextEditingController();
  String? _selectedSemesterForCourse;

  // For editing an existing course
  Course? _editingCourse;
  Semester? _originalSemester;

  @override
  void dispose() {
    _semesterCodeController.dispose();
    _courseCodeController.dispose();
    _courseNameController.dispose();
    super.dispose();
  }

  void _showCreateSemesterDialog() {
    // Get the current theme's brightness
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
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _semesterCodeController,
                decoration: InputDecoration(
                  labelText: 'Semester Code',
                  hintText: 'e.g. 452',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelStyle: TextStyle(color: isDark ? Colors.grey[300] : null),
                  hintStyle: TextStyle(color: isDark ? Colors.grey[500] : null),
                ),
                style: TextStyle(color: textColor),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_semesterCodeController.text.isNotEmpty) {
                    setState(() {
                      semesters.add(
                        Semester(
                          code: _semesterCodeController.text,
                          isActive: false,
                          courses: [],
                        ),
                      );
                      _semesterCodeController.clear();
                    });
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
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

    // Get the current theme's brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dialogBackgroundColor = isDark ? Colors.grey[850] : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

    // Pre-fill fields if editing
    if (courseToEdit != null && semester != null) {
      _courseCodeController.text = courseToEdit.code;
      _courseNameController.text = courseToEdit.name;
      _selectedSemesterForCourse = semester.code;
    } else {
      _courseCodeController.clear();
      _courseNameController.clear();
      _selectedSemesterForCourse = semesters.firstWhere((s) => s.isActive, orElse: () => semesters.first).code;
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
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _courseCodeController,
                  decoration: InputDecoration(
                    labelText: 'Course Code',
                    hintText: 'ex: CS451',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelStyle: TextStyle(color: isDark ? Colors.grey[300] : null),
                    hintStyle: TextStyle(color: isDark ? Colors.grey[500] : null),
                  ),
                  style: TextStyle(color: textColor),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _courseNameController,
                  decoration: InputDecoration(
                    labelText: 'Course Name',
                    hintText: 'ex: Computer Security',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelStyle: TextStyle(color: isDark ? Colors.grey[300] : null),
                    hintStyle: TextStyle(color: isDark ? Colors.grey[500] : null),
                  ),
                  style: TextStyle(color: textColor),
                ),
                const SizedBox(height: 16),
                Text(
                  'Semester',
                  style: TextStyle(fontSize: 16, color: textColor),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.blue.withOpacity(0.2) : Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton<String>(
                    value: _selectedSemesterForCourse,
                    onChanged: (String? newValue) {
                      setDialogState(() {
                        _selectedSemesterForCourse = newValue;
                      });
                    },
                    items: semesters.map<DropdownMenuItem<String>>((Semester semester) {
                      return DropdownMenuItem<String>(
                        value: semester.code,
                        child: Text(
                          '${semester.code} Semester',
                          style: TextStyle(color: textColor),
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    underline: Container(),
                    dropdownColor: isDark ? Colors.grey[850] : Colors.white,
                    icon: Icon(Icons.arrow_drop_down, color: isDark ? Colors.white70 : Colors.black54),
                  ),
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
                          backgroundColor: isDark ? Colors.red[900] : Colors.red[100],
                          foregroundColor: isDark ? Colors.white : Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Delete'),
                      )
                    else
                      const SizedBox(),
                    ElevatedButton(
                      onPressed: () {
                        if (_courseCodeController.text.isNotEmpty &&
                            _courseNameController.text.isNotEmpty &&
                            _selectedSemesterForCourse != null) {

                          final newCourse = Course(
                            code: _courseCodeController.text,
                            name: _courseNameController.text,
                          );

                          setState(() {
                            if (courseToEdit != null && semester != null) {
                              _updateCourse(courseToEdit, newCourse, semester);
                            } else {
                              _addCourse(newCourse);
                            }
                          });

                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
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

  void _addCourse(Course course) {
    final targetSemester = semesters.firstWhere(
          (s) => s.code == _selectedSemesterForCourse,
      orElse: () => semesters.first,
    );

    targetSemester.courses.add(course);
  }

  void _updateCourse(Course oldCourse, Course newCourse, Semester oldSemester) {
    // If semester changed
    if (oldSemester.code != _selectedSemesterForCourse) {
      // Remove from old semester
      oldSemester.courses.remove(oldCourse);

      // Add to new semester
      final newSemester = semesters.firstWhere(
            (s) => s.code == _selectedSemesterForCourse,
      );
      newSemester.courses.add(newCourse);
    } else {
      // Just update the course within the same semester
      final index = oldSemester.courses.indexOf(oldCourse);
      if (index != -1) {
        oldSemester.courses[index] = newCourse;
      }
    }
  }

  void _deleteCourse(Course course, Semester semester) {
    setState(() {
      semester.courses.remove(course);
    });
  }

  void _toggleSemesterActive(Semester semester) {
    setState(() {
      if (!semester.isActive) {
        // Deactivate all semesters first
        for (var s in semesters) {
          s.isActive = false;
        }
        // Then activate the selected one
        semester.isActive = true;
      } else {
        // If already active, just deactivate
        semester.isActive = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the current theme's brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.displayMedium!.color!;
    final secondaryTextColor = Theme.of(context).textTheme.bodyMedium!.color!;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Courses',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    'Manage your course list by semester',
                    style: TextStyle(
                      fontSize: 14,
                      color: secondaryTextColor,
                    ),
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
                    onEditCourse: (course) => _showAddCourseDialog(
                      courseToEdit: course,
                      semester: semester,
                    ),
                    isDarkMode: isDark,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _showAddCourseDialog(),
                      icon: const Icon(Icons.add),
                      label: const Text('Add Course'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark ? Colors.blue[900] : Colors.blue[100],
                        foregroundColor: isDark ? Colors.white : Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: _showCreateSemesterDialog,
                      style: TextButton.styleFrom(
                        foregroundColor: isDark ? Colors.white : Colors.blue,
                        backgroundColor: isDark ? Colors.blue[900] : Colors.blue[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text('Create Semester'),
                    ),
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

class SemesterSection extends StatefulWidget {
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
  _SemesterSectionState createState() => _SemesterSectionState();
}

class _SemesterSectionState extends State<SemesterSection> {
  bool _isExpanded = true;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.semester.isActive;
  }

  @override
  void didUpdateWidget(SemesterSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.semester.isActive != widget.semester.isActive) {
      setState(() {
        _isExpanded = widget.semester.isActive;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textColor = widget.isDarkMode ? Colors.white : Colors.black;

    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  _isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
                  color: textColor,
                ),
                const SizedBox(width: 8),
                Text(
                  '${widget.semester.code} Semester',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: widget.onToggleActive,
                  child: Text(
                    widget.semester.isActive ? 'Activated' : 'Not Active',
                    style: TextStyle(
                      color: widget.semester.isActive ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.semester.courses.length,
            itemBuilder: (context, index) {
              final course = widget.semester.courses[index];
              return CourseCard(
                course: course,
                onEdit: () => widget.onEditCourse(course),
                isDarkMode: widget.isDarkMode,
              );
            },
          ),
      ],
    );
  }
}

class CourseCard extends StatelessWidget {
  final Course course;
  final VoidCallback onEdit;
  final bool isDarkMode;

  const CourseCard({
    Key? key,
    required this.course,
    required this.onEdit,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final secondaryTextColor = isDarkMode ? Colors.grey[400] : Colors.grey[600];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 75,
            child: Text(
              course.code,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              course.name,
              style: TextStyle(
                fontSize: 15,
                color: secondaryTextColor,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, size: 20),
            onPressed: onEdit,
            color: isDarkMode ? Colors.grey[400] : Colors.grey,
          ),
        ],
      ),
    );
  }
}

class Semester {
  final String code;
  bool isActive;
  final List<Course> courses;

  Semester({
    required this.code,
    required this.isActive,
    required this.courses,
  });
}

class Course {
  final String code;
  final String name;

  Course({
    required this.code,
    required this.name,
  });
}