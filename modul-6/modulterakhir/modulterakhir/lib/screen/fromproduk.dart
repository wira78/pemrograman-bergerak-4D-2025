import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/model/produk.dart';
import '/services/service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class ProductUploadPage extends StatefulWidget {
  final produk? product;

  const ProductUploadPage({Key? key, this.product}) : super(key: key);

  @override
  _ProductUploadPageState createState() => _ProductUploadPageState();
}

class _ProductUploadPageState extends State<ProductUploadPage> {
  final _formKey = GlobalKey<FormState>();
  final ProdukService _productService = ProdukService();

  String _productName = '';
  String _productType = '';
  int _productPrice = 0;
  String _productDescription = '';
  String _productImage = '';
  String _currentLocation = '';
  File? _imageFile;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    if (widget.product != null) {
      _productName = widget.product!.nama;
      _productType = widget.product!.tipe;
      _productPrice = widget.product!.harga;
      _productImage = widget.product!.image;
      _currentLocation = widget.product!.location;
    }
  }

  // Fungsi untuk mendapatkan lokasi saat ini
  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Location services are disabled.')),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Location permission denied.')),
          );
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);
      Placemark place = placemarks.first;

      setState(() {
        _currentLocation = '${place.name}, ${place.locality}, ${place.country}';
      });
    } catch (e) {
      print('Error getting location: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get location: $e')),
      );
    }
  }

  // Fungsi untuk memilih gambar dari kamera
  Future<void> _pickImageFromCamera() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to take picture: $e')),
      );
    }
  }

  // Fungsi untuk memilih gambar dari galeri
  Future<void> _pickImageFromGallery() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  // Fungsi untuk menyimpan produk ke SharedPreferences
  Future<void> _saveProductToSharedPreferences(produk product) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Simpan produk sebagai JSON string
      String productJson = jsonEncode({
        'idproduk': product.idproduk,
        'nama': product.nama,
        'tipe': product.tipe,
        'harga': product.harga,
        'image': product.image,
        'location': product.location,
      });

      // Simpan string JSON di SharedPreferences
      await prefs.setString('product_${product.idproduk}', productJson);
    } catch (e) {
      print('Failed to save product to SharedPreferences: $e');
    }
  }

  // Fungsi untuk submit form dan menyimpan data produk
  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() => _isLoading = true);

        // Siapkan data produk
        final product = produk(
          idproduk: widget.product?.idproduk ?? DateTime.now().millisecondsSinceEpoch.toString(),
          nama: _productName,
          tipe: _productType,
          harga: _productPrice,
          image: _productImage,
          location: _currentLocation,
        );

        // Simpan produk ke SharedPreferences
        await _saveProductToSharedPreferences(product);

        // Create or update product in the service
        if (widget.product == null) {
          await _productService.create(product);
        } else {
          await _productService.update(product);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product saved successfully')),
        );
        Navigator.pop(context, true); // Go back after saving
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save product: $e')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product == null ? 'Upload Product' : 'Edit Product'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImageFromCamera,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _imageFile != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                _imageFile!,
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(
                              Icons.camera_alt,
                              size: 50,
                              color: Colors.white,
                            ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _currentLocation.isEmpty
                        ? 'Location not available'
                        : _currentLocation,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _pickImageFromGallery,
                    child: const Text('Pick Image from Gallery'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    initialValue: _productName,
                    decoration: const InputDecoration(
                      labelText: 'Product Name',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => setState(() => _productName = value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Product name cannot be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: _productType,
                    decoration: const InputDecoration(
                      labelText: 'Product Type',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => setState(() => _productType = value),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Product type cannot be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: _productPrice.toString(),
                    decoration: const InputDecoration(
                      labelText: 'Product Price',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) =>
                        setState(() => _productPrice = int.tryParse(value) ?? 0),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Product price cannot be empty';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Price must be a number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: _productDescription,
                    decoration: const InputDecoration(
                      labelText: 'Product Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    onChanged: (value) =>
                        setState(() => _productDescription = value),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _submitForm,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: Text(
                      widget.product == null ? 'Upload Product' : 'Update Product',
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
