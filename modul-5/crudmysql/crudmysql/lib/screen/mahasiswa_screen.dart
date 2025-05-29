import 'package:flutter/material.dart';
import '../models/mahasiswa.dart';
import '../services/mahasiswa_service.dart';
import 'form_mahasiswa.dart';

class MahasiswaScreen extends StatefulWidget {
  const MahasiswaScreen({super.key});

  @override
  State<MahasiswaScreen> createState() => _MahasiswaScreenState();
}

class _MahasiswaScreenState extends State<MahasiswaScreen> {
  List<Mahasiswa> data = [];
  bool isLoading = true;

  void fetchData() async {
    setState(() => isLoading = true);
    final service = MahasiswaService();
    final result = await service.getMahasiswa();
    setState(() {
      data = result.cast<Mahasiswa>();
      isLoading = false;
    });
  }

  void deleteData(String id) async {
    final service = MahasiswaService();
    final success = await service.deleteMahasiswa(id);
    if (success) {
      fetchData();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil dihapus')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Mahasiswa')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final mhs = data[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(mhs.nama),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('NIM: ${mhs.nim}'),
                        Text('Alamat: ${mhs.alamat}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FormMahasiswaScreen(
                                  mahasiswa: mhs,
                                ),
                              ),
                            );
                            if (result == true) fetchData();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => deleteData(mhs.idmhs),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FormMahasiswaScreen(),
            ),
          );
          if (result == true) fetchData();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
