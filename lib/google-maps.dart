import 'dart:async';
import 'dart:convert';

import 'dart:io';

class GoogleMaps {
  String apiKey;

  GoogleMaps(this.apiKey);

  Future<Map> getCoordinates(String address) async {
    HttpClient httpClient = new HttpClient();
    var request = await httpClient.getUrl(
        Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?address=" + address + "&key=" + this.apiKey)
    );
    var response = await request.close();
    var responseBody = await response.transform(UTF8.decoder).join();
    Map json = JSON.decode(responseBody);
    return json["results"][0]["geometry"]["location"];
  }
}