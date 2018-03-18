import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:lunch_app_2/new-restaurant-view.dart';
import 'package:lunch_app_2/restaurant-info.dart';
import 'dart:convert';
import 'home.dart';

Future main() async {
  List<Map> restaurantData = await loadData();

  runApp(
      new MaterialApp(
        home: new Home(restaurantData),
        routes: <String, WidgetBuilder> {
          '/screen1': (BuildContext context) => new Home(restaurantData),
          '/newRestaurant' : (BuildContext context) => new NewRestaurantView()
        },
      )
  );
}
Future<List<Map>> loadData() async {
  String data = await rootBundle.loadString('assets/data.json');
  return JSON.decode(data);
}