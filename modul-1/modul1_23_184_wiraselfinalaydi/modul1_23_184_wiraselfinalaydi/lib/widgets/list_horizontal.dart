import 'package:flutter/material.dart';

class ListHorizontal extends StatelessWidget {
  const ListHorizontal({Key? key}) : super(key: key);

  final List<Map<String, String>> parkData = const [
    {
      'title': 'Air terjun Tumpak Sewa',
      'location': 'Malang, Indonesia',
      'imageUrl': 'https://images.pexels.com/photos/931007/pexels-photo-931007.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    },
    {
      'title': 'Pasar Terapung',
      'location': 'Banjarmasin, Indonesia',
      'imageUrl': 'https://images.pexels.com/photos/1877078/pexels-photo-1877078.jpeg',
    },
    {
      'title': 'ubud',
      'location': 'Bali, Indonesia',
      'imageUrl': 'https://images.pexels.com/photos/1643130/pexels-photo-1643130.jpeg',
    },
    {
      'title': 'Prambanan Temple',
      'location': 'Indonesia',
      'imageUrl': 'https://images.pexels.com/photos/161293/prambanan-temple-java-hinduism-161293.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    },
    {
      'title': 'Tebing Beach',
      'location': 'Bali, Indonesia',
      'imageUrl': 'https://images.pexels.com/photos/2474689/pexels-photo-2474689.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double cardHeight = 100;
    final double cardWidth = 250;
    return SizedBox(
      height: cardHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: parkData.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final park = parkData[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ParkCard(
              title: park['title']!,
              location: park['location']!,
              imageUrl: park['imageUrl']!,
              width: cardWidth,
              height: cardHeight,
            ),
          );
        },
      ),
    );
  }
}

class ParkCard extends StatelessWidget {
  final String title;
  final String location;
  final String imageUrl;
  final double width;
  final double height;

  const ParkCard({
    Key? key,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double imageSize = height * 0.6;
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(246, 243, 215, 215),
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: imageSize,
              height: imageSize,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: imageSize,
                  height: imageSize,
                  color: Colors.grey.shade300,
                  child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: imageSize,
                  height: imageSize,
                  color: Colors.grey,
                  child: const Icon(Icons.broken_image, color: Colors.white),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: Colors.black87,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        location,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
