class produk {
  final String idproduk;
  final String nama;
  final String tipe;
  final int harga;
  final String image;
  final String location;

  produk({
    required this.idproduk,
    required this.nama,
    required this.tipe,
    required this.harga,
    required this.image,
    required this.location,
  });

  // Fungsi untuk mengonversi produk menjadi format JSON
  factory produk.fromJson(Map<String, dynamic> json) {
    return produk(
      idproduk: json['idproduk'],
      nama: json['nama'],
      tipe: json['tipe'],
      harga: json['harga'],
      image: json['image'] ?? '',
      location: json['location'] ?? '',
    );
  }

  // Fungsi untuk mengonversi produk menjadi Map untuk disimpan
  Map<String, dynamic> toJson() {
    return {
      'idproduk': idproduk,
      'nama': nama,
      'tipe': tipe,
      'harga': harga,
      'image': image,
      'location': location,
    };
  }
}
