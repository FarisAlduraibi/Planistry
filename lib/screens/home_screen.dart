import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/schedule_item.dart';
import '../utils/constants.dart';
import 'course_detail_screen.dart';
import '../components/bottomNavigationBar.dart';

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

  @override

  String _username = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? '';
    });
  }

  Widget build(BuildContext context) {
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

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
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
                              style: TextStyle(color: AppColors.textPrimary),
                            ),
                            TextSpan(
                              text: "Course!",
                              style: TextStyle(color: Color(0xFF007AFF)),
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
                  color: AppColors.background,
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
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Container wrapping the quote text
                    Container(
                      padding: EdgeInsets.only(left: 8), // Padding for left space
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: Color(0xFF468CE7), // Left border with color #468CE7
                            width: 4, // Border width
                          ),
                        ),
                      ),
                      child: Text(
                        '"Small steps every day lead to big achievements."',
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: AppColors.textPrimary,
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
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.category, color: Colors.grey),
                          SizedBox(width: 8),
                          Text(
                            'All subjects',
                            style: TextStyle(color: AppColors.textPrimary),
                          ),
                          Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.filter_list, color: Colors.grey),
                          SizedBox(width: 8),
                          Text(
                            'Category',
                            style: TextStyle(color: AppColors.textPrimary),
                          ),
                          Icon(Icons.arrow_drop_down),
                        ],
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
                                color: AppColors.textSecondary,
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
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
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
                                            color: AppColors.textPrimary,
                                          ),
                                        ),
                                        Text(
                                          ' - ${DateFormat('HH:mm').format(item.endTime)}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors.textSecondary,
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
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.details,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textSecondary,
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
      ),

    );
  }
}