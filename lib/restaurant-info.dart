import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lunch_app_2/google-maps.dart';
import 'package:lunch_app_2/launcher.dart';
import 'package:lunch_app_2/base-scaffold.dart';
import 'package:map_view/camera_position.dart';
import 'package:map_view/map_view.dart';
import 'package:map_view/static_map_provider.dart';

var API_KEY = "AIzaSyDIPOcga2TIdd3BvwyYr3HPhuf6B1anny0";

class RestaurantInfoState extends State<RestaurantInfo> {
  String title;
  String description;
  String address;
  String url;
  String phoneNumber;

  RestaurantInfoState(this.title, this.description, this.address, this.url, this.phoneNumber);

  List<Marker> markers = new List();
  Uri _staticMapUri = null;
  CameraPosition _cameraPosition = null;

  void showMap() {
    MapView mapView = new MapView();
    mapView.show(
        new MapOptions(
            mapViewType: MapViewType.normal,
            showUserLocation: true,
            initialCameraPosition: _cameraPosition,
            title: title
        ),
        toolbarActions: [new ToolbarAction("Close", 1)]
    );
    mapView.onMapReady.listen((_) {
      mapView.setMarkers(markers);
    });
    mapView.onCameraChanged.listen((cameraPosition) => this.setState(() => this._cameraPosition = cameraPosition));
    mapView.onToolbarAction.listen((id) {
      if (id == 1) {
        mapView.dismiss();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    MapView.setApiKey(API_KEY);
    GoogleMaps googleMaps = new GoogleMaps(API_KEY);
    googleMaps.getCoordinates(address).then((coordinates) {
      setState(() {
        Location location = new Location(coordinates["lat"], coordinates["lng"]);
        _cameraPosition = new CameraPosition(location, 15.0);
        markers.add(new Marker("1", title, coordinates["lat"], coordinates["lng"]));
        _staticMapUri = new StaticMapProvider(API_KEY).getStaticUriWithMarkers(markers, width: 900, height: 400);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return new BaseScaffold(
      title: title,
      body: new ListView(children: _buildListView(context)),
    );
  }

  List<Widget> _buildListView(BuildContext context) {
    var elements = new List.from([
      new ListTile(
        leading: new Icon(Icons.place),
        title: new Text('Address'),
        subtitle: new Text(address),
      ),
      new ListTile(
        leading: new Icon(Icons.local_phone),
        title: new Text('Phone Number'),
        subtitle: new Text(phoneNumber),
        onTap: () => Launcher.launchCall(phoneNumber),
      ),
      new ListTile(
        leading: new Icon(Icons.launch),
        title: new Text('Website'),
        subtitle: new Text(url),
        onTap: () => Launcher.launchURL(url),
      )
    ]);

    if(_staticMapUri != null) {
      elements.add(new InkWell(
          child: new Center(
            child: new Image.network(_staticMapUri.toString()),
          ),
          onTap: showMap
      ));
    } else {
      elements.add(new InkWell(
          child: new Center(
            child: new Text("Loading map...")
          )
      ));
    }

    return elements;
  }

}

class RestaurantInfo extends StatefulWidget {
  String title;
  String description;
  String address;
  String url;
  String phoneNumber;

  RestaurantInfo(this.title, this.description, this.address, this.url, this.phoneNumber);

  @override
  State<StatefulWidget> createState() {
    return new RestaurantInfoState(title, description, address, url, phoneNumber);
  }
}

