import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gr/Services/auth_service..dart';

import '../core/app_colors.dart';
import 'onboarding_screen.dart';
import '../NavigationHandler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  // Check if user is already logged in and redirect accordingly
  Future<void> _checkAuthentication() async {
    await Future.delayed(const Duration(seconds: 2)); // Show splash for 2 seconds

    if (!mounted) return;

    // Check if user is logged in
    final isLoggedIn = await AuthService.isLoggedIn();

    if (isLoggedIn) {
      // If logged in, go directly to home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => NavigationHandler()),
      );
    } else {
      // If not logged in, go to onboarding
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle.light,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Center(
                child: Image.asset(
                  'assets/images/splash_logo.png',
                  width: 180,
                  height: 180,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Welcome to ',
                        style: TextStyle(
                          fontSize: 19,
                          height: 1.26,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          letterSpacing: -0.49,
                        ),
                      ),
                      TextSpan(
                        text: 'PLANISTRY',
                        style: TextStyle(
                          fontSize: 19,
                          height: 1.26,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: -0.49,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}