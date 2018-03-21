import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

var API_KEY = "AIzaSyDIPOcga2TIdd3BvwyYr3HPhuf6B1anny0";

class RestaurantInfo extends StatefulWidget {
  @override
  _RestaurantInfoState createState() => new _RestaurantInfoState();
}

class _RestaurantInfoState extends State<RestaurantInfo> {
  MapView mapView = new MapView();
  var staticMapProvider = new StaticMapProvider(API_KEY);
  var compositeSubscription = new CompositeSubscription();
  Uri _staticMapUri;
  CameraPosition _cameraPosition;

  @override
  initState() {
    super.initState();
    MapView mapView = new MapView();
    _cameraPosition = new CameraPosition(Locations.portland, 12.0);
    _staticMapUri = staticMapProvider.getStaticUri(Locations.portland, 12,
        width: 900, height: 400);

    getCoordinates("5736 Lindenwood Ave St Louis").then((coordinates) {
      setState(() {
        Location location =
            new Location(coordinates["lat"], coordinates["lng"]);
        _cameraPosition = new CameraPosition(location, 15.0);
        _staticMapUri = staticMapProvider.getStaticUri(location, 15,
            width: 900, height: 400);
        print(location);
      });
    });
  }

  Future<Map> getCoordinates(String address) async {
    HttpClient httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(
        "https://maps.googleapis.com/maps/api/geocode/json?address=" +
            address +
            "&key=" +
            API_KEY));
    var response = await request.close();
    var responseBody = await response.transform(UTF8.decoder).join();
    Map json = JSON.decode(responseBody);
    return json["results"][0]["geometry"]["location"];
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Map View Example'),
          ),
          body: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                height: 250.0,
                child: new Stack(
                  children: <Widget>[
                    new InkWell(
                      child: new Center(
                        child: new Image.network(_staticMapUri.toString()),
                      ),
                      onTap: showMap,
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  showMap() {
    mapView.show(
        new MapOptions(
            mapViewType: MapViewType.normal,
            showUserLocation: true,
            initialCameraPosition: _cameraPosition,
            title: "Recently Visited"),
        toolbarActions: [new ToolbarAction("Close", 1)]);

    var sub = mapView.onMapReady.listen((_) {
      mapView.setMarkers(<Marker>[
        new Marker("1", "Work", 45.523970, -122.663081, color: Colors.blue),
        new Marker("2", "Nossa Familia Coffee", 45.528788, -122.684633),
      ]);
      mapView.addMarker(new Marker("3", "10 Barrel", 45.5259467, -122.687747,
          color: Colors.purple));

      mapView.zoomToFit(padding: 100);
    });
    compositeSubscription.add(sub);

    sub = mapView.onLocationUpdated
        .listen((location) => print("Location updated $location"));
    compositeSubscription.add(sub);

    sub = mapView.onTouchAnnotation
        .listen((annotation) => print("annotation tapped"));
    compositeSubscription.add(sub);

    sub = mapView.onMapTapped
        .listen((location) => print("Touched location $location"));
    compositeSubscription.add(sub);

    sub = mapView.onCameraChanged.listen((cameraPosition) =>
        this.setState(() => this._cameraPosition = cameraPosition));
    compositeSubscription.add(sub);

    sub = mapView.onToolbarAction.listen((id) {
      if (id == 1) {
        _handleDismiss();
      }
    });
    compositeSubscription.add(sub);

    sub = mapView.onInfoWindowTapped.listen((marker) {
      print("Info Window Tapped for ${marker.title}");
    });
    compositeSubscription.add(sub);
  }

  _handleDismiss() async {
    double zoomLevel = await mapView.zoomLevel;
    Location centerLocation = await mapView.centerLocation;
    List<Marker> visibleAnnotations = await mapView.visibleAnnotations;
    print("Zoom Level: $zoomLevel");
    print("Center: $centerLocation");
    print("Visible Annotation Count: ${visibleAnnotations.length}");
    var uri = await staticMapProvider.getImageUriFromMap(mapView,
        width: 900, height: 400);
    setState(() => _staticMapUri = uri);
    mapView.dismiss();
    compositeSubscription.cancel();
  }
}

class CompositeSubscription {
  Set<StreamSubscription> _subscriptions = new Set();

  void cancel() {
    for (var n in this._subscriptions) {
      n.cancel();
    }
    this._subscriptions = new Set();
  }

  void add(StreamSubscription subscription) {
    this._subscriptions.add(subscription);
  }

  void addAll(Iterable<StreamSubscription> subs) {
    _subscriptions.addAll(subs);
  }

  bool remove(StreamSubscription subscription) {
    return this._subscriptions.remove(subscription);
  }

  bool contains(StreamSubscription subscription) {
    return this._subscriptions.contains(subscription);
  }

  List<StreamSubscription> toList() {
    return this._subscriptions.toList();
  }
}
