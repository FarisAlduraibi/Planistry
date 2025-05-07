import 'package:flutter/material.dart';
import '../../core/app_text_styles.dart';

class OnboardingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const OnboardingCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 60),
          Image.asset(
            imagePath,
            height: 260,
          ),
          const SizedBox(height: 60),
          Text(
            title,
            style: AppTextStyles.title,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            subtitle,
            style: AppTextStyles.body,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
