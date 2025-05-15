import 'package:flutter/material.dart';
import 'utils/theme.dart';
import 'screens/SplashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/theme_controller.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the theme controller before the app starts
  final themeController = ThemeController();
  await themeController.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController().isDarkMode,
      builder: (context, isDarkMode, child) {
        return MaterialApp(
          title: 'Course Planner',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: SplashScreen(), // SplashScreen will handle auth check
        );
      },
    );
  }
}