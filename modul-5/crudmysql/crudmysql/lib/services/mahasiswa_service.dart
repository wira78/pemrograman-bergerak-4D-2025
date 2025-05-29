import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/mahasiswa.dart';

class MahasiswaService {
  final String baseUrl = 'http://172.16.13.75/mhs_api';

  // Ambil semua data mahasiswa
  Future<List<Mahasiswa>> getMahasiswa() async {
    final url = Uri.parse('$baseUrl/get.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success'] == true) {
        final List<dynamic> list = data['data'];
        return list.map((json) => Mahasiswa.fromJson(json)).toList();
      } else {
        throw Exception(data['message'] ?? 'Gagal memuat data');
      } 
    } else {
      throw Exception('Gagal menghubungi server API');
    }
  }

  // Tambah data mahasiswa
  Future<bool> tambahMahasiswa(Map<String, String> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/post.php'),
      body: data,
    );

    print('Tambah response status: ${response.statusCode}');
    print('Tambah response body: ${response.body}');

    final json = jsonDecode(response.body);
    return json['success'] == true;
  }

  // Update data mahasiswa
  Future<bool> updateMahasiswa(Map<String, String> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/put.php'),
      body: data,
    );

    print('Update response status: ${response.statusCode}');
    print('Update response body: ${response.body}');

    final json = jsonDecode(response.body);
    return json['success'] == true;
  }

  // Hapus data mahasiswa berdasarkan idmhs
  Future<bool> deleteMahasiswa(String idmhs) async {
    final url = Uri.parse('$baseUrl/delete.php');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'idmhs': idmhs}),
    );

    print('Delete response status: ${response.statusCode}');
    print('Delete response body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['success'] == true;
    } else {
      throw Exception('Gagal menghapus mahasiswa');
    }
  }
}
