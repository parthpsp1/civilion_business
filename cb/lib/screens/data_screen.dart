import 'package:cb/helpers/helper.dart';
import 'package:cb/model/vendor_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataScreen extends StatelessWidget {
  const DataScreen({super.key, required this.vendorSpeciality});

  final String vendorSpeciality;

  Stream<List<Vendor>> readData() => FirebaseFirestore.instance
      .collection('vendor')
      .snapshots()
      .map((event) => event.docs
          .map((doc) => Vendor.fromJson(doc.id, doc.data()))
          .where((vendor) => vendor.speciality == vendorSpeciality)
          .toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All $vendorSpeciality data',
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        titleSpacing: 0,
      ),
      body: StreamBuilder<List<Vendor>>(
        stream: readData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            final resultData = snapshot.data!;
            return resultData.isEmpty
                ? const Center(
                    child: Text('No Data Found'),
                  )
                : ListView.builder(
                    itemCount: resultData.length,
                    itemBuilder: (context, index) {
                      final vendor = resultData[index];
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
                                    onPressed: () {
                                      launchCustomUrl(vendor.mobile);
                                    },
                                    icon: const Icon(Icons.phone_outlined),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
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
