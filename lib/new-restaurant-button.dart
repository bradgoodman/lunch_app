import 'package:flutter/material.dart';

class NewRestaurantButton extends FloatingActionButton {
  NewRestaurantButton(BuildContext context) : super(
      tooltip: 'Add',
      child: new Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).pushNamed("/newRestaurant");
      }
  );
}
