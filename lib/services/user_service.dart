import 'package:dio/dio.dart';
import 'package:flutter_dio_showcase/models/user_model.dart';

class UserService {
  final Dio _dio = Dio();

  Future<UserModel> fetchUser(int userId) async {
    try {
      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/users/$userId');
      return UserModel.fromJson(response.data);
    } catch (e) {
      print('Error fetching user: $e');
      rethrow;
    }
  }
}
