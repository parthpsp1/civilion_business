import 'package:cb/auth/custom_firebase_auth.dart';
import 'package:cb/local_storage/local_storage.dart';
import 'package:cb/model/vendor_data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomFirebaseQueryHandle {
  static Future<bool> addData(
      String name,
      String selectedLabel,
      String specialityLabel,
      String address,
      String charges,
      String? email,
      String firmName,
      String mobile) async {
    final entry = {
      "photoId": await LocalStorage().getPhotoId(),
      "signatureImage": await LocalStorage().getSignatureImage(),
      "educationalDocument": await LocalStorage().getEducationalDocument(),
      "name": name,
      "profession": selectedLabel,
      "speciality": specialityLabel,
      "address": address,
      "charges": charges,
      "email": email,
      "firm_name": firmName,
      "mobile": mobile
    };

    try {
      await FirebaseFirestore.instance.collection('vendor').add(entry);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateData(
      String documentId,
      String name,
      String selectedLabel,
      String specialityLabel,
      String address,
      String charges,
      String? email,
      String firmName,
      String mobile) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('vendor').doc(documentId);
    final entry = {
      "name": name,
      "profession": selectedLabel,
      "speciality": specialityLabel,
      "address": address,
      "charges": charges,
      "email": email,
      "firm_name": firmName,
      "mobile": mobile
    };

    try {
      await documentReference.update(entry);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<DocumentSnapshot?> fetchData(String documentId) async {
    try {
      DocumentSnapshot? documentSnapshot = await FirebaseFirestore.instance
          .collection('vendor')
          .doc(documentId)
          .get();
      return documentSnapshot;
    } catch (e) {
      // Handle error
      return null;
    }
  }

  static Stream<List<Vendor>> readData() => FirebaseFirestore.instance
      .collection('vendor')
      .snapshots()
      .map((event) => event.docs
          .map((doc) => Vendor.fromJson(doc.id, doc.data()))
          .where((vendor) =>
              vendor.email == CustomFireBaseAuth().currentUser?.email)
          .toList());
}
