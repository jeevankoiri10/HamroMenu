import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hamro_menu_getx/controller/set_location_controller.dart';

import 'animated_google_map_page/models/auto_complete_result.dart';
import 'animated_google_map_page/services/map_services.dart';

class PlacesListGoogleMap extends StatefulWidget {
  const PlacesListGoogleMap({super.key});

  @override
  State<PlacesListGoogleMap> createState() => _PlacesListGoogleMapState();
}

class _PlacesListGoogleMapState extends State<PlacesListGoogleMap> {
  Future<List<String>> returnPlacesItems() async {
    var placesResult =
        await MapServices().getPlaceDetails(LatLng(latitude, longitude), 10000);
    List<dynamic> placesWithin = placesResult['results'] as List;
    List<String> PlaceItemsName = [];
    //return placesWithin;
    placesWithin.forEach((element) {
      print(element['name']);

      PlaceItemsName.add(element['name']);
      // element['types'],
      // element['business_status'] ??
      //     'not available',
    });
    return PlaceItemsName;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: returnPlacesItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text('Data: ${snapshot.data}');
                }
              },
            ),
            ElevatedButton(
                onPressed: () async {
                  print(await returnPlacesItems());
                },
                child: Column(
                  children: [
                    Text('Print console places item'),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
