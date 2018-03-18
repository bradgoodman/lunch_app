import 'package:flutter/material.dart';
import 'package:lunch_app_2/favorite-widget.dart';
import 'package:lunch_app_2/restaurant-info.dart';
import 'package:url_launcher/url_launcher.dart';

class Restaurant extends ListTile {
  Restaurant(
      {String title, String description, String address, String url, String phoneNumber, BuildContext context})
      : super(
      title: new Text(title),
      subtitle: new Text(description),
      trailing: new FavoriteWidget(),
      onTap: () => (Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
        return new RestaurantInfo(title, description, address, url, phoneNumber);
      })))
  );
}

