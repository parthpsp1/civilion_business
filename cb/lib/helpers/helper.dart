import 'package:url_launcher/url_launcher.dart';

Future<void> launchCustomUrl(url) async {
  String urlToLaunc = 'tel://$url';
  if (!await launchUrl(Uri.parse(urlToLaunc))) {
    throw Exception('Could} not launch $urlToLaunc');
  }
}
