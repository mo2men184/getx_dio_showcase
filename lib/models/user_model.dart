class UserModel {
  final int id;
  final String username;
  final String email;
  final String token; // Token received from API after successful authentication

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      token: json['token'],
    );
  }
}
