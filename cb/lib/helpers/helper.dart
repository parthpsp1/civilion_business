import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:typed_data';

Future<void> launchCustomUrl(url) async {
  String urlToLaunc = 'tel://$url';
  if (!await launchUrl(Uri.parse(urlToLaunc))) {
    throw Exception('Could} not launch $urlToLaunc');
  }
}

Future<String> filePicker() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowCompression: true,
    type: FileType.image,
  );
  if (result != null) {
    File file = File(result.files.single.path!);
    if (file.path != '') {
      String base64string = await fileToBase64String(file.path);
      return base64string;
    }
    return '';
  } else {
    return '';
  }
}

Future<String> fileToBase64String(String filePath) async {
  Uint8List fileBytes = await File(filePath).readAsBytes();
  return base64Encode(fileBytes);
}
