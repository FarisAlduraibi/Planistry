import 'package:flutter/material.dart';
import '../utils/constants.dart';

class NotificationsScreen extends StatelessWidget {
  // Sample data - replace with your actual data source
  final List<Map<String, dynamic>> notifications = [
    {
      'course': 'CS432',
      'activity': 'Study for Quiz',
      'timeRange': '12:00 - 12:30',
    },
    {
      'course': 'CS471',
      'activity': 'Study Time',
      'timeRange': '14:00 - 15:30',
    },
    {
      'course': 'CS323',
      'activity': 'Study Time',
      'timeRange': '20:00 - 21:00',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Get the current theme's brightness and colors
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
            // Header section styled like courses page
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Notifications',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    'Keep in touch with everything',
                    style: TextStyle(
                      fontSize: 14,
                      color: secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ),

            // Today header
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8),
              child: Text(
                'Today',
                style: TextStyle(
                  fontSize: 14,
                  color: secondaryTextColor,
                ),
              ),
            ),

            // Notifications content
            notifications.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: isDark ? Colors.grey[800] : Colors.grey[300],
                        radius: 16,
                      ),
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${notification['course']} ",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: notification['activity'],
                              style: TextStyle(
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      trailing: Text(
                        notification['timeRange'],
                        style: TextStyle(
                          color: secondaryTextColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
                : Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      child: Center(
                        child: isDark
                            ? Icon(Icons.notifications_off, size: 64, color: Colors.grey[600])
                            : Image.asset(
                          'assets/images/Notification.png',
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'No notification yet!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF007FFF),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Any notification will appear here',
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}