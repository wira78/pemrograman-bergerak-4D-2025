// lib/models/mahasiswa.dart
class Mahasiswa {
  final String idmhs;
  final String nama;
  final String nim;
  final String alamat;

  Mahasiswa({
    required this.idmhs,
    required this.nama,
    required this.nim,
    required this.alamat,
  });

  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return Mahasiswa(
      idmhs: json['idmhs'] ?? '',
      nama: json['nama'] ?? '',
      nim: json['nim'] ?? '',
      alamat: json['alamat'] ?? '',
    );
  }
}
