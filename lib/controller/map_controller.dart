import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hamro_menu_getx/pages/homepage_view.dart';

var latitude = 35.0; //27.6588;
var longitude = 37.0; //85.3247;
bool isAddressAssigned = false;

void setLalitudeAndLongitude(double latitude1, double longitude1) {
  latitude = latitude1;
  longitude = longitude1;
  isAddressAssigned = true;
}

void goToHomePage(BuildContext context) {
  isAddressAssigned = true;
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => HomePage()));
}

Future<void> getLocation() async {
  await Geolocator.checkPermission();
  await Geolocator.requestPermission();
  var pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  print('Pos:' + pos.toString());
  if (pos != null) {
    latitude = pos.latitude;
    longitude = pos.longitude;
  }
}
