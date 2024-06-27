import 'package:get/get.dart';
import 'package:flutter_dio_showcase/models/user_model.dart';
import 'package:flutter_dio_showcase/models/post_model.dart';
import 'package:flutter_dio_showcase/models/comment_model.dart';
import 'package:flutter_dio_showcase/services/auth_service.dart';
import 'package:flutter_dio_showcase/services/post_service.dart';
import 'package:flutter_dio_showcase/services/comment_service.dart';

class UserViewModel extends GetxController {
  final AuthService _authService = AuthService();
  final PostService _postService = PostService();
  final CommentService _commentService = CommentService();

  final _user = UserModel(id: 0, username: '', email: '', token: '').obs;
  final _posts = <PostModel>[].obs;
  final _comments = <CommentModel>[].obs;

  final _isLoading = false.obs;
  final _error = RxString('');

  UserModel get user => _user.value;
  List<PostModel> get posts => _posts;
  List<CommentModel> get comments => _comments;
  bool get isLoading => _isLoading.value;
  String get error => _error.value ?? '';

  @override
  void onInit() {
    super.onInit();
    // Initialize any data or fetch initial data on app startup
  }

  Future<void> login(String username, String password) async {
    try {
      _isLoading.value = true;
      final loggedInUser = await _authService.login(username, password);
      _user.value = loggedInUser;
      // Optionally fetch additional data after login
      fetchPosts();
      _isLoading.value = false;
    } catch (e) {
      _isLoading.value = false;
      _error.value = 'Error logging in: $e';
      print('Error logging in: $e');
    }
  }

  void logout() {
    _user.value = UserModel(id: 0, username: '', email: '', token: '');
    // Clear token or session data as needed
  }

  Future<void> fetchPosts() async {
    try {
      _isLoading.value = true;
      final posts = await _postService.fetchPosts();
      _posts.assignAll(posts);
      _isLoading.value = false;
    } catch (e) {
      _isLoading.value = false;
      _error.value = 'Error fetching posts: $e';
      print('Error fetching posts: $e');
    }
  }

  Future<void> fetchComments(int postId) async {
    try {
      _isLoading.value = true;
      final comments = await _commentService.fetchComments(postId);
      _comments.assignAll(comments);
      _isLoading.value = false;
    } catch (e) {
      _isLoading.value = false;
      _error.value = 'Error fetching comments: $e';
      print('Error fetching comments: $e');
    }
  }

  void clearError() {
    _error.value = '';
  }
}
