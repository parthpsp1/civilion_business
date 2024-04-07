import 'package:cb/model/vendor_data_model.dart';
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
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            icon: const Icon(Icons.login),
            label: const Text('Vendor Login'),
          )
        ],
      ),
      body: StreamBuilder<List<Vendor>>(
        stream: readData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            final vendorData = snapshot.data!;
            return ListView.builder(
                itemCount: vendorData.length,
                itemBuilder: (context, index) {
                  final vendor = vendorData[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    margin: const EdgeInsets.all(10),
                    elevation: 2,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            vendor.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            vendor.profession,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Mobile: ${vendor.mobile}",
                          ),
                          const SizedBox(height: 6),
                          Text(
                            vendor.firmName.isEmpty
                                ? ''
                                : "Firm Name: ${vendor.firmName}",
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Charges: ${vendor.charges}",
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Address: ${vendor.address}",
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Email: ${vendor.email}",
                          ),
                        ],
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Text('No Data');
          }
        },
      ),
    );
  }
}
