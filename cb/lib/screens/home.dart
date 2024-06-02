import 'package:blur/blur.dart';
import 'package:cb/data/label.dart';
import 'package:cb/model/vendor_data_model.dart';
import 'package:cb/screens/data_screen.dart';
import 'package:cb/screens/vendor/login_screen.dart';
import 'package:cb/screens/speciality_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream<List<Vendor>> readData() => FirebaseFirestore.instance
      .collection('vendor')
      .snapshots()
      .map((event) => event.docs
          .map((doc) => Vendor.fromJson(doc.id, doc.data()))
          .toList());
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
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 140,
        ),
        itemCount: LocalData.labels.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: GestureDetector(
              onTap: () {
                LocalData.labels[index] == "Project Manager"
                    ? Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DataScreen(),
                      ))
                    : Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SpecialityScreen(
                            vendorProfession: LocalData.labels[index],
                          ),
                        ),
                      );
              },
              child: Stack(
                children: [
                  Blur(
                    blur: 0.4,
                    blurColor: Colors.black,
                    colorOpacity: 0.8,
                    child: Image.asset(
                      LocalData.labelImagePaths[LocalData.labels[index]]!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 6,
                        bottom: 4,
                      ),
                      child: Text(
                        LocalData.labels[index],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
