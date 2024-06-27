import 'package:dio/dio.dart';
import 'package:flutter_dio_showcase/models/post_model.dart';

class PostService {
  final Dio _dio = Dio();

  Future<List<PostModel>> fetchPosts() async {
    try {
      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/posts');
      return List<PostModel>.from(
          response.data.map((post) => PostModel.fromJson(post)));
    } catch (e) {
      print('Error fetching posts: $e');
      rethrow;
    }
  }
}
