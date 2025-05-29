import 'package:flutter/material.dart';
import 'screens/car_list_screen.dart';
import 'themes/app_theme.dart';

void main() {
  runApp(const CarRentalApp());
}

class CarRentalApp extends StatelessWidget {
  const CarRentalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mobil tersedia',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const CarListScreen(),
    );
  }
}
