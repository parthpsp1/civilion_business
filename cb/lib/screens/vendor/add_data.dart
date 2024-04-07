import 'package:cb/auth/custom_firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController actualWorkController = TextEditingController();
  TextEditingController firmNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController chargesController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  String selectedLabel = "Architect"; // Default selected label

  List<String> labels = [
    "Architect",
    "Structural",
    "Designer",
    "Transporters",
    "Machineries",
    "Contractor",
    "Surveyor",
    "Geotechnical",
    "Project Manager",
    "Labor",
  ];

  Future<bool> addData() async {
    final entry = {
      "name": nameController.text,
      "profession": selectedLabel,
      "actual_work": actualWorkController.text,
      "address": addressController.text,
      "charges": chargesController.text,
      "email": CustomFireBaseAuth().currentUser?.email,
      "firm_name": firmNameController.text,
      "mobile": mobileController.text
    };

    try {
      await FirebaseFirestore.instance.collection('vendor').add(entry);
      return true;
    } catch (e) {
      return false;
    }
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            isLoading
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(child: CircularProgressIndicator()),
                    ],
                  )
                : Expanded(
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          DropdownButtonFormField<String>(
                            value: selectedLabel,
                            onChanged: (String? value) {
                              setState(() {
                                selectedLabel = value!;
                              });
                            },
                            items: labels.map((String label) {
                              return DropdownMenuItem<String>(
                                value: label,
                                child: Text(label),
                              );
                            }).toList(),
                            decoration: const InputDecoration(
                                labelText: 'Select Profession'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a label';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: nameController,
                            decoration:
                                const InputDecoration(labelText: 'Name'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: actualWorkController,
                            decoration:
                                const InputDecoration(labelText: 'Actual Work'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your actual work';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: firmNameController,
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
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            buildCounter: (context,
                                {required currentLength,
                                required isFocused,
                                required maxLength}) {
                              return Container();
                            },
                            decoration:
                                const InputDecoration(labelText: 'Mobile'),
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your mobile number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              if (_formKey.currentState != null &&
                                  _formKey.currentState!.validate()) {
                                bool isSuccess = await addData();
                                if (isSuccess) {
                                  setState(() {
                                    _formKey.currentState?.reset();
                                    nameController.clear();
                                    actualWorkController.clear();
                                    firmNameController.clear();
                                    addressController.clear();
                                    chargesController.clear();
                                    mobileController.clear();
                                    selectedLabel = "Architect";
                                    isLoading = false;
                                  });
                                }
                              } else {
                                return;
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
