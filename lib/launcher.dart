import 'package:url_launcher/url_launcher.dart';

class Launcher {
  static launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static launchCall(String phoneNumber) async {
    String call = 'tel: ' + phoneNumber;
    if (await canLaunch(call)) {
      await launch(call);
    } else {
      throw 'Could not $call phone number';
    }
  }
}
