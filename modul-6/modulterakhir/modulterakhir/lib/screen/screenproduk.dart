import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/model/produk.dart';
import '/screen/fromproduk.dart'; // Pastikan nama file sesuai

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<produk> _productList = []; // Menyimpan list produk
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProductsFromSharedPreferences(); // Memuat produk dari SharedPreferences saat halaman dimulai
  }

  // Fungsi untuk memuat produk dari SharedPreferences
  Future<void> _loadProductsFromSharedPreferences() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      List<produk> products = [];

      // Ambil semua keys dari SharedPreferences
      final keys = prefs.getKeys();

      // Iterasi setiap key dan ambil produk berdasarkan ID
      for (var key in keys) {
        if (key.startsWith('product_')) {
          String? productJson = prefs.getString(key);
          if (productJson != null) {
            Map<String, dynamic> productMap = jsonDecode(productJson);
            products.add(
              produk.fromJson({
                'idproduk': productMap['idproduk'],
                'nama': productMap['nama'],
                'tipe': productMap['tipe'],
                'harga': productMap['harga'],
                'image': productMap['image'],
                'location': productMap['location'],
              }),
            );
          }
        }
      }

      setState(() {
        _productList = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
      print("Error loading products: $e");
    }
  }

  // Navigasi ke halaman untuk menambah atau mengedit produk
  void _navigateToForm([produk? product]) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductUploadPage(product: product),
      ),
    );

    if (result == true) {
      _loadProductsFromSharedPreferences(); // Memuat ulang produk jika ada perubahan
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed:
                _loadProductsFromSharedPreferences, // Memuat ulang daftar produk
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(), // Tombol untuk menambah produk baru
        child: const Icon(Icons.add),
      ),
    );
  }

  // Membuat body untuk menampilkan produk
  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      ); // Menampilkan loading indicator
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error occurred:', style: TextStyle(color: Colors.red)),
            Text(_error!, style: TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed:
                  _loadProductsFromSharedPreferences, // Coba lagi untuk memuat produk
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (_productList.isEmpty) {
      return const Center(
        child: Text('No products available'),
      ); // Menampilkan pesan jika tidak ada produk
    }

    return RefreshIndicator(
      onRefresh:
          _loadProductsFromSharedPreferences, // Memuat ulang produk saat di-refresh
      child: ListView.builder(
        itemCount: _productList.length,
        itemBuilder: (context, index) {
          final product =
              _productList[index]; // Mengambil produk berdasarkan indeks
          return Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading:
                  product.image.isNotEmpty
                      ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          product.image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  const Icon(Icons.image_not_supported),
                        ),
                      )
                      : const Icon(Icons.image),
              title: Text(
                product.nama,
                style: TextStyle(fontWeight: FontWeight.bold),
              ), // Nama produk
              subtitle: Text(
                '${product.tipe} - Rp ${product.harga}',
                style: TextStyle(color: Colors.grey[600]),
              ), // Tipe dan harga produk
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _navigateToForm(product), // Edit produk
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed:
                        () => _deleteProduct(product.idproduk), // Hapus produk
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Fungsi untuk menghapus produk
  Future<void> _deleteProduct(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Hapus produk berdasarkan ID dari SharedPreferences
      await prefs.remove('product_$id');
      _loadProductsFromSharedPreferences(); // Memuat ulang produk setelah penghapusan
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to delete product: $e')));
    }
  }
}
