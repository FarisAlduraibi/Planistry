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

    @override
    void dispose() {
      _nameController.dispose();
      _emailController.dispose();
      _passwordController.dispose();
      _confirmPasswordController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title below the back button
              Text(
                'Register',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Create an account',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 30),
              _buildTextField(_nameController, 'What shall we call you?'),
              SizedBox(height: 16),
              _buildTextField(_emailController, 'Enter your Email'),
              SizedBox(height: 16),
              _buildTextField(_passwordController, 'Password', obscure: true),
              SizedBox(height: 16),
              _buildTextField(_confirmPasswordController, 'Confirm Password', obscure: true),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Do you have an account? ',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
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
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Image aligned to right edge of the screen
              Container(
                width: double.infinity,
                alignment: Alignment.centerRight,
                child: Image.asset(
                  'assets/images/login.png',
                  width: 180,
                  height: 180,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(24.0),
          child: OutlinedButton(
            onPressed: () async {
              final name = _nameController.text.trim();
              final email = _emailController.text.trim();
              final password = _passwordController.text;
              final confirmPassword = _confirmPasswordController.text;

              if (password != confirmPassword) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Passwords do not match")),
                );
                return;
              }

              final response = await ApiService.registerUser(
                email: email,
                username: name, // We're using the name as the username
                password: password,
                confirmPassword: confirmPassword,
              );

              if (response['success']) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => NavigationHandler()),
                      (route) => false,
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error: ${response['message']}")),
                );
              }
            },

            child: Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.white, width: 2),
              minimumSize: Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      );
    }

    Widget _buildTextField(TextEditingController controller, String hintText, {bool obscure = false}) {
      return TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xFF868686)),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        style: TextStyle(color: Color(0xFF868686)),
      );
    }
  }