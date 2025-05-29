import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddMahasiswaScreen extends StatefulWidget {
  final DocumentSnapshot? document;

  const AddMahasiswaScreen({super.key, this.document});

  @override
  State<AddMahasiswaScreen> createState() => _AddMahasiswaScreenState();
}

class _AddMahasiswaScreenState extends State<AddMahasiswaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _nimController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.document != null) {
      _namaController.text = widget.document!['nama'];
      _nimController.text = widget.document!['nim'];
      _addressController.text = widget.document!['address'];
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _addressController.dispose();
    super.dispose();
  }
  void _showSuccessPopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 16,
            child: Container(
              padding: const EdgeInsets.all(20),
              width: 200,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle, size: 60, color: Colors.green),
                  const SizedBox(height: 20),
                  const Text(
                    'Data berhasil disimpan!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); 
      Navigator.pop(context, true);
    });
  }

  void _saveMahasiswa() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      final data = {
        'nama': _namaController.text.trim(),
        'nim': _nimController.text.trim(),
        'address': _addressController.text.trim(),
      };

      try {
        if (widget.document == null) {
          await FirebaseFirestore.instance.collection('mahasiswa').add(data);
        } else {
          await FirebaseFirestore.instance
              .collection('mahasiswa')
              .doc(widget.document!.id)
              .update(data);
        }

        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context); 
          _showSuccessPopup(); 
        });
      } catch (e) {
        Navigator.pop(context); 
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal menyimpan data: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.document != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Mahasiswa' : 'Tambah Mahasiswa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
           
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _namaController,
                    decoration: const InputDecoration(labelText: 'Nama'),
                    validator:
                        (value) => value!.isEmpty ? 'Nama wajib diisi' : null,
                  ),
                  TextFormField(
                    controller: _nimController,
                    decoration: const InputDecoration(labelText: 'NIM'),
                    validator:
                        (value) => value!.isEmpty ? 'NIM wajib diisi' : null,
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(labelText: 'Alamat'),
                    validator:
                        (value) =>
                            value!.isEmpty ? 'Alamat wajib diisi' : null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveMahasiswa,
                    child: Text(
                      isEdit ? 'Simpan Perubahan' : 'Tambah Mahasiswa',
                    ),
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
