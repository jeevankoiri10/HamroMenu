import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class SearchPlaceScreen extends StatefulWidget {
  const SearchPlaceScreen({super.key});

  @override
  State<SearchPlaceScreen> createState() => _SearchPlaceScreenState();
}

class _SearchPlaceScreenState extends State<SearchPlaceScreen> {
  static const initialCameraPosition = CameraPosition(target: LatLng(28, 48));
  Set<Marker> marksersList = {};
  late GoogleMapController googleMapController;

  final Mode _mode = Mode.overlay;
  String kGoogleApiKey = 'AIzaSyAfixTbiUl5P2-Rhb2NXGQPL6I1sky1KL4';

  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      body: SafeArea(
          child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: initialCameraPosition,
            markers: marksersList,
            mapType: MapType.normal,
            onMapCreated: (GoogleMapController controller) {
              googleMapController = controller;
            },
          ),
          // text field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
              onTap: () {},
            ),
          ),
        ],
      )),
    );
  }

  Future<void> _handlePressButton() async {
    Future<Prediction?> predict = PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: _mode,
      language: 'en',
      strictbounds: false,
      types: [""],
      decoration: InputDecoration(
          hintText: 'Search',
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white))),
      components: [Component(Component.country, "np")],
    );
  }

  void onError(PlacesAutocompleteResponse response) {
    print(response);
  }
}
