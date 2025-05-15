import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/theme_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final ThemeController _themeController = ThemeController();
  final _formKey = GlobalKey<FormState>();

  // Password controllers
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Visibility toggles
  bool _currentPasswordVisible = false;
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    // Get the current theme's brightness and colors
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = Theme.of(context).textTheme.displayMedium!.color!;
    final secondaryTextColor = Theme.of(context).textTheme.bodyMedium!.color!;
    final cardColor = Theme.of(context).cardTheme.color!;

    return ValueListenableBuilder<bool>(
      valueListenable: _themeController.isDarkMode,
      builder: (context, isDarkMode, child) {
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: backgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: isDark ? Colors.white : Colors.blue),
              onPressed: () => Navigator.pop(context),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Change Password',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
                Text(
                  'Update your password',
                  style: TextStyle(
                    fontSize: 14,
                    color: secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Security icon
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lock_outline,
                        size: 40,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'Password Requirements:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  _buildRequirement('• At least 8 characters', secondaryTextColor),
                  _buildRequirement('• Include at least one uppercase letter', secondaryTextColor),
                  _buildRequirement('• Include at least one number', secondaryTextColor),
                  _buildRequirement('• Include at least one special character', secondaryTextColor),
                  SizedBox(height: 24),

                  // Current password field
                  _buildPasswordField(
                    controller: _currentPasswordController,
                    label: 'Current Password',
                    isVisible: _currentPasswordVisible,
                    toggleVisibility: () {
                      setState(() {
                        _currentPasswordVisible = !_currentPasswordVisible;
                      });
                    },
                    isDark: isDark,
                    textColor: textColor,
                    cardColor: cardColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your current password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  // New password field
                  _buildPasswordField(
                    controller: _newPasswordController,
                    label: 'New Password',
                    isVisible: _newPasswordVisible,
                    toggleVisibility: () {
                      setState(() {
                        _newPasswordVisible = !_newPasswordVisible;
                      });
                    },
                    isDark: isDark,
                    textColor: textColor,
                    cardColor: cardColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a new password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      // Check for uppercase, number, and special character
                      final hasUppercase = value.contains(RegExp(r'[A-Z]'));
                      final hasNumber = value.contains(RegExp(r'[0-9]'));
                      final hasSpecialChar = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

                      if (!hasUppercase) {
                        return 'Include at least one uppercase letter';
                      }
                      if (!hasNumber) {
                        return 'Include at least one number';
                      }
                      if (!hasSpecialChar) {
                        return 'Include at least one special character';
                      }

                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  // Confirm password field
                  _buildPasswordField(
                    controller: _confirmPasswordController,
                    label: 'Confirm New Password',
                    isVisible: _confirmPasswordVisible,
                    toggleVisibility: () {
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible;
                      });
                    },
                    isDark: isDark,
                    textColor: textColor,
                    cardColor: cardColor,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your new password';
                      }
                      if (value != _newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 32),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Password update logic would go here
                          // For this example, we'll just show a success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Password updated successfully')),
                          );

                          // Clear the form
                          _currentPasswordController.clear();
                          _newPasswordController.clear();
                          _confirmPasswordController.clear();
                        }
                      },
                      child: Text(
                        'Update Password',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRequirement(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: color,
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool isVisible,
    required Function toggleVisibility,
    required bool isDark,
    required Color textColor,
    required Color cardColor,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: textColor,
          ),
        ),
        SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isDark ? Colors.grey[800]! : Colors.grey[300]!,
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: !isVisible,
            decoration: InputDecoration(
              hintText: 'Enter password',
              hintStyle: TextStyle(
                color: isDark ? Colors.grey[500] : Colors.grey[400],
              ),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: AppColors.primary,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  isVisible ? Icons.visibility_off : Icons.visibility,
                  color: isDark ? Colors.grey[500] : Colors.grey[600],
                ),
                onPressed: () => toggleVisibility(),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
            ),
            style: TextStyle(
              color: textColor,
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}