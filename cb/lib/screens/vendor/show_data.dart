import 'package:cb/auth/custom_firebase_auth.dart';
import 'package:cb/model/vendor_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowData extends StatelessWidget {
  const ShowData({super.key});

  Stream<List<Vendor>> readData() => FirebaseFirestore.instance
      .collection('vendor')
      .snapshots()
      .map((event) => event.docs
          .map((doc) => Vendor.fromJson(doc.data()))
          .where((vendor) =>
              vendor.email == CustomFireBaseAuth().currentUser?.email)
          .toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Vendor>>(
        stream: readData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: CircularProgressIndicator()),
              ],
            );
          }
          if (snapshot.hasData) {
            final vendorData = snapshot.data!.reversed.toList();
            return vendorData.isEmpty
                ? const Center(
                    child: Text('No Data Found'),
                  )
                : ListView.builder(
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    vendor.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      bool confirmed = await showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Confirm Delete'),
                                          content: Text(
                                              'Are you sure you want to delete ${vendor.name}?'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: const Text('Delete'),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (confirmed ?? false) {
                                        try {
                                          QuerySnapshot querySnapshot =
                                              await FirebaseFirestore.instance
                                                  .collection('vendor')
                                                  .where('name',
                                                      isEqualTo: vendor.name)
                                                  .get();

                                          if (querySnapshot.docs.isNotEmpty) {
                                            String docId =
                                                querySnapshot.docs.first.id;
                                            await FirebaseFirestore.instance
                                                .collection('vendor')
                                                .doc(docId)
                                                .delete();

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    '${vendor.name} deleted'),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    '${vendor.name} not found'),
                                              ),
                                            );
                                          }
                                        } catch (error) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Failed to delete ${vendor.name}'),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
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
