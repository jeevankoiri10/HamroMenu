import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/auto_complete_result.dart';

final placeResultsProvider = ChangeNotifierProvider<PlaceResults>((ref) {
  return PlaceResults();
});

final searchToggleProvider = ChangeNotifierProvider<SearchToggle>((ref) {
  return SearchToggle();
});

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
