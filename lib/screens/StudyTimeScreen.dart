import 'package:flutter/material.dart';

class StudyTimeScreen extends StatefulWidget {
  @override
  _StudyTimeScreenState createState() => _StudyTimeScreenState();
}

class _StudyTimeScreenState extends State<StudyTimeScreen> {
  // Default study time settings
  Map<String, TimeRange> studyTimes = {
    'Sunday': TimeRange(const TimeOfDay(hour: 13, minute: 0), const TimeOfDay(hour: 20, minute: 30)),
    'Monday': TimeRange(const TimeOfDay(hour: 12, minute: 0), const TimeOfDay(hour: 18, minute: 0)),
    'Tuesday': TimeRange(const TimeOfDay(hour: 14, minute: 30), const TimeOfDay(hour: 20, minute: 0)),
    'Wednesday': TimeRange(const TimeOfDay(hour: 14, minute: 0), const TimeOfDay(hour: 20, minute: 0)),
    'Thursday': TimeRange(const TimeOfDay(hour: 13, minute: 0), const TimeOfDay(hour: 22, minute: 0)),
    'Friday': TimeRange(null, null),
    'Saturday': TimeRange(null, null),
  };

  @override
  Widget build(BuildContext context) {
    // Get current theme information
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.displayMedium!.color!;
    final secondaryTextColor = Theme.of(context).textTheme.bodyMedium!.color!;
    final accentColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: accentColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Study time',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            ),
            Text(
              'Set your free time',
              style: TextStyle(
                fontSize: 14,
                color: secondaryTextColor,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: studyTimes.entries.map((entry) {
          final day = entry.key;
          final timeRange = entry.value;
          final isEnabled = timeRange.start != null && timeRange.end != null;

          return ListTile(
            title: Text(
              day,
              style: TextStyle(
                color: accentColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                isEnabled
                    ? Text(
                  '${_formatTimeOfDay(timeRange.start!)} - ${_formatTimeOfDay(timeRange.end!)}',
                  style: TextStyle(color: textColor),
                )
                    : SizedBox(),
                Switch(
                  value: isEnabled,
                  onChanged: (value) {
                    setState(() {
                      if (value) {
                        // Enable this day with default times
                        studyTimes[day] = TimeRange(
                            const TimeOfDay(hour: 14, minute: 0),
                            const TimeOfDay(hour: 20, minute: 0)
                        );
                      } else {
                        // Disable this day
                        studyTimes[day] = TimeRange(null, null);
                      }
                    });
                  },
                  activeColor: accentColor,
                ),
              ],
            ),
            onTap: isEnabled ? () async {
              // When tapped, allow the user to edit the time range
              final TimeOfDay? newStartTime = await showTimePicker(
                context: context,
                initialTime: timeRange.start!,
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.fromSeed(
                        seedColor: accentColor,
                        brightness: isDark ? Brightness.dark : Brightness.light,
                      ),
                    ),
                    child: child!,
                  );
                },
              );

              if (newStartTime != null) {
                final TimeOfDay? newEndTime = await showTimePicker(
                  context: context,
                  initialTime: timeRange.end!,
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.fromSeed(
                          seedColor: accentColor,
                          brightness: isDark ? Brightness.dark : Brightness.light,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );

                if (newEndTime != null) {
                  setState(() {
                    studyTimes[day] = TimeRange(newStartTime, newEndTime);
                  });
                }
              }
            } : null,
          );
        }).toList(),
      ),
    );
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class TimeRange {
  final TimeOfDay? start;
  final TimeOfDay? end;

  TimeRange(this.start, this.end);
}