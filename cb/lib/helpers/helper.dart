import 'package:url_launcher/url_launcher.dart';

Future<void> launchCustomUrl(url) async {
  String urlToLaunc = 'tel://$url';
  if (!await launchUrl(Uri.parse(urlToLaunc))) {
    throw Exception('Could} not launch $urlToLaunc');
  }
}

// Future<bool> filePicker() async {
//   FilePickerResult? result = await FilePicker.platform.pickFiles();
//   if (result != null) {
//     File file = File(result.files.single.path!);
//     print(file);
//     return true;
//   } else {
//     return false;
//   }
// }
