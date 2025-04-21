import 'package:flutter/material.dart';
import 'package:gr/components/bottomNavigationBar.dart';
import 'package:gr/screens/Courses.dart';

import 'screens/home_screen.dart';
import 'screens/course_detail_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/settings_screen.dart';

class NavigationHandler extends StatefulWidget {
  @override
  _NavigationHandlerState createState() => _NavigationHandlerState();
}

class _NavigationHandlerState extends State<NavigationHandler> {
  int _selectedIndex = 0;

  // List of screens for the navigation bar
  final List<Widget> _screens = [
    HomeScreen(),
    CoursesPage(),
    NotificationsScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: AppNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}