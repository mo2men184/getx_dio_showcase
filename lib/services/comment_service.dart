import 'package:dio/dio.dart';
import 'package:flutter_dio_showcase/models/comment_model.dart';

class CommentService {
  final Dio _dio = Dio();

  Future<List<CommentModel>> fetchComments(int postId) async {
    try {
      final response = await _dio
          .get('https://jsonplaceholder.typicode.com/comments?postId=$postId');
      return List<CommentModel>.from(
          response.data.map((comment) => CommentModel.fromJson(comment)));
    } catch (e) {
      print('Error fetching comments: $e');
      rethrow;
    }
  }
}
