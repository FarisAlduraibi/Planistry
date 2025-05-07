import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 27,
    fontWeight: FontWeight.w700,
    height: 32 / 27,
    letterSpacing: 0.35,
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    height: 24 / 17,
    letterSpacing: -0.41,
    color: AppColors.textSecondary,
  );

  static const TextStyle subBody = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 20 / 15,
    letterSpacing: -0.24,
    color: AppColors.textSecondary,
  );
}
