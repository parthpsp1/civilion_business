import 'package:cb/data/label.dart';
import 'package:cb/model/vendor_data_model.dart';
import 'package:cb/screens/data_screen.dart';
import 'package:cb/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream<List<Vendor>> readData() =>
      FirebaseFirestore.instance.collection('vendor').snapshots().map((event) =>
          event.docs.map((doc) => Vendor.fromJson(doc.data())).toList());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Civilion Business'),
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const VendorLoginScreen(),
                ),
              );
            },
            icon: const Icon(Icons.login),
            label: const Text('Vendor Login'),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: labels.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 20,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DataScreen(
                            vendorProfession: labels[index],
                          ),
                        ),
                      );
                    },
                    child: Text(
                      labels[index],
                      style: const TextStyle(
                        fontSize: 21,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
