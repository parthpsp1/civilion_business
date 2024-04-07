import 'package:cb/auth/custom_firebase_auth.dart';
import 'package:cb/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  TextEditingController emailController = TextEditingController();

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

  Future addData() async {
    final entry = {
      "name": nameController.text,
      "profession": selectedLabel,
      "actual_work": actualWorkController.text,
      "address": addressController.text,
      "charges": chargesController.text,
      "email": emailController.text,
      "firm_name": firmNameController.text,
      "mobile": mobileController.text
    };
    FirebaseFirestore.instance.collection('vendor').add(entry);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Civilion Business'),
          automaticallyImplyLeading: false,
          actions: [
            TextButton.icon(
              onPressed: () {
                CustomFireBaseAuth().signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ));
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Welcome! ${CustomFireBaseAuth().currentUser!.email!}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              const Text(
                'Add Data',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Expanded(
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
                        decoration: const InputDecoration(labelText: 'Name'),
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
                        decoration: const InputDecoration(labelText: 'Address'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: chargesController,
                        decoration: const InputDecoration(labelText: 'Charges'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter charges';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: mobileController,
                        decoration: const InputDecoration(labelText: 'Mobile'),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your mobile number';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email address';
                          }
                          // You can add more email validation logic here if needed
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            await addData();
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
      ),
    );
  }
}

Map<String, dynamic> architectData = {};

void addData(String label, TextEditingController controller) {
  architectData[label] = controller.text;
}
