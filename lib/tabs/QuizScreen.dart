import 'package:flutter/material.dart';
import '../utils/constants.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // Track selected answers
  Map<int, String> selectedAnswers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'Quiz 01',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Multiple Choice Questions',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildQuestion(
                    1,
                    'Which data structure uses LIFO (Last In, First Out) principle?',
                    ['Queue', 'Array', 'Stack', 'Linked List'],
                  ),
                  SizedBox(height: 16),
                  _buildQuestion(
                    2,
                    'What does HTTP stand for?',
                    [
                      'HyperText Transfer Protocol',
                      'Hyperlink Text Transfer Protocol',
                      'Hyper Transfer Text Protocol',
                      'HighText Transfer Protocol'
                    ],
                  ),
                  SizedBox(height: 16),
                  _buildQuestion(
                    3,
                    'Which sorting algorithm has the best average-case time complexity?',
                    ['Bubble Sort', 'Selection Sort', 'Insertion Sort', 'Merge Sort'],
                  ),
                  SizedBox(height: 16),
                  _buildQuestion(
                    4,
                    'In Python, what does the len() function do?',
                    [
                      'Converts data type',
                      'Returns length of an object',
                      'Prints the object',
                      'Appends data to a list'
                    ],
                  ),
                  SizedBox(height: 16),
                  _buildQuestion(
                    5,
                    'What is the best Character in Marvel Rivals?',
                    ['Bucky', 'Bucky', 'Bucky', 'Bucky'],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to result screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizResultScreen()),
                  );
                },
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          // Bottom navigation bar
        ],
      ),
    );
  }

  Widget _buildQuestion(int number, String question, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$number. $question',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        ...List.generate(
          options.length,
              (index) {
            String option = options[index];
            String optionLetter = String.fromCharCode(65 + index); // A, B, C, D
            return RadioListTile<String>(
              title: Text('$optionLetter. $option'),
              value: optionLetter,
              groupValue: selectedAnswers[number],
              onChanged: (value) {
                setState(() {
                  selectedAnswers[number] = value!;
                });
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              activeColor: Colors.blue,
            );
          },
        ),
      ],
    );
  }
}

class QuizResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'Quiz 01',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Result 8/10',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Question 1
                  Text(
                    'Q1',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'question question question ?',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '0/1',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  _buildResultOption('A. choice 1', false, false),
                  _buildResultOption('A. choice 1', true, false),
                  _buildResultOption('A. choice 1', false, false),
                  _buildResultOption('A. choice 1', false, true),

                  SizedBox(height: 24),

                  // Question 2
                  Text(
                    'Q2',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'question question question ?',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '1/1',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  _buildResultOption('A. choice 1', false, false),
                  _buildResultOption('A. choice 1', false, false),
                  _buildResultOption('A. choice 1', false, true),
                  _buildResultOption('A. choice 1', false, false),
                ],
              ),
            ),
          ),
          // Bottom navigation bar

        ],
      ),
    );
  }

  Widget _buildResultOption(String text, bool isWrong, bool isCorrect) {
    Color dotColor = Colors.grey;
    if (isWrong) {
      dotColor = Colors.red;
    } else if (isCorrect) {
      dotColor = Colors.green;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: dotColor,
            ),
          ),
        ],
      ),
    );
  }
}