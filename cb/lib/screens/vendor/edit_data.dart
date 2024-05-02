import 'package:cb/auth/custom_firebase_auth.dart';
import 'package:cb/data/label.dart';
import 'package:cb/database/firebase_query_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.documentId});

  final String documentId;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

Map dataToEdit = {};

class _EditScreenState extends State<EditScreen> {
  final GlobalKey<FormState> _editDataFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController firmNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController chargesController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  String selectedLabel = "";
  String specialityLabel = "";
  bool isLoading = false;
  bool isFirstBuild = true;

  Future<void> parseDatViaFirebase() async {
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
    if (isFirstBuild && dataToEdit.isNotEmpty) {
      nameController.text = dataToEdit['name'];
      firmNameController.text = dataToEdit['firm_name'];
      addressController.text = dataToEdit['address'];
      chargesController.text = dataToEdit['charges'];
      mobileController.text = dataToEdit['mobile'];
      selectedLabel = dataToEdit['profession'];
      specialityLabel = dataToEdit['speciality'];
      isFirstBuild = false;
    }
    return PopScope(
      onPopInvoked: (didPop) {
        dataToEdit = {};
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Data'),
        ),
        body: dataToEdit.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: Form(
                        key: _editDataFormKey,
                        child: ListView(
                          children: <Widget>[
                            DropdownButtonFormField<String>(
                              value: dataToEdit['profession'],
                              onChanged: (String? value) {
                                setState(() {
                                  selectedLabel = value!;
                                  specialityLabel = LocalData
                                      .specialityLabels[selectedLabel]!.first;
                                });
                              },
                              items: LocalData.labels.map((String label) {
                                return DropdownMenuItem<String>(
                                  value: label,
                                  child: Text(label),
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                  labelText: 'Select Profession'),
                            ),
                            TextFormField(
                              controller: nameController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z,.\s/\-]'),
                                ),
                              ],
                              decoration:
                                  const InputDecoration(labelText: 'Name'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            DropdownButtonFormField<String>(
                              value: dataToEdit['speciality'],
                              onChanged: (String? value) {
                                setState(() {
                                  specialityLabel = value!;
                                });
                              },
                              items: LocalData
                                  .specialityLabels[dataToEdit['profession']]!
                                  .map((String label) {
                                return DropdownMenuItem<String>(
                                  value: label,
                                  child: Text(label),
                                );
                              }).toList(),
                              decoration: const InputDecoration(
                                labelText: 'Select Speciality',
                              ),
                            ),
                            TextFormField(
                              controller: firmNameController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z0-9,.\s/\-]'),
                                ),
                              ],
                              decoration:
                                  const InputDecoration(labelText: 'Firm Name'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your firm name';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: addressController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z0-9,.\s/\-]'),
                                ),
                              ],
                              decoration:
                                  const InputDecoration(labelText: 'Address'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your address';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: chargesController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z0-9,.\s/\-]'),
                                ),
                              ],
                              decoration:
                                  const InputDecoration(labelText: 'Charges'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter charges';
                                }
                                return null;
                              },
                            ),
                            TextFormField(
                              controller: mobileController,
                              maxLength: 10,
                              maxLengthEnforcement:
                                  MaxLengthEnforcement.enforced,
                              buildCounter: (context,
                                  {required currentLength,
                                  required isFocused,
                                  required maxLength}) {
                                return Container();
                              },
                              decoration:
                                  const InputDecoration(labelText: 'Mobile'),
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]'),
                                ),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your mobile number';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.cloud_upload_outlined),
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });
                                if (_editDataFormKey.currentState != null &&
                                    _editDataFormKey.currentState!.validate()) {
                                  bool isSuccess =
                                      await CustomFirebaseQueryHandle
                                          .updateData(
                                              widget.documentId,
                                              nameController.text,
                                              selectedLabel,
                                              specialityLabel,
                                              addressController.text,
                                              chargesController.text,
                                              CustomFireBaseAuth()
                                                  .currentUser
                                                  ?.email,
                                              firmNameController.text,
                                              mobileController.text);
                                  if (isSuccess) {
                                    setState(() {
                                      _editDataFormKey.currentState?.reset();
                                      nameController.clear();
                                      firmNameController.clear();
                                      addressController.clear();
                                      chargesController.clear();
                                      mobileController.clear();
                                      isLoading = false;
                                    });
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Data Updated'),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                      Navigator.of(context).pop();
                                    }
                                  }
                                } else {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  return;
                                }
                              },
                              label: const Text('Update'),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
