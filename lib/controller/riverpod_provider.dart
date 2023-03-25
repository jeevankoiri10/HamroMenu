import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_menu_getx/pages/customer_page/src/locations.dart';

final myLocationProvider = ChangeNotifierProvider<MyLocation>((ref) {
  return MyLocation();
});

// required for the above changeNotifierProvider<MyLocation>
class MyLocation extends ChangeNotifier {
  LatLng myCurrentLocation = LatLng(lat: 12, lng: 13);
  void setMyLocationn(locationVal) {
    myCurrentLocation = locationVal;
    notifyListeners();
  }
}
