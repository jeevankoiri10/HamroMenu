import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_menu_getx/src/locations.dart';
import '../models/auto_complete_result.dart';

final placeResultsProvider = ChangeNotifierProvider<PlaceResults>((ref) {
  return PlaceResults();
});

final searchToggleProvider = ChangeNotifierProvider<SearchToggle>((ref) {
  return SearchToggle();
});

// new provider for the current location by jeevan koiri
final setCurrentLocationProvider =
    StateNotifierProvider<SetCurrentLocation, LatLng>(
        (ref) => SetCurrentLocation());

// required for the above changeNotifierProvider<PlaceResults>
class PlaceResults extends ChangeNotifier {
  // AutoCompleteResult is a model
  List<AutoCompleteResult> allReturnedResults = [];

  void setResults(allPlaces) {
    allReturnedResults = allPlaces;
    notifyListeners();
  }
}

// required for the above changeNotifierProvider<SearchToggle>
class SearchToggle extends ChangeNotifier {
  bool searchToggle = false;
  // set on and off the searchToggle variable
  void toggleSearch() {
    searchToggle = !searchToggle;
    notifyListeners();
  }
}

// new jeevan koiri
// required for the above StateNotifier<SetCurrentLocation>
class SetCurrentLocation extends StateNotifier<LatLng> {
  // setting the initial starting location
  SetCurrentLocation() : super(LatLng(lat: 12, lng: 13));
  bool locationToggle = false;
  void toggleLocation() {
    locationToggle = !locationToggle;
  }

  // set on and off the searchToggle variable
  void setMyCurrentLocation(double lat, double lng) {
    state = LatLng(lat: lat, lng: lng);
  }
}
