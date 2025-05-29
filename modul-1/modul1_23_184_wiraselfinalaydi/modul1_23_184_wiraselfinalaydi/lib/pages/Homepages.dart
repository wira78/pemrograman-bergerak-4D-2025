import 'package:flutter/material.dart';
import 'package:modul1_23_184_wiraselfinalaydi/widgets/list_horizontal.dart';
import 'package:modul1_23_184_wiraselfinalaydi/widgets/list_vertikal.dart';

class HomePages extends StatelessWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 255, 184, 184),
        title: const Text(
          'Hi, Wirasel',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(
                'https://images.pexels.com/photos/45201/kitty-catkitten-pet-45201.jpeg',
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hot Places Section
              _sectionHeader(title: 'Hot Places', onSeeAll: () {}),
              const SizedBox(height: 12),
              const ListHorizontal(),
              const SizedBox(height: 28),

              // Best Hotels Section
              _sectionHeader(title: 'Best Hotels', onSeeAll: () {}),
              const SizedBox(height: 12),
              const ListVertical(),
            ],
          ),
        ),
      ),
    );
  }

  // Section header widget
  Widget _sectionHeader({required String title, required VoidCallback onSeeAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onSeeAll,
          child: const Text(
            'See All',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.blueAccent,
            ),
          ),
        ),
      ],
    );
  }
}
