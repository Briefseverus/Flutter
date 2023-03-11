import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'CRUD LopHoc',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text fields' controllers
  final TextEditingController _tenLopController = TextEditingController();
  final TextEditingController _maLopController = TextEditingController();
  final TextEditingController _maGianVienController = TextEditingController();
  final TextEditingController _soLuongSinhVienController = TextEditingController();

  final CollectionReference _lopHoc =
  FirebaseFirestore.instance.collection('LopHoc');

  // This function is triggered when the floatting button or one of the edit buttons is pressed
  // Adding a product if no documentSnapshot is passed
  // If documentSnapshot != null then update an existing product
  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _tenLopController.text = documentSnapshot['TenLop'];
      _maLopController.text = documentSnapshot['MaLop'];
      _maGianVienController.text = documentSnapshot['MaGianVien'];
      _soLuongSinhVienController.text = documentSnapshot['SoLuong'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _maLopController,
                  decoration: const InputDecoration(labelText: 'Ma Lop Hoc:'),
                ),
                TextField(
                  controller: _tenLopController,
                  decoration: const InputDecoration(labelText: 'Ten Lop Hoc:'),
                ),
                TextField(
                  controller: _maGianVienController,
                  decoration: const InputDecoration(labelText: 'Ma Gian Vien:'),
                ),
                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _soLuongSinhVienController,
                  decoration: const InputDecoration(
                    labelText: 'So Luong Sinh Vien',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? MaLopHoc = _maLopController.text;
                    final String? MaGianVien = _maGianVienController.text;
                    final String? TenLop = _tenLopController.text;
                    final double? SoLuong =
                    double.tryParse(_soLuongSinhVienController.text);
                    if (MaLopHoc != null && MaGianVien != null && TenLop != null && SoLuong != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await _lopHoc.add({"MaLop": MaLopHoc, "TenLop": TenLop,"MaGianVien":MaGianVien, "SoLuong":SoLuong});
                      }
                      if (action == 'update') {
                        await _lopHoc
                            .doc(documentSnapshot!.id)
                            .update({"MaLop": MaLopHoc, "TenLop": TenLop,"MaGianVien":MaGianVien, "SoLuong":SoLuong});
                      }

                      _maLopController.text ='';
                      _maGianVienController.text = '';
                      _tenLopController.text = '';
                      _soLuongSinhVienController.text = '';

                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  // Deleteing a product by id
  Future<void> _deleteProduct(String lopHocId) async {
    await _lopHoc.doc(lopHocId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('crud.com'),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: _lopHoc.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['TenLop']),
                    subtitle: Text(documentSnapshot['SoLuong'].toString()),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          // Press this button to edit a single product
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _createOrUpdate(documentSnapshot)),
                          // This icon button is used to delete a single product
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  _deleteProduct(documentSnapshot.id)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: const Icon(Icons.add),
      ),
    );
  }
}