import 'package:flutter/material.dart';
import 'package:gr/screens/get_started_screen.dart';

import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/onboarding_card.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/onboarding1.png',
      'title': 'Integrated academic management',
      'subtitle': 'platform for efficient study organization.',
    },
    {
      'image': 'assets/images/onboarding2.png',
      'title': 'Automated study plan generation',
      'subtitle': 'based on syllabus, user preferences, and deadlines.',
    },
    {
      'image': 'assets/images/onboarding3.png',
      'title': 'Course material uploads',
      'subtitle': 'for AI-generated quizzes and flashcards.',
    },
    {
      'image': 'assets/images/onboarding4.png',
      'title': 'Robust notification system',
      'subtitle': 'to keep students on track.',
    },
  ];

  void goToNextPage() {
    if (currentIndex < onboardingData.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const GetStartedScreen()),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() => currentIndex = index);
                },
                itemBuilder: (context, index) {
                  return OnboardingCard(
                    imagePath: onboardingData[index]['image']!,
                    title: onboardingData[index]['title']!,
                    subtitle: onboardingData[index]['subtitle']!,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentIndex == index
                        ? AppColors.primary
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: CustomButton(
                text: 'Next',
                onPressed: goToNextPage,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
