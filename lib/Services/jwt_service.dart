// lib/services/jwt_service.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class JwtService {
  // Check if JWT token is expired
  static bool isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        return true; // Invalid token format
      }

      // Decode the payload part (index 1)
      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final Map<String, dynamic> decodedMap = json.decode(decoded);

      // Get expiration time
      final expiry = decodedMap['exp'];
      if (expiry == null) {
        return true; // No expiration claim
      }

      // Convert to DateTime and compare with current time
      final expiryDateTime = DateTime.fromMillisecondsSinceEpoch(expiry * 1000);
      return DateTime.now().isAfter(expiryDateTime);

    } catch (e) {
      print('Error parsing token: $e');
      return true; // Assume expired on error
    }
  }

  // Get token expiration date
  static DateTime? getTokenExpiration(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        return null;
      }

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final Map<String, dynamic> decodedMap = json.decode(decoded);

      final expiry = decodedMap['exp'];
      if (expiry == null) {
        return null;
      }

      return DateTime.fromMillisecondsSinceEpoch(expiry * 1000);
    } catch (e) {
      print('Error parsing token expiration: $e');
      return null;
    }
  }
}