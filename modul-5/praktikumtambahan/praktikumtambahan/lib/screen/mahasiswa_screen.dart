import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/screen/AddMahasiswaScreen.dart';

class MahasiswaScreen extends StatelessWidget {
  const MahasiswaScreen({super.key});

  void _deleteMahasiswa(BuildContext context, String id) async {
    await FirebaseFirestore.instance.collection('mahasiswa').doc(id).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data berhasil dihapus')),
    );
  }

  void _navigateToAddEdit(BuildContext context, {DocumentSnapshot? doc}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddMahasiswaScreen(document: doc),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Data Mahasiswa")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('mahasiswa').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Tidak ada data mahasiswa"));
          }

          final data = snapshot.data!.docs;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final mhs = data[index];

              return MahasiswaCard(
                mhs: mhs,
                onEdit: () => _navigateToAddEdit(context, doc: mhs),
                onDelete: () => _deleteMahasiswa(context, mhs.id),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddEdit(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Widget Card Mahasiswa dengan desain aesthetic
class MahasiswaCard extends StatefulWidget {
  final DocumentSnapshot mhs;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const MahasiswaCard({
    super.key,
    required this.mhs,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  State<MahasiswaCard> createState() => _MahasiswaCardState();
}

class _MahasiswaCardState extends State<MahasiswaCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final nama = widget.mhs['nama'];
    final nim = widget.mhs['nim'];
    final address = widget.mhs['address'];

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 150),
        scale: _isPressed ? 0.98 : 1.0,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 6,
          shadowColor: Colors.black26,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.blueAccent,
                  child: Icon(Icons.person, color: Colors.white, size: 26),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(nama,
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87)),
                      const SizedBox(height: 4),
                      Text("NIM: $nim",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black54)),
                      Text("Alamat: $address",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black54)),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blueAccent),
                      onPressed: widget.onEdit,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: widget.onDelete,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
