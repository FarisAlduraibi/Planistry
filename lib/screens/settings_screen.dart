import 'package:flutter/material.dart';
import 'package:gr/Services/auth_service..dart';
import 'package:gr/screens/StudyTimeScreen.dart';
import 'package:gr/screens/LoginScreen.dart';

import 'package:gr/screens/PrivacyPolicyScreen.dart';
import 'package:gr/screens/change_password_screen.dart';
import 'package:gr/screens/faq_screen.dart';
import 'package:gr/screens/personal_data_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';
import '../utils/theme_controller.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  final ThemeController _themeController = ThemeController();

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications') ?? true;
    });
  }

  _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('notifications', _notificationsEnabled);
  }

  @override
  Widget build(BuildContext context) {
    // Get the current theme's brightness
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.displayMedium!.color!;
    final secondaryTextColor = Theme.of(context).textTheme.bodyMedium!.color!;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section styled like courses page
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    'Set your preferences',
                    style: TextStyle(
                      fontSize: 14,
                      color: secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ),

            // Settings list
            Expanded(
              child: ValueListenableBuilder<bool>(
                valueListenable: _themeController.isDarkMode,
                builder: (context, isDarkMode, child) {
                  return ListView(
                    children: [
                      _buildSettingsItem(
                        icon: Icons.schedule,
                        iconColor: Colors.blue,
                        title: 'Study time',
                        hasChevron: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => StudyTimeScreen()),
                          );
                        },
                      ),
                      _buildSettingsItem(
                        icon: Icons.person_outline,
                        iconColor: Colors.blue,
                        title: 'Personal Data',
                        hasChevron: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PersonalDataScreen()),
                          );
                        },
                      ),
                      _buildSettingsItem(
                        icon: Icons.lock_outline,
                        iconColor: Colors.blue,
                        title: 'Change Password',
                        hasChevron: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
                          );
                        },
                      ),
                      _buildSettingsItem(
                        icon: Icons.help_outline,
                        iconColor: Colors.blue,
                        title: 'FAQ',
                        hasChevron: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FAQScreen()),
                          );
                        },
                      ),
                      _buildSettingsItem(
                        icon: Icons.privacy_tip_outlined,
                        iconColor: Colors.blue,
                        title: 'Privacy & Policy',
                        hasChevron: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
                          );
                        },
                      ),
                      _buildSettingsItem(
                        icon: Icons.notifications_outlined,
                        iconColor: Colors.blue,
                        title: 'App Notification',
                        hasSwitch: true,
                        switchValue: _notificationsEnabled,
                        onSwitchChanged: (value) {
                          setState(() {
                            _notificationsEnabled = value;
                          });
                          _savePreferences();
                        },
                      ),
                      _buildSettingsItem(
                        icon: Icons.dark_mode_outlined,
                        iconColor: Colors.blue,
                        title: 'Dark Mode',
                        hasSwitch: true,
                        switchValue: isDarkMode,
                        onSwitchChanged: (value) {
                          // Update the app theme using ThemeController
                          _themeController.toggleTheme(value);
                        },
                      ),
                      _buildSettingsItem(
                        icon: Icons.logout,
                        iconColor: Colors.red,
                        title: 'Logout',
                        textColor: Colors.red,
                        onTap: () async {
                          // Import auth_service.dart at the top of the file
                          // Use the AuthService to handle logout
                          await AuthService.logout();

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => LoginScreen()),
                                (route) => false,
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    Color? textColor,
    bool hasChevron = false,
    bool hasSwitch = false,
    bool switchValue = false,
    Function()? onTap,
    Function(bool)? onSwitchChanged,
  }) {
    // Get the current theme's text color from context
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultTextColor = isDark ? Colors.white : Colors.black87;

    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? defaultTextColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: hasChevron
          ? Icon(Icons.chevron_right, color: isDark ? Colors.white54 : Colors.grey)
          : hasSwitch
          ? Switch(
        value: switchValue,
        onChanged: onSwitchChanged,
        activeColor: Colors.blue,
      )
          : null,
      onTap: hasSwitch ? null : onTap,
    );
  }
}