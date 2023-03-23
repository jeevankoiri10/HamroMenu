import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hamro_menu_getx/homepage_view.dart';

// LatLng(27.682259515941116, 85.31859149792422), to show himalayan hotel at first
var latitude = 27.682259515941116;
var longitude = 85.31859149792422;
bool isAddressAssigned = false;

void setLalitudeAndLongitude(double latitude1, double longitude1) {
  latitude = latitude1;
  longitude = longitude1;
  isAddressAssigned = true;
}

void goToHomePage(BuildContext context) {
  isAddressAssigned = true;
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => CustomerHomePage()));
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
