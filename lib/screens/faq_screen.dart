import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/theme_controller.dart';

class FAQScreen extends StatefulWidget {
  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final ThemeController _themeController = ThemeController();

  // Track expanded items
  List<bool> _expandedItems = [];

  // FAQ items
  final List<Map<String, String>> _faqItems = [
    {
      'question': 'How do I add a new course?',
      'answer': 'To add a new course, go to the Courses tab, tap on the "+" button at the bottom right corner, then fill in the course details and save.'
    },
    {
      'question': 'How can I set up study reminders?',
      'answer': 'In the Settings menu, select "Study time" to set up your preferred study hours for each day of the week. The app will send you reminders based on these settings if notifications are enabled.'
    },
    {
      'question': 'Can I customize the app appearance?',
      'answer': 'Yes, you can switch between light and dark mode in the Settings menu by toggling the "Dark Mode" option.'
    },
    {
      'question': 'How do I track my study progress?',
      'answer': 'The app automatically tracks your study sessions. You can view your progress in the Dashboard tab, which shows statistics on your study habits and completed tasks.'
    },
    {
      'question': 'Can I export my study data?',
      'answer': 'Currently, the app does not support exporting study data. This feature is planned for a future update.'
    },
    {
      'question': 'How do I create a study schedule?',
      'answer': 'Go to the Courses tab, select a course, then tap "Add Study Session". Choose the topic, date, time, and duration for your study session.'
    },
    {
      'question': 'Is my data backed up?',
      'answer': 'Yes, your data is automatically backed up to your account when you\'re connected to the internet. Make sure you\'re logged in to enable this feature.'
    },
    {
      'question': 'How do I report a bug?',
      'answer': 'If you encounter any issues, please go to Settings > Help & Support > Report a Problem to send us details about the bug you\'ve found.'
    },
  ];

  @override
  void initState() {
    super.initState();
    // Initialize all FAQs as collapsed
    _expandedItems = List.generate(_faqItems.length, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    // Get the current theme's brightness and colors
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.displayMedium!.color!;
    final secondaryTextColor = Theme.of(context).textTheme.bodyMedium!.color!;
    final cardColor = Theme.of(context).cardTheme.color!;

    return ValueListenableBuilder<bool>(
      valueListenable: _themeController.isDarkMode,
      builder: (context, isDarkMode, child) {
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: backgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: isDark ? Colors.white : Colors.blue),
              onPressed: () => Navigator.pop(context),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Frequently Asked Questions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  'Find answers to common questions',
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
              // Search bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for questions',
                      hintStyle: TextStyle(
                        color: isDark ? Colors.grey[500] : Colors.grey[400],
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.primary,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 16,
                      ),
                    ),
                    style: TextStyle(
                      color: textColor,
                    ),
                    onChanged: (value) {
                      // Search functionality would go here
                    },
                  ),
                ),
              ),

              // FAQ List
              Expanded(
                child: ListView.builder(
                  itemCount: _faqItems.length,
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  itemBuilder: (context, index) {
                    return Card(
                      color: cardColor,
                      margin: EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: isDark ? 0.5 : 1.0,
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        title: Text(
                          _faqItems[index]['question']!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: textColor,
                          ),
                        ),
                        trailing: Icon(
                          _expandedItems[index]
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: AppColors.primary,
                        ),
                        onExpansionChanged: (isExpanded) {
                          setState(() {
                            _expandedItems[index] = isExpanded;
                          });
                        },
                        initiallyExpanded: _expandedItems[index],
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                bottom: 16.0
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _faqItems[index]['answer']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: secondaryTextColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Still have questions section
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Still have questions?',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Contact our support team for more help',
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryTextColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          // Contact support logic would go here
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Support email sent')),
                          );
                        },
                        child: Text(
                          'Contact Support',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}