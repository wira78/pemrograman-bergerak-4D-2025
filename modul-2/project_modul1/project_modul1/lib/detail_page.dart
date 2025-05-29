import 'package:flutter/material.dart';
import 'model_data.dart';

class DetailPage extends StatelessWidget {
  final Wisata? place;
  const DetailPage({Key? key, this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isFormCrud = place != null;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 248, 255),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isFormCrud ? place!.nama : 'National Park Yosemite',
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 248, 248, 255),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar utama
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: isFormCrud
                  ? Image.file(
                      place!.image,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/Rectangle 4.png',
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
            ),

            const SizedBox(height: 14),

            // Icon Keterangan
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Kolom kiri (jenis wisata dan lokasi)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/icon/wisata.png', width: 20),
                        const SizedBox(width: 6),
                        Text(
                          isFormCrud ? place!.jenis : 'Wisata Alam',
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 20),
                        const SizedBox(width: 6),
                        Text(
                          isFormCrud ? place!.lokasi : 'California',
                          style: const TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),

                // Kolom kanan (harga)
                Row(
                  children: [
                    Image.asset('assets/icon/ticket.png', width: 40),
                    const SizedBox(width: 6),
                    Text(
                      isFormCrud ? 'Rp ${place!.harga},00' : '30.000,00',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Deskripsi
            Text(
              isFormCrud
                  ? place!.deskripsi
                  : 'Lorem ipsum est donec non interdum amet phasellus egestas id dignissim in vestibulum augue ut a lectus rhoncus sed ullamcorper at vestibulum sed mus neque amet turpis placerat in luctus at eget egestas praesent congue semper in facilisis purus dis pharetra odio ullamcorper euismod a donec consectetur pellentesque pretium sapien proin tincidunt non augue turpis massa euismod quis lorem et feugiat ornare id cras sed eget adipiscing dolor urna mi sit a a auctor mattis urna fermentum facilisi sed aliquet odio at suspendisse posuere tellus pellentesque id quis libero fames blandit ullamcorper interdum eget placerat tortor cras nulla consectetur et duis viverra mattis libero scelerisque gravida egestas blandit tincidunt ullamcorper auctor aliquam leo urna adipiscing est ut ipsum consectetur id erat semper fames elementum rhoncus quis varius pellentesque quam neque vitae sit velit leo massa habitant tellus velit pellentesque cursus laoreet donec etiam id vulputate nisi integer eget gravida volutpat.',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
