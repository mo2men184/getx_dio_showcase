import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'views/user_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dio and GetX Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dio and GetX Showcase'),
        ),
        body: Center(
          child: UserView(),
        ),
      ),
    );
  }
}
