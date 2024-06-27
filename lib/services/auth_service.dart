import 'package:dio/dio.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:flutter_dio_showcase/models/user_model.dart';

class AuthService {
  final Dio _dio = Dio();

  Future<UserModel> login(String username, String password) async {
    try {
      // Simulate password encryption (replace with your actual encryption method)
      final encryptedPassword = _encryptPassword(password);

      // Example API endpoint for authentication
      final response = await _dio.post(
        'https://your-api-url.com/auth/login',
        data: {
          'username': username,
          'password': encryptedPassword,
        },
      );

      return UserModel.fromJson(response.data);
    } catch (e) {
      print('Error logging in: $e');
      rethrow;
    }
  }

  String _encryptPassword(String password) {
    // Replace with your actual encryption algorithm (e.g., AES encryption)
    final key = utf8.encode('your_secret_key');
    final bytes = utf8.encode(password);
    final hmacSha256 = Hmac(sha256, key); // HMAC-SHA256
    final digest = hmacSha256.convert(bytes);
    return digest.toString();
  }
}
