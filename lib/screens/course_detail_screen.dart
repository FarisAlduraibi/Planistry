import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../tabs/files_tab.dart';
import '../tabs/planisty_tab.dart';
import '../tabs/quiz_tab.dart';
import '../tabs/flash_cards_tab.dart';
import '../utils/theme_controller.dart';

class CourseDetailScreen extends StatefulWidget {
  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;
  final ThemeController _themeController = ThemeController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get theme properties
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = Theme.of(context).cardColor;
    final textColor = Theme.of(context).textTheme.displayMedium!.color!;
    final secondaryTextColor = Theme.of(context).textTheme.bodyMedium!.color!;

    return ValueListenableBuilder<bool>(
      valueListenable: _themeController.isDarkMode,
      builder: (context, isDarkMode, child) {
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: isDark ? Colors.black : Colors.white,
            elevation: 0.5,
            leading: IconButton(
              icon: Icon(Icons.arrow_back,
                  color: isDark ? Colors.white : Colors.blue),
              onPressed: () => Navigator.pop(context),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CS 432',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  'Artificial Intelligence',
                  style: TextStyle(
                    fontSize: 14,
                    color: secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Container(
                color: cardColor,
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInfoColumn('8', 'Chapters'),
                    _buildInfoColumn('2', 'Quizzes'),
                    _buildInfoColumn('5', 'Assignments'),
                  ],
                ),
              ),
              Container(
                color: cardColor,
                child: TabBar(
                  controller: _tabController,
                  tabs: [
                    Tab(text: 'Files'),
                    Tab(text: 'Planisty'),
                    Tab(text: 'Quiz'),
                    Tab(text: 'Flash Cards'),
                  ],
                  labelColor: AppColors.primary,
                  unselectedLabelColor: isDark ? Colors.white60 : Colors.grey,
                  indicatorColor: AppColors.primary,
                  indicatorSize: TabBarIndicatorSize.label,
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    FilesTab(),
                    PlanistyTab(),
                    QuizTab(),
                    FlashCardsTab(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoColumn(String value, String label) {
    final textColor = Theme.of(context).textTheme.displayMedium!.color!;
    final secondaryTextColor = Theme.of(context).textTheme.bodyMedium!.color!;

    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: secondaryTextColor,
          ),
        ),
      ],
    );
  }
}