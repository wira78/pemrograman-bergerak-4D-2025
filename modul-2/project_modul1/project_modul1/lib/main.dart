import 'package:flutter/material.dart';
import 'home_page.dart';
import 'detail_page.dart';
import 'form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/form': (context) => Crudpage(),
        '/detail': (context) => DetailPage(),
      },
    );
  }
}
