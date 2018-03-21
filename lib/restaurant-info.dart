import 'package:flutter/material.dart';
import 'package:lunch_app_2/base-scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantInfo extends StatelessWidget {
  String title;
  String description;
  String address;
  String url;
  String phoneNumber;

  RestaurantInfo(String title, String description, String address, String url,
      String phoneNumber) {
    this.title = title;
    this.description = description;
    this.address = address;
    this.url = url;
    this.phoneNumber = phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return new BaseScaffold(
      title: title,
      body: new ListView(children: _buildListView(context)),
    );
  }

  List<Widget> _buildListView(BuildContext context) {
    return new List.from([
      new ListTile(
        leading: new Icon(Icons.place),
        title: new Text('Address'),
        subtitle: new Text(address),
      ),
      new ListTile(
        leading: new Icon(Icons.local_phone),
        title: new Text('Phone Number'),
        subtitle: new Text(phoneNumber),
        onTap: () => _launchCall(phoneNumber),
      ),
      new ListTile(

        leading: new Icon(Icons.launch),
        title: new Text('Website'),
        subtitle: new Text(url),
        onTap: () => _launchURL(url),
      ),
    ]);
  }

  static _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  static _launchCall(String phoneNumber) async {
    String call = 'tel: ' + phoneNumber;
    if (await canLaunch(call)) {
      await launch(call);
    } else {
      throw 'Could not $call phone number';
    }
  }
}
