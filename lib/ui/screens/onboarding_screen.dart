import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/app_colors.dart';
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
      'title': 'Integrated academic management',
      'subtitle': 'Platform to handle student operations.',
      'image': 'assets/images/onboarding1.png',
    },
    {
      'title': 'Automated study plan generation',
      'subtitle': 'Based on university rules & standards.',
      'image': 'assets/images/onboarding2.png',
    },
    {
      'title': 'Course material uploads',
      'subtitle': 'By instructors and other members.',
      'image': 'assets/images/onboarding3.png',
    },
    {
      'title': 'Robust notification system',
      'subtitle': 'To deliver alerts & tasks.',
      'image': 'assets/images/onboarding4.png',
    },
  ];

  void goToNextPage() {
    if (currentIndex < onboardingData.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: onboardingData.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return OnboardingCard(
                      title: onboardingData[index]['title']!,
                      subtitle: onboardingData[index]['subtitle']!,
                      imagePath: onboardingData[index]['image']!,
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(onboardingData.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: currentIndex == index
                            ? AppColors.primary
                            : Colors.grey.shade300,
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: CustomButton(
                  text: currentIndex == onboardingData.length - 1 ? "Done" : "Next",
                  onTap: goToNextPage,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
