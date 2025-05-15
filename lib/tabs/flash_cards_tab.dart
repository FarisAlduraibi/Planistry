import 'package:flutter/material.dart';
import 'package:gr/tabs/FlashCardsScreen.dart';
import '../utils/constants.dart';
import '../utils/theme_controller.dart';

class FlashCardsTab extends StatelessWidget {
  final ThemeController _themeController = ThemeController();

  // Sample data - replace with your actual data source
  final List<Map<String, dynamic>> flashCards = [
    {
      'id': '01',
      'title': 'Flash cards 01',
    },
    // Add more flash card sets as needed
  ];

  @override
  Widget build(BuildContext context) {
    bool hasFlashCards = flashCards.isNotEmpty;

    // Get theme properties
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.bodyLarge!.color!;
    final secondaryTextColor = Theme.of(context).textTheme.bodyMedium!.color!;

    return ValueListenableBuilder<bool>(
      valueListenable: _themeController.isDarkMode,
      builder: (context, isDarkMode, child) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: hasFlashCards
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: flashCards.length,
                itemBuilder: (context, index) {
                  final cardSet = flashCards[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          cardSet['title'],
                          style: TextStyle(
                            fontSize: 16,
                            color: textColor,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Show flash cards functionality
                          },
                          child: Text(
                            'Show',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
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
                      MaterialPageRoute(builder: (context) => FlashCardsScreen()),
                    );
                  },
                  child: Text('Generate Flash Cards'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
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
                'assets/images/flashcard.png',
                width: 150,
                height: 150,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/flashcard.png',
                    width: 150,
                    height: 150,
                  );
                },
              ),
              SizedBox(height: 24),
              Text(
                'You have no Flash Cards Yet.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: secondaryTextColor,
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FlashCardsScreen()),
                  );
                },
                child: Text('Generate Flash Cards'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
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
      },
    );
  }
}