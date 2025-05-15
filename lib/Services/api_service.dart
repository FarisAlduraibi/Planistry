import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/course.dart';
import '../models/semester.dart';

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


// Add this method to your ApiService class

// Token refresh mechanism
  static Future<bool> refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refresh_token');

    if (refreshToken == null || refreshToken.isEmpty) {
      return false;
    }

    try {
      final url = Uri.parse('$baseUrl/users/token/refresh/');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refresh': refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await prefs.setString('access_token', data['access']);
        return true;
      }
    } catch (e) {
      print('Token refresh failed: $e');
    }

    return false;
  }

// Enhanced request method with token refresh
  static Future<http.Response> authenticatedRequest(String method,
      String endpoint, {
        Map<String, dynamic>? body,
      }) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');
    final uri = Uri.parse('$baseUrl/$endpoint');

    // Headers with authentication token
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    // Make the request based on the method
    http.Response response;
    switch (method.toUpperCase()) {
      case 'GET':
        response = await http.get(uri, headers: headers);
        break;
      case 'POST':
        response = await http.post(
          uri,
          headers: headers,
          body: body != null ? jsonEncode(body) : null,
        );
        break;
      case 'PUT':
        response = await http.put(
          uri,
          headers: headers,
          body: body != null ? jsonEncode(body) : null,
        );
        break;
      case 'DELETE':
        response = await http.delete(uri, headers: headers);
        break;
      default:
        throw Exception('Unsupported method: $method');
    }

    // Handle token expiration (usually 401 Unauthorized)
    if (response.statusCode == 401) {
      final refreshSuccess = await refreshToken();
      if (refreshSuccess) {
        // Update token and retry the request
        token = prefs.getString('access_token');
        headers['Authorization'] = 'Bearer $token';

        switch (method.toUpperCase()) {
          case 'GET':
            return await http.get(uri, headers: headers);
          case 'POST':
            return await http.post(
              uri,
              headers: headers,
              body: body != null ? jsonEncode(body) : null,
            );
          case 'PUT':
            return await http.put(
              uri,
              headers: headers,
              body: body != null ? jsonEncode(body) : null,
            );
          case 'DELETE':
            return await http.delete(uri, headers: headers);
          default:
            throw Exception('Unsupported method: $method');
        }
      }
    }

    return response;
  }

  static Future<List<Semester>> getSemesters() async {
    final response = await authenticatedRequest('GET', 'academic/semesters/');

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body)['results'];
      return jsonData.map((json) => Semester.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load semesters: ${response.body}');
    }

  }

  static Future<void> createCourse(Course course) async {
    final response = await authenticatedRequest(
      'POST',
      'academic/courses/',
      body: {
        'name': course.name,
        'code': course.code,
        'credits': course.credits,
        'semester': course.semester,
        'instructor': course.instructor,
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create course: ${response.body}');
    }
  }


  static Future<void> updateCourse(int id, Course course) async {
    final response = await authenticatedRequest(
      'PUT',
      'academic/courses/$id/',
      body: {
        'name': course.name,
        'code': course.code,
        'credits': course.credits,
        'semester': course.semester,
        'instructor': course.instructor,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update course: ${response.body}');
    }
  }

static Future<void> deleteCourse(int id) async {
final response = await authenticatedRequest(
'DELETE',
'academic/courses/$id/',
);

if (response.statusCode != 204) {
throw Exception('Failed to delete course: ${response.body}');
}
}


  static Future<void> createSemester(Semester semester) async {
    final response = await authenticatedRequest(
      'POST',
      'academic/semesters/',
      body: {
        'name': semester.name,
        'start_date': '2025-08-01', // Placeholder
        'end_date': '2025-12-01',   // Placeholder
        'is_active': semester.isActive,
      },
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create semester: ${response.body}');
    }
  }

}
