import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lunch_app_2/Launcher.dart';
import 'package:lunch_app_2/base-scaffold.dart';
import 'package:map_view/camera_position.dart';
import 'package:map_view/map_view.dart';
import 'package:map_view/static_map_provider.dart';

var API_KEY = "AIzaSyDIPOcga2TIdd3BvwyYr3HPhuf6B1anny0";

class RestaurantInfoState extends State<RestaurantInfo> {
  String title; String description;
  String address;
  String url;
  String phoneNumber;

  List<Marker> markers = new List();

  var staticMapProvider = new StaticMapProvider(API_KEY);
  Uri _staticMapUri = null;
  CameraPosition _cameraPosition = null;
  MapView mapView = new MapView();

  _handleDismiss() async {
    var uri = await staticMapProvider.getImageUriFromMap(mapView, width: 900, height: 400);
    setState(() => _staticMapUri = uri);
    mapView.dismiss();
  }

  showMap() {
    mapView.show(
        new MapOptions(
            mapViewType: MapViewType.normal,
            showUserLocation: true,
            initialCameraPosition: _cameraPosition,
            title: "Recently Visited"
        ),
        toolbarActions: [new ToolbarAction("Close", 1)]
    );
    mapView.onMapReady.listen((_) {
      mapView.setMarkers(markers);
    });
    mapView.onLocationUpdated.listen((location) => print("Location updated $location"));
    mapView.onTouchAnnotation .listen((annotation) => print("annotation tapped"));
    mapView.onMapTapped.listen((location) => print("Touched location $location"));
    mapView.onCameraChanged.listen((cameraPosition) => this.setState(() => this._cameraPosition = cameraPosition));
    mapView.onToolbarAction.listen((id) {
      if (id == 1) {
        _handleDismiss();
      }
    });
    mapView.onInfoWindowTapped.listen((marker) {
      print("Info Window Tapped for ${marker.title}");
    });
  }

  @override
  void initState() {
    super.initState();
    MapView.setApiKey(API_KEY);
    getCoordinates(address).then((coordinates) {
      setState(() {
        Location location = new Location(coordinates["lat"], coordinates["lng"]);
        _cameraPosition = new CameraPosition(location, 15.0);
        markers.add(new Marker("1", title, coordinates["lat"], coordinates["lng"]));
        _staticMapUri = staticMapProvider.getStaticUriWithMarkers(markers, width: 900, height: 400);
      });
    });
  }

  Future<Map> getCoordinates(String address) async {
    HttpClient httpClient = new HttpClient();
    var request = await httpClient.getUrl(
        Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?address=" + address + "&key=" + API_KEY)
    );
    var response = await request.close();
    var responseBody = await response.transform(UTF8.decoder).join();
    Map json = JSON.decode(responseBody);
    return json["results"][0]["geometry"]["location"];
  }

  RestaurantInfoState(String title, String description, String address, String url,
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

  RestaurantInfo(String title, String description, String address, String url,
      String phoneNumber) {
    this.title = title;
    this.description = description;
    this.address = address;
    this.url = url;
    this.phoneNumber = phoneNumber;
  }

  @override
  State<StatefulWidget> createState() {
    return new RestaurantInfoState(title, description, address, url, phoneNumber);
  }
}

