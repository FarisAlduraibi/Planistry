import 'package:flutter/material.dart';
import 'package:gr/screens/StudyTimeScreen.dart';
import 'package:gr/screens/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';


class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'Set your preferences',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
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
            onTap: () {},
          ),
          _buildSettingsItem(
            icon: Icons.lock_outline,
            iconColor: Colors.blue,
            title: 'Change Password',
            hasChevron: true,
            onTap: () {},
          ),
          _buildSettingsItem(
            icon: Icons.help_outline,
            iconColor: Colors.blue,
            title: 'FAQ',
            hasChevron: true,
            onTap: () {},
          ),
          _buildSettingsItem(
            icon: Icons.privacy_tip_outlined,
            iconColor: Colors.blue,
            title: 'Privacy & Policy',
            hasChevron: true,
            onTap: () {},
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
            },
          ),
          _buildSettingsItem(
            icon: Icons.dark_mode_outlined,
            iconColor: Colors.blue,
            title: 'Dark Mode',
            hasSwitch: true,
            switchValue: _darkModeEnabled,
            onSwitchChanged: (value) {
              setState(() {
                _darkModeEnabled = value;
              });
            },
          ),
          _buildSettingsItem(
            icon: Icons.logout,
            iconColor: Colors.red,
            title: 'Logout',
            textColor: Colors.red,
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear(); // remove access_token, refresh_token, username, etc.

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
                    (route) => false,
              );
            },
          ),
        ],
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
          color: textColor ?? Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: hasChevron
          ? Icon(Icons.chevron_right, color: Colors.grey)
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