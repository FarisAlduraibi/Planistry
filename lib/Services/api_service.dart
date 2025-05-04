import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/course.dart';

class ApiService {
  static const String baseUrl = 'https://planistry.onrender.com/api';

  // REGISTER (you already have this)
  static Future<Map<String, dynamic>> registerUser({
    required String email,
    required String username,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse('$baseUrl/users/register/');

    var request = http.MultipartRequest('POST', url)
      ..fields['username'] = username
      ..fields['email'] = email
      ..fields['password'] = password
      ..fields['password2'] = confirmPassword;

    final response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 201) {
      return {'success': true};
    } else {
      return {
        'success': false,
        'message': response.body
      };
    }
  }

  // ✅ LOGIN
  static Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/users/login/');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', data['data']['access']);
      await prefs.setString('refresh_token', data['data']['refresh']);
      await prefs.setString('username', data['data']['user']['username']);
      return {'success': true, 'user': data['data']['user']};
    } else {
      return {
        'success': false,
        'message': jsonDecode(response.body)['message'] ?? 'Login failed'
      };
    }
  }
  static Future<List<Course>> getCourses() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    final response = await http.get(
      Uri.parse('$baseUrl/academic/courses/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> results = jsonData['results'];
      return results.map((json) => Course.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }
}


