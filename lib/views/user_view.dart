// lib/views/user_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_dio_showcase/viewmodels/user_viewmodel.dart';
import 'package:get/get.dart';

class UserView extends StatelessWidget {
  final UserViewModel userViewModel = Get.put(UserViewModel());
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication Example'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  userViewModel.login(
                    _usernameController.text.trim(),
                    _passwordController.text.trim(),
                  );
                },
                child: Text('Login'),
              ),
              SizedBox(height: 20),
              Obx(() {
                if (userViewModel.isLoading) {
                  return CircularProgressIndicator();
                } else if (userViewModel.error.isNotEmpty) {
                  return Text(userViewModel.error);
                } else if (userViewModel.user.id != 0) {
                  return Column(
                    children: [
                      Text('Logged in as: ${userViewModel.user.username}'),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          userViewModel.logout();
                        },
                        child: Text('Logout'),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          userViewModel.fetchPosts();
                        },
                        child: Text('Fetch Posts'),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: Obx(
                          () => ListView.builder(
                            itemCount: userViewModel.posts.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(userViewModel.posts[index].title),
                                subtitle: Text(userViewModel.posts[index].body),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return SizedBox.shrink();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
