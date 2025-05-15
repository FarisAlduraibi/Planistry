// RegisterScreen.dart
import 'package:flutter/material.dart';
import 'package:gr/Services/api_service.dart';
import '../utils/constants.dart';
import 'LoginScreen.dart';
import '../NavigationHandler.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Controllers for additional fields
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _countryController = TextEditingController();
  final _cityController = TextEditingController();
  final _universityController = TextEditingController();
  final _collegeController = TextEditingController();
  final _majorController = TextEditingController();
  final _levelController = TextEditingController();

  // State to track whether to show additional fields
  bool _showAdditionalFields = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _countryController.dispose();
    _cityController.dispose();
    _universityController.dispose();
    _collegeController.dispose();
    _majorController.dispose();
    _levelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive layout
    final screenSize = MediaQuery.of(context).size;
    final isSmallScreen = screenSize.width < 360;

    // Dynamic font sizes based on screen width
    final titleFontSize = isSmallScreen ? 20.0 : 24.0;
    final subtitleFontSize = isSmallScreen ? 13.0 : 16.0;
    final buttonFontSize = isSmallScreen ? 14.0 : 16.0;
    final labelFontSize = isSmallScreen ? 12.0 : 14.0;
    final hintFontSize = isSmallScreen ? 12.0 : 14.0;

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        // Remove the title from the AppBar
        title: SizedBox.shrink(),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 16.0 : 24.0,
                vertical: 8.0
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title below the back button
                Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Create an account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: subtitleFontSize,
                  ),
                ),
                SizedBox(height: 24),

                // Basic fields
                if (!_showAdditionalFields) ...[
                  _buildTextField(_nameController, 'What shall we call you?', fontSize: hintFontSize),
                  SizedBox(height: 16),
                  _buildTextField(_emailController, 'Enter your Email', fontSize: hintFontSize),
                  SizedBox(height: 16),
                  _buildTextField(_passwordController, 'Password', obscure: true, fontSize: hintFontSize),
                  SizedBox(height: 16),
                  _buildTextField(_confirmPasswordController, 'Confirm Password', obscure: true, fontSize: hintFontSize),
                ],

                // Extended fields when toggled
                if (_showAdditionalFields) ...[
                  _buildTextField(_nameController, 'Username', fontSize: hintFontSize),
                  SizedBox(height: 16),
                  // Adapt layout based on screen size
                  isSmallScreen
                      ? Column(
                    children: [
                      _buildTextField(_firstNameController, 'First Name', fontSize: hintFontSize),
                      SizedBox(height: 16),
                      _buildTextField(_lastNameController, 'Last Name', fontSize: hintFontSize),
                    ],
                  )
                      : Row(
                    children: [
                      Expanded(
                        child: _buildTextField(_firstNameController, 'First Name', fontSize: hintFontSize),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(_lastNameController, 'Last Name', fontSize: hintFontSize),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _buildTextField(_emailController, 'Enter your Email', fontSize: hintFontSize),
                  SizedBox(height: 16),
                  _buildTextField(_passwordController, 'Password', obscure: true, fontSize: hintFontSize),
                  SizedBox(height: 16),
                  _buildTextField(_confirmPasswordController, 'Confirm Password', obscure: true, fontSize: hintFontSize),
                  SizedBox(height: 16),
                  Text(
                    'Optional information',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: labelFontSize,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Adapt layout based on screen size
                  isSmallScreen
                      ? Column(
                    children: [
                      _buildDropdownField('Country', fontSize: hintFontSize),
                      SizedBox(height: 16),
                      _buildDropdownField('City', fontSize: hintFontSize),
                    ],
                  )
                      : Row(
                    children: [
                      Expanded(
                        child: _buildDropdownField('Country', fontSize: hintFontSize),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildDropdownField('City', fontSize: hintFontSize),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Adapt layout based on screen size
                  isSmallScreen
                      ? Column(
                    children: [
                      _buildDropdownField('University', fontSize: hintFontSize),
                      SizedBox(height: 16),
                      _buildDropdownField('College', fontSize: hintFontSize),
                    ],
                  )
                      : Row(
                    children: [
                      Expanded(
                        child: _buildDropdownField('University', fontSize: hintFontSize),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildDropdownField('College', fontSize: hintFontSize),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Adapt layout based on screen size
                  isSmallScreen
                      ? Column(
                    children: [
                      _buildDropdownField('Major', fontSize: hintFontSize),
                      SizedBox(height: 16),
                      _buildTextField(_levelController, 'Level (optional)', fontSize: hintFontSize),
                    ],
                  )
                      : Row(
                    children: [
                      Expanded(
                        child: _buildDropdownField('Major', fontSize: hintFontSize),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: _buildTextField(_levelController, 'Level (optional)', fontSize: hintFontSize),
                      ),
                    ],
                  ),
                ],

                SizedBox(height: 16),

                // Toggle button for additional fields
                if (!_showAdditionalFields) ...[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _showAdditionalFields = true;
                      });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'For better experience',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: labelFontSize,
                          ),
                        ),
                        Icon(Icons.arrow_forward, color: Colors.white, size: isSmallScreen ? 14 : 16),
                      ],
                    ),
                  ),
                ],

                // Login link
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Text(
                        'Do you have an account? ',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: labelFontSize,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: labelFontSize,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Add some bottom padding to ensure content isn't hidden behind the button
                SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 16.0 : 24.0,
            vertical: 16.0
        ),
        child: _isLoading
            ? Center(child: CircularProgressIndicator(color: Colors.white))
            : OutlinedButton(
          onPressed: () async {
            // Validate inputs
            if (_nameController.text.trim().isEmpty ||
                _emailController.text.trim().isEmpty ||
                _passwordController.text.trim().isEmpty ||
                _confirmPasswordController.text.trim().isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please fill all required fields')),
              );
              return;
            }

            if (_passwordController.text != _confirmPasswordController.text) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Passwords do not match')),
              );
              return;
            }

            setState(() {
              _isLoading = true;
            });

            try {
              // Create a map with all the data
              Map<String, dynamic> userData = {
                'email': _emailController.text.trim(),
                'username': _nameController.text.trim(),
                'password': _passwordController.text.trim(),
                'confirmPassword': _confirmPasswordController.text.trim(),
              };

              // Add optional fields if they have values
              if (_showAdditionalFields) {
                if (_firstNameController.text.isNotEmpty) userData['firstName'] = _firstNameController.text.trim();
                if (_lastNameController.text.isNotEmpty) userData['lastName'] = _lastNameController.text.trim();
                if (_countryController.text.isNotEmpty) userData['country'] = _countryController.text.trim();
                if (_cityController.text.isNotEmpty) userData['city'] = _cityController.text.trim();
                if (_universityController.text.isNotEmpty) userData['university'] = _universityController.text.trim();
                if (_collegeController.text.isNotEmpty) userData['college'] = _collegeController.text.trim();
                if (_majorController.text.isNotEmpty) userData['major'] = _majorController.text.trim();
                if (_levelController.text.isNotEmpty) userData['level'] = _levelController.text.trim();
              }

              // Call the API service
              final result = await ApiService.registerUser(
                email: _emailController.text.trim(),
                username: _nameController.text.trim(),
                password: _passwordController.text.trim(),
                confirmPassword: _confirmPasswordController.text.trim(),

              );

              if (result['success']) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Registration successful! Please log in.')),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result['message'] ?? 'Registration failed')),
                );
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('An error occurred. Please try again.')),
              );
            } finally {
              setState(() {
                _isLoading = false;
              });
            }
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontSize: buttonFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.white, width: 2),
            minimumSize: Size(double.infinity, isSmallScreen ? 42 : 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, {bool obscure = false, double fontSize = 14.0}) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Color(0xFF868686), fontSize: fontSize),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      style: TextStyle(color: Color(0xFF868686), fontSize: fontSize),
    );
  }

  Widget _buildDropdownField(String hintText, {double fontSize = 14.0}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            hintText,
            style: TextStyle(color: Color(0xFF868686), fontSize: fontSize),
          ),
          Icon(Icons.arrow_drop_down, color: Color(0xFF868686), size: fontSize + 6),
        ],
      ),
    );
  }
}