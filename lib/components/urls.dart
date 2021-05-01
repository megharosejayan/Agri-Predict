import "package:url_launcher/url_launcher.dart";

class urlfunc {
  static launchURL(String urls) async {
    var url = urls;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}