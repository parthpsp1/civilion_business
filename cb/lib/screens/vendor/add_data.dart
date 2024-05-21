import 'package:cb/auth/custom_firebase_auth.dart';
import 'package:cb/data/label.dart';
import 'package:cb/database/firebase_query_handler.dart';
import 'package:cb/helpers/helper.dart';
import 'package:cb/local_storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final GlobalKey<FormState> _addDataFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController firmNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController chargesController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  String selectedLabel = "Architect";
  String specialityLabel = "Interior Designer";
  bool isPhotoIdUploaded = false;
  bool isSignatureUploaded = false;
  bool isEducationalDocumentUploaded = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            isLoading
                ? const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: Form(
                      key: _addDataFormKey,
                      child: ListView(
                        children: <Widget>[
                          Row(
                            children: [
                              const Text('Photo ID'),
                              const SizedBox(
                                width: 4,
                              ),
                              isPhotoIdUploaded
                                  ? TextButton(
                                      onPressed: () {},
                                      style: const ButtonStyle(
                                        visualDensity: VisualDensity.compact,
                                        backgroundColor: WidgetStatePropertyAll(
                                            Colors.green),
                                        side: WidgetStatePropertyAll(
                                            BorderSide.none),
                                      ),
                                      child: const Text(
                                        'Added',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Text('(Image File)'),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          isPhotoIdUploaded == true
                              ? ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      isPhotoIdUploaded = false;
                                    });
                                    LocalStorage().removePhotoId();
                                  },
                                  icon: const Icon(
                                    Icons.delete_outline_outlined,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: const ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                      Colors.red,
                                    ),
                                  ),
                                )
                              : ElevatedButton.icon(
                                  onPressed: () async {
                                    String result = await filePicker();
                                    if (result.isNotEmpty && result != '') {
                                      LocalStorage().savePhotoId(result);
                                      setState(() {
                                        isPhotoIdUploaded = true;
                                      });
                                    }
                                  },
                                  icon: const Icon(
                                      Icons.photo_camera_front_outlined),
                                  label: const Text('Upload Photo ID'),
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Text('Signature'),
                              const SizedBox(
                                width: 4,
                              ),
                              isSignatureUploaded
                                  ? TextButton(
                                      onPressed: () {},
                                      style: const ButtonStyle(
                                        visualDensity: VisualDensity.compact,
                                        backgroundColor: WidgetStatePropertyAll(
                                            Colors.green),
                                        side: WidgetStatePropertyAll(
                                            BorderSide.none),
                                      ),
                                      child: const Text(
                                        'Added',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Text('(Image File)'),
                            ],
                          ),
                          isSignatureUploaded == true
                              ? ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      isSignatureUploaded = false;
                                    });
                                    LocalStorage().removeSignatureImage();
                                  },
                                  icon: const Icon(
                                    Icons.delete_outline_outlined,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: const ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                      Colors.red,
                                    ),
                                  ),
                                )
                              : ElevatedButton.icon(
                                  onPressed: () async {
                                    String result = await filePicker();
                                    if (result.isNotEmpty && result != '') {
                                      LocalStorage().saveSignatureImage(result);
                                      setState(() {
                                        isSignatureUploaded = true;
                                      });
                                    }
                                  },
                                  icon: const Icon(Icons.edit_outlined),
                                  label: const Text('Upload Signature'),
                                ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              const Text('Educational Document'),
                              const SizedBox(
                                width: 4,
                              ),
                              isEducationalDocumentUploaded
                                  ? TextButton(
                                      onPressed: () {},
                                      style: const ButtonStyle(
                                        visualDensity: VisualDensity.compact,
                                        backgroundColor: WidgetStatePropertyAll(
                                            Colors.green),
                                        side: WidgetStatePropertyAll(
                                            BorderSide.none),
                                      ),
                                      child: const Text(
                                        'Added',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Text('(Image File)'),
                            ],
                          ),
                          isEducationalDocumentUploaded == true
                              ? ElevatedButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      isEducationalDocumentUploaded = false;
                                    });
                                    LocalStorage().removeEducationalDocument();
                                  },
                                  icon: const Icon(
                                    Icons.delete_outline_outlined,
                                    color: Colors.white,
                                  ),
                                  label: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: const ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                      Colors.red,
                                    ),
                                  ),
                                )
                              : ElevatedButton.icon(
                                  onPressed: () async {
                                    String result = await filePicker();
                                    if (result.isNotEmpty && result != '') {
                                      LocalStorage()
                                          .saveEducationalDocument(result);
                                      setState(() {
                                        isEducationalDocumentUploaded = true;
                                      });
                                    }
                                  },
                                  icon: const Icon(Icons.folder_open_outlined),
                                  label: const Text('Upload Document'),
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          DropdownButtonFormField<String>(
                            value: selectedLabel,
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
                            maxLength: 25,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          DropdownButtonFormField<String>(
                            value: LocalData
                                .specialityLabels[selectedLabel]!.first,
                            onChanged: (String? value) {
                              setState(() {
                                specialityLabel = value!;
                              });
                            },
                            items: LocalData.specialityLabels[selectedLabel]!
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
                            maxLength: 50,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your address';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: chargesController,
                            keyboardType: TextInputType.text,
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
                          ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              if (_addDataFormKey.currentState != null &&
                                  _addDataFormKey.currentState!.validate() &&
                                  isPhotoIdUploaded == true &&
                                  isSignatureUploaded == true &&
                                  isEducationalDocumentUploaded == true) {
                                bool isSuccess =
                                    await CustomFirebaseQueryHandle.addData(
                                        nameController.text,
                                        selectedLabel,
                                        specialityLabel,
                                        addressController.text,
                                        chargesController.text,
                                        CustomFireBaseAuth().currentUser?.email,
                                        firmNameController.text,
                                        mobileController.text);
                                if (isSuccess) {
                                  setState(() {
                                    _addDataFormKey.currentState?.reset();
                                    nameController.clear();
                                    specialityLabel = "";
                                    firmNameController.clear();
                                    addressController.clear();
                                    chargesController.clear();
                                    mobileController.clear();
                                    selectedLabel = "Architect";
                                    isLoading = false;
                                    isPhotoIdUploaded = false;
                                    isSignatureUploaded = false;
                                    isEducationalDocumentUploaded = false;
                                  });
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Data Added'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  }
                                }
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
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
