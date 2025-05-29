import 'package:flutter/material.dart';
import 'package:modul1_23_184_wiraselfinalaydi/pages/HomePages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MY app',
      debugShowCheckedModeBanner: false,
      home: HomePages(),
    );
  }
}
