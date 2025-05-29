import 'package:flutter/material.dart';
import 'screen/screenproduk.dart';  // Pastikan bahwa file screen.dart ada dan HomeScreen didefinisikan di dalamnya

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TOko Online',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),  
    );
  }
}
