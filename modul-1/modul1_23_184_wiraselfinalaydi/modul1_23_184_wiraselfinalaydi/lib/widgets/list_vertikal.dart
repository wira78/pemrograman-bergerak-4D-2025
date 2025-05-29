import 'package:flutter/material.dart';
import 'package:modul1_23_184_wiraselfinalaydi/pages/secondPages.dart';

class ListVertical extends StatelessWidget {
  const ListVertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> parkData = [
      {
        'title': 'Hotel Elegan di Jakarta',
        'description': 'Suasana mewah dan nyaman di area buffet hotel bintang lima di Jakarta. Dengan desain interior modern dan pencahayaan hangat, tempat ini menawarkan pengalaman bersantap yang eksklusif dan memanjakan lidah.',
        'imageUrl': 'https://images.pexels.com/photos/31592162/pexels-photo-31592162/free-photo-of-elegant-hotel-buffet-in-jakarta-dining-area.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      },
      {
        'title': 'Pyramid Hotel',
        'description': 'Menikmati suasana senja di rooftop cafe dengan pemandangan kota yang menawan. Tempat ideal untuk bersantai sambil menyeruput kopi dan menikmati suasana urban yang tenang dan stylish.',
        'imageUrl': 'https://images.pexels.com/photos/2259226/pexels-photo-2259226.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      },
      {
        'title': 'Hotel Paradise',
        'description': 'Hotel mewah dengan pemandangan laut yang menakjubkan. Nikmati suasana santai di tepi kolam renang sambil menikmati minuman segar dan menikmati keindahan alam sekitar.',
        'imageUrl': 'https://images.pexels.com/photos/8414417/pexels-photo-8414417.jpeg',
      },
      {
        'title': 'Hotel Mewah di Bali',
        'description': 'Nikmati pengalaman menginap yang tak terlupakan di hotel mewah di Bali. Dengan desain arsitektur yang menawan dan layanan bintang lima, tempat ini adalah surga bagi para pelancong yang mencari kenyamanan dan kemewahan.',
        'imageUrl': 'https://images.pexels.com/photos/3285715/pexels-photo-3285715.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      },
      {
        'title': 'Villa Mewah di Bali',
        'description': 'Villa mewah dengan pemandangan laut yang menakjubkan. Nikmati suasana santai di tepi kolam renang sambil menikmati minuman segar dan menikmati keindahan alam sekitar.',
        'imageUrl': 'https://images.pexels.com/photos/10280850/pexels-photo-10280850.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      },
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      itemCount: parkData.length,
      itemBuilder: (context, index) {
        final park = parkData[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          child: ParkInfoCard(
            title: park['title']!,
            description: park['description']!,
            imageUrl: park['imageUrl']!,
          ),
        );
      },
    );
  }
}

class ParkInfoCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const ParkInfoCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SecondPage(
              title: title,
              description: description,
              imagePath: imageUrl,
              location: 'Default Location',
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
