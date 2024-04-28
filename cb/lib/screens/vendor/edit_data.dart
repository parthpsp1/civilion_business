import 'package:cb/database/firebase_query_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.documentId});

  final String documentId;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

Map dataToEdit = {};

class _EditScreenState extends State<EditScreen> {
  void parseDatViaFirebase() async {
    DocumentSnapshot? documentSnapshot =
        await CustomFirebaseQueryHandle.fetchData(widget.documentId);
    if (documentSnapshot != null && documentSnapshot.exists) {
      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        setState(() {
          dataToEdit = data;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    parseDatViaFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
      ),
      body: dataToEdit.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Center(
                  child: Text(dataToEdit['profession']),
                )
              ],
            ),
    );
  }
}
