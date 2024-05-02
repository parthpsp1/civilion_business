import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  void savePhotoId(String photoId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('photoId', photoId);
  }

  Future<String> getPhotoId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('photoId') ?? '';
  }

  void removePhotoId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('photoId');
  }

  void saveSignatureImage(String signatureImage) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('signatureImage', signatureImage);
  }

  Future<String> getSignatureImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('signatureImage') ?? '';
  }

  void removeSignatureImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('signatureImage');
  }

  void saveEducationalDocument(String educationalDocument) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('educationalDocument', educationalDocument);
  }

  Future<String> getEducationalDocument() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('educationalDocument') ?? '';
  }

  void removeEducationalDocument() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('educationalDocument');
  }
}
