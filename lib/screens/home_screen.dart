import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gr/NavigationHandler.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/schedule_item.dart';
import '../utils/constants.dart';
import 'course_detail_screen.dart';
import '../components/bottomNavigationBar.dart';
import 'Courses.dart'; // Import the CoursesPage
import '../utils/theme_controller.dart'; // Import the theme controller

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ScheduleItem> scheduleItems = [
    ScheduleItem(
      courseId: 'CS348',
      courseName: 'CS 348',
      topic: 'Second directional derivatives, Conjugate gradient',
      details: 'Chapter 3, Slides 22-34',
      startTime: DateTime.now().add(Duration(hours: 2)),
      endTime: DateTime.now().add(Duration(hours: 2, minutes: 30)),
    ),
    ScheduleItem(
      courseId: 'CS432',
      courseName: 'CS 432',
      topic: 'Study for 1st Quiz',
      details: 'Chapter 1, Slides 5-28',
      startTime: DateTime.now().add(Duration(hours: 3, minutes: 30)),
      endTime: DateTime.now().add(Duration(hours: 4, minutes: 30)),
    ),
    ScheduleItem(
      courseId: 'MATH218',
      courseName: 'MATH 218',
      topic: 'Laplace Transform',
      details: 'Chapter 7, Section 7.1',
      startTime: DateTime.now().add(Duration(days: 1)),
      endTime: DateTime.now().add(Duration(days: 1, hours: 1, minutes: 30)),
    ),
    ScheduleItem(
      courseId: 'CS432',
      courseName: 'CS 432',
      topic: 'Study for 1st Quiz',
      details: 'Chapter 1, Slides 5-28',
      startTime: DateTime.now().add(Duration(days: 1, hours: 6, minutes: 40)),
      endTime: DateTime.now().add(Duration(days: 1, hours: 7, minutes: 10)),
    ),
  ];

  int _selectedIndex = 0;
  bool _showCoursesDropdown = false;
  bool _showCategoryDropdown = false;
  String _username = '';
  String _selectedSubject = 'All subjects';
  String _selectedCategory = 'Category';
  final ThemeController _themeController = ThemeController();

  // Course data
  final List<Map<String, String>> courses = [
    {'id': 'All', 'name': 'All subjects'},
    {'id': 'CS348', 'name': 'CS 348', 'description': 'Optimization Techniques'},
    {'id': 'CS471', 'name': 'CS 471', 'description': 'Web Technologies'},
    {'id': 'CS451', 'name': 'CS 451', 'description': 'Computer Security'},
    {'id': 'MATH218', 'name': 'MATH 218', 'description': 'Differential Equations'},
    {'id': 'CS432', 'name': 'CS 432', 'description': 'Data Structures'},
  ];

  // Category filters
  final List<String> categories = ['Category', 'Homework', 'Lecture', 'Quiz', 'Lab'];

  @override
  void initState() {
    super.initState();
    _loadUserPreferences();
  }

  void _loadUserPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? '';
      _selectedSubject = prefs.getString('selectedSubject') ?? 'All subjects';
      _selectedCategory = prefs.getString('selectedCategory') ?? 'Category';
    });
  }

  void _saveUserPreferences(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    // Get the current theme's brightness and colors
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textPrimaryColor = Theme.of(context).textTheme.displayMedium!.color!;
    final textSecondaryColor = Theme.of(context).textTheme.bodyMedium!.color!;
    final cardColor = Theme.of(context).cardTheme.color!;
    final borderColor = isDark ? Colors.grey[800]! : Colors.white;

    // Group items by date
    Map<String, List<ScheduleItem>> groupedItems = {};

    for (var item in scheduleItems) {
      String dateKey = DateFormat('yyyy-MM-dd').format(item.startTime);
      if (!groupedItems.containsKey(dateKey)) {
        groupedItems[dateKey] = [];
      }
      groupedItems[dateKey]!.add(item);
    }

    // Sort dates
    List<String> sortedDates = groupedItems.keys.toList()..sort();

    return ValueListenableBuilder<bool>(
      valueListenable: _themeController.isDarkMode,
      builder: (context, isDarkMode, child) {
        return Scaffold(
          backgroundColor: backgroundColor,
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Hi $_username',
                                    style: Theme.of(context).textTheme.displayMedium,
                                  ),
                                  Icon(Icons.waving_hand, color: Colors.amber),
                                ],
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Let's Find Your ",
                                      style: TextStyle(color: textPrimaryColor),
                                    ),
                                    TextSpan(
                                      text: "Course!",
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => NavigationHandler(initialIndex: 1),
                                            ),
                                          );
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            backgroundColor: AppColors.primary.withOpacity(0.2),
                            radius: 24,
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/Avatar-14.png',
                                width: 32, // Adjust size here
                                height: 32,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.all(0),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.transparent), // Keep outer border transparent
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Today\'s Quote',
                              style: TextStyle(
                                fontSize: 14,
                                color: textSecondaryColor,
                              ),
                            ),
                            const SizedBox(height: 4),

                            // Container wrapping the quote text
                            Container(
                              padding: EdgeInsets.only(left: 8), // Padding for left space
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: AppColors.primary, // Left border with theme-appropriate color
                                    width: 4, // Border width
                                  ),
                                ),
                              ),
                              child: Text(
                                '"Small steps every day lead to big achievements."',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontStyle: FontStyle.italic,
                                  color: textPrimaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showCoursesDropdown = !_showCoursesDropdown;
                                  _showCategoryDropdown = false;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                  color: cardColor,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: borderColor),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.category, color: isDark ? Colors.grey[400] : Colors.grey),
                                    SizedBox(width: 8),
                                    Text(
                                      _selectedSubject,
                                      style: TextStyle(color: textPrimaryColor),
                                    ),
                                    Icon(_showCoursesDropdown ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                                        color: textPrimaryColor),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showCategoryDropdown = !_showCategoryDropdown;
                                  _showCoursesDropdown = false;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: cardColor,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: borderColor),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.filter_list, color: isDark ? Colors.grey[400] : Colors.grey),
                                    SizedBox(width: 8),
                                    Text(
                                      _selectedCategory,
                                      style: TextStyle(color: textPrimaryColor),
                                    ),
                                    Icon(_showCategoryDropdown ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                                        color: textPrimaryColor),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: ListView.builder(
                          itemCount: sortedDates.length,
                          itemBuilder: (context, dateIndex) {
                            final dateKey = sortedDates[dateIndex];
                            final items = groupedItems[dateKey]!;
                            final date = DateFormat('yyyy-MM-dd').parse(dateKey);

                            // Format date header
                            String dateHeader;
                            if (DateFormat('yyyy-MM-dd').format(DateTime.now()) == dateKey) {
                              dateHeader = 'Today, ${DateFormat('dd MMM').format(date)}';
                            } else if (DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 1))) == dateKey) {
                              dateHeader = 'Tomorrow, ${DateFormat('dd MMM').format(date)}';
                            } else {
                              dateHeader = DateFormat('EEEE, dd MMM').format(date);
                            }

                            // Get day name for the right side
                            String dayName = DateFormat('EEEE').format(date);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      dateHeader,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: textSecondaryColor,
                                      ),
                                    ),
                                    Text(
                                      dayName,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                ...items.map((item) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (item.courseId == 'CS432') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CourseDetailScreen(),
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 12),
                                      decoration: BoxDecoration(
                                        color: cardColor,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: isDark
                                                ? Colors.black.withOpacity(0.3)
                                                : Colors.black.withOpacity(0.05),
                                            blurRadius: 5,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '${DateFormat('HH:mm').format(item.startTime)}',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: textPrimaryColor,
                                                  ),
                                                ),
                                                Text(
                                                  ' - ${DateFormat('HH:mm').format(item.endTime)}',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: textSecondaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              item.courseName,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: item.courseName == 'CS 432'
                                                    ? AppColors.primary
                                                    : (item.courseName == 'MATH 218' ? Colors.green : Colors.orange),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              item.topic,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: textPrimaryColor,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              item.details,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: textSecondaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // Courses Dropdown
                if (_showCoursesDropdown)
                  Positioned(
                    top: 190, // Adjust this value based on your design
                    left: 16,
                    right: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black.withOpacity(0.3)
                                : Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: courses.map((course) => InkWell(
                          onTap: () {
                            setState(() {
                              _selectedSubject = course['name']!;
                              _showCoursesDropdown = false;
                              // Save to SharedPreferences
                              _saveUserPreferences('selectedSubject', course['name']!);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: course['name'] == _selectedSubject
                                  ? isDark ? AppColors.primary.withOpacity(0.2) : Color(0xFFEAF5FF)
                                  : cardColor,
                              border: Border(
                                bottom: BorderSide(
                                  color: isDark ? Colors.grey[800]! : Colors.grey.withOpacity(0.1),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  course['name']!,
                                  style: TextStyle(
                                    color: course['id'] != 'All' ? AppColors.primary : textPrimaryColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (course['id'] != 'All' && course['description'] != null)
                                  Text(
                                    course['description']!,
                                    style: TextStyle(
                                      color: textSecondaryColor,
                                      fontSize: 14,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        )).toList(),
                      ),
                    ),
                  ),

                // Category Dropdown
                if (_showCategoryDropdown)
                  Positioned(
                    top: 190, // Adjust this value based on your design
                    left: 16,
                    right: 16,
                    child: Container(
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: isDark
                                ? Colors.black.withOpacity(0.3)
                                : Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: categories.map((category) => InkWell(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category;
                              _showCategoryDropdown = false;
                              // Save to SharedPreferences
                              _saveUserPreferences('selectedCategory', category);
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: category == _selectedCategory
                                  ? isDark ? AppColors.primary.withOpacity(0.2) : Color(0xFFEAF5FF)
                                  : cardColor,
                              border: Border(
                                bottom: BorderSide(
                                  color: isDark ? Colors.grey[800]! : Colors.grey.withOpacity(0.1),
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Text(
                              category,
                              style: TextStyle(
                                color: category != 'Category' ? AppColors.primary : textPrimaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )).toList(),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}