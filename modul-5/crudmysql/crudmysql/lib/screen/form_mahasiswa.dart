import 'package:flutter/material.dart';
import '../models/mahasiswa.dart';
import '../services/mahasiswa_service.dart';

class FormMahasiswaScreen extends StatefulWidget {
  final Mahasiswa? mahasiswa;

  const FormMahasiswaScreen({Key? key, this.mahasiswa}) : super(key: key);

  @override
  State<FormMahasiswaScreen> createState() => _FormMahasiswaScreenState();
}

class _FormMahasiswaScreenState extends State<FormMahasiswaScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController namaController;
  late TextEditingController nimController;
  late TextEditingController alamatController;

  final MahasiswaService _service = MahasiswaService();

  bool get isEdit => widget.mahasiswa != null;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.mahasiswa?.nama ?? '');
    nimController = TextEditingController(text: widget.mahasiswa?.nim ?? '');
    alamatController = TextEditingController(text: widget.mahasiswa?.alamat ?? '');
  }

  @override
  void dispose() {
    namaController.dispose();
    nimController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  Future<void> simpanData() async {
    final data = {
      if (isEdit) 'idmhs': widget.mahasiswa!.idmhs,
      'nama': namaController.text,
      'nim': nimController.text,
      'alamat': alamatController.text,
    };

    bool success = isEdit
        ? await _service.updateMahasiswa(data)
        : await _service.tambahMahasiswa(data);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data berhasil ${isEdit ? "diupdate" : "ditambahkan"}')),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Mahasiswa' : 'Tambah Mahasiswa')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) => value == null || value.isEmpty ? 'Nama wajib diisi' : null,
              ),
              TextFormField(
                controller: nimController,
                decoration: InputDecoration(labelText: 'NIM'),
                validator: (value) => value == null || value.isEmpty ? 'NIM wajib diisi' : null,
              ),
              TextFormField(
                controller: alamatController,
                decoration: InputDecoration(labelText: 'Alamat'),
                validator: (value) => value == null || value.isEmpty ? 'Alamat wajib diisi' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    simpanData();
                  }
                },
                child: Text(isEdit ? 'Update' : 'Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
