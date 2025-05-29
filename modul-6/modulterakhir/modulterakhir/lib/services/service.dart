import 'dart:convert';
import 'package:http/http.dart' as http;
import '/model/produk.dart';

class ProdukService {
  final String baseUrl = 'https://firestore.googleapis.com/v1/projects/produk-278c9/databases/(default)/documents/produk';

  // Mengambil semua produk
  Future<List<produk>> getAll() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<produk> productList = [];
        for (var doc in data['documents']) {
          final fields = doc['fields'];
          productList.add(produk.fromJson({
            'idproduk': doc['name'],
            'nama': fields['nama']['stringValue'],
            'tipe': fields['tipe']['stringValue'],
            'harga': fields['harga']['integerValue'],
            'image': '',  // Jika Anda menggunakan gambar, sesuaikan
            'location': '', // Jika menggunakan lokasi, sesuaikan
          }));
        }
        return productList;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error in getAll: $e');
      throw Exception('Failed to load products: $e');
    }
  }

  // Membuat produk baru
  Future<void> create(produk product) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to create product: ${response.statusCode}');
      }
    } catch (e) {
      print('Error creating product: $e');
    }
  }

  // Memperbarui produk
  Future<void> update(produk product) async {
    final url = '$baseUrl/${product.idproduk}';
    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(product.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update product: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating product: $e');
    }
  }

  // Menghapus produk
  Future<void> delete(String id) async {
    final url = '$baseUrl/$id';
    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to delete product: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting product: $e');
    }
  }
}
