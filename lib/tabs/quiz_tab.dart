import 'package:flutter/material.dart';
import 'package:gr/tabs/QuizScreen.dart';

import '../utils/constants.dart';

class QuizTab extends StatelessWidget {
  // Sample data - replace with your actual data source
  final List<Map<String, dynamic>> quizzes = [
    {
      'id': '01',
      'title': 'Quiz 01',
      'score': '8/10',
      'hasResult': true,
    },
    {
      'id': '02',
      'title': 'Quiz 02',
      'score': '-/10',
      'hasResult': false,
    },
    // Add more quizzes as needed
  ];

  @override
  Widget build(BuildContext context) {
    bool hasQuizzes = quizzes.isNotEmpty;

    // Get current theme brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color ?? (isDark ? Colors.white : AppColors.textPrimary);
    final primaryColor = Theme.of(context).primaryColor;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: hasQuizzes
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: quizzes.length,
            itemBuilder: (context, index) {
              final quiz = quizzes[index];
              return Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      quiz['title'],
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          quiz['score'],
                          style: TextStyle(
                            color: quiz['hasResult'] ? primaryColor : Colors.red,
                          ),
                        ),
                        if (quiz['hasResult'])
                          TextButton(
                            onPressed: () {
                              // Show results functionality
                            },
                            child: Text(
                              'Show Results',
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizScreen()),
                );
              },
              child: Text('Generate Quiz'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                minimumSize: Size(200, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      )
          : Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/quiz.png',
            width: 150,
            height: 150,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/images/quiz.png',
                width: 150,
                height: 150,
              );
            },
          ),
          SizedBox(height: 24),
          Text(
            'You have no Quizzes Yet.',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white70 : AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizScreen()),
              );
            },
            child: Text('Generate Quiz'),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              minimumSize: Size(200, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}