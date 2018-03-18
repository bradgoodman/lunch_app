import 'package:flutter/material.dart';
import 'package:lunch_app_2/base-scaffold.dart';
import 'package:lunch_app_2/new-restaurant-button.dart';
import 'package:lunch_app_2/restaurant.dart';

class Home extends StatelessWidget {
  List<Map> restaurantData;

  Home(List<Map> restaurantData) {
    this.restaurantData = restaurantData;
  }

  List<Widget> _buildRestaurantWidgets(BuildContext context) {
      List<Widget> listWidgets = new List();
      for(Map restaurant in restaurantData) {
        listWidgets.add(new Restaurant(
          title: restaurant['title'],
          description: restaurant['description'],
          address: restaurant['address'],
          url: restaurant['url'],
          phoneNumber: restaurant['phoneNumber'],
          context: context
        ));
      }
      return listWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return new BaseScaffold(
        title: 'Restaurants',
        body: new ListView(children: _buildRestaurantWidgets(context)),
        floatingActionButton: new NewRestaurantButton(context));
  }
}