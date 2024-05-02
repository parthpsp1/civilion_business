import 'dart:convert';
import 'dart:typed_data';
import 'package:cb/database/firebase_query_handler.dart';
import 'package:cb/model/vendor_data_model.dart';
import 'package:cb/screens/vendor/edit_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowData extends StatelessWidget {
  const ShowData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Vendor>>(
        stream: CustomFirebaseQueryHandle.readData(),
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
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => EditScreen(
                                                documentId: vendor.documentId,
                                              ),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                            Icons.edit_note_outlined),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          bool confirmed = await showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title:
                                                  const Text('Confirm Delete'),
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

                                          if (confirmed) {
                                            try {
                                              QuerySnapshot querySnapshot =
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('vendor')
                                                      .where('name',
                                                          isEqualTo:
                                                              vendor.name)
                                                      .get();

                                              if (querySnapshot
                                                  .docs.isNotEmpty) {
                                                String docId =
                                                    querySnapshot.docs.first.id;
                                                await FirebaseFirestore.instance
                                                    .collection('vendor')
                                                    .doc(docId)
                                                    .delete();

                                                if (context.mounted) {
                                                  ScaffoldMessenger.of(context)
                                                      .clearSnackBars();
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          '${vendor.name} deleted'),
                                                    ),
                                                  );
                                                }
                                              } else {
                                                if (context.mounted) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          '${vendor.name} not found'),
                                                    ),
                                                  );
                                                }
                                              }
                                            } catch (error) {
                                              if (context.mounted) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        'Failed to delete ${vendor.name}'),
                                                  ),
                                                );
                                              }
                                            }
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
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
                                "Speciality: ${vendor.speciality}",
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
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  vendor.photoId == ''
                                      ? Container()
                                      : TextButton.icon(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                Uint8List decodedPhotoIdString =
                                                    base64Decode(
                                                        vendor.photoId);
                                                return Dialog.fullscreen(
                                                  child: Stack(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              top: 20,
                                                              right: 20,
                                                            ),
                                                            child:
                                                                TextButton.icon(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              icon: const Icon(
                                                                Icons
                                                                    .close_outlined,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              label: const Text(
                                                                'Close',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              style:
                                                                  const ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStatePropertyAll(
                                                                  Colors.red,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image.memory(
                                                            decodedPhotoIdString,
                                                            fit: BoxFit
                                                                .scaleDown,
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          label: const Text('Photo ID'),
                                          icon: const Icon(Icons
                                              .photo_camera_front_outlined),
                                        ),
                                  vendor.signatureImage == ''
                                      ? Container()
                                      : TextButton.icon(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                Uint8List
                                                    decodedSignatureImageString =
                                                    base64Decode(
                                                        vendor.signatureImage);
                                                return Dialog.fullscreen(
                                                  child: Stack(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              top: 20,
                                                              right: 20,
                                                            ),
                                                            child:
                                                                TextButton.icon(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              icon: const Icon(
                                                                Icons
                                                                    .close_outlined,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              label: const Text(
                                                                'Close',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              style:
                                                                  const ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStatePropertyAll(
                                                                  Colors.red,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image.memory(
                                                            decodedSignatureImageString,
                                                            fit: BoxFit
                                                                .scaleDown,
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          label: const Text('Signatue'),
                                          icon: const Icon(Icons.edit_outlined),
                                        ),
                                  vendor.educationalDocument == ''
                                      ? Container()
                                      : TextButton.icon(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                Uint8List
                                                    decodedEducationalDocument =
                                                    base64Decode(vendor
                                                        .educationalDocument);
                                                return Dialog.fullscreen(
                                                  child: Stack(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              top: 20,
                                                              right: 20,
                                                            ),
                                                            child:
                                                                TextButton.icon(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              icon: const Icon(
                                                                Icons
                                                                    .close_outlined,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              label: const Text(
                                                                'Close',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              style:
                                                                  const ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStatePropertyAll(
                                                                  Colors.red,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image.memory(
                                                            decodedEducationalDocument,
                                                            fit: BoxFit
                                                                .scaleDown,
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          label: const Text('Edu. Doc'),
                                          icon: const Icon(
                                              Icons.folder_open_outlined),
                                        )
                                ],
                              )
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
