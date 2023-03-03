import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'controller/set_location_controller.dart';
// use this to remove your error
//import 'package:latlong2/latlong.dart' as latlong;
// nepal 28.3949° N, 84.1240° E
//27.6588° N, 85.3247° E lalitpur

class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController gmapController;

  Set<Marker> mymarkersSet = {};
  // final controller1 = Get.put(MapController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(latitude, longitude), //LatLng(27.65, 85.72);
                zoom: 14,
              ),
              onMapCreated: (controller) {
                gmapController = controller;
                isAddressAssigned = false;
              },
              // on tap to make marker on the mapPage
              onTap: (argument) {
                setState(() {
                  mymarkersSet.clear();
                  mymarkersSet.add(Marker(
                      markerId: MarkerId('id1'),
                      position: LatLng(argument.latitude, argument.longitude)));

                  print('argument: $argument');
                  setLalitudeAndLongitude(
                      argument.latitude, argument.longitude);
                });

                // setState(() {});
              },
              markers: mymarkersSet,
            ),
            // finding my location and setting it
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    // determine the current location using geolocator api.
                    Position position = await determinePosition();
                    // update the camera position
                    gmapController.animateCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(
                            target:
                                LatLng(position.latitude, position.longitude),
                            zoom: 14)));
                    setState(() {
                      print(position);
                      mymarkersSet.clear();
                      mymarkersSet.add(Marker(
                          markerId: MarkerId('id1'),
                          position:
                              LatLng(position.latitude, position.longitude)));
                      setLalitudeAndLongitude(
                          position.latitude, position.longitude);
                      isAddressAssigned = true;
                    });
                  },
                  child: Text('My Location',
                      style: TextStyle(color: Colors.black)),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
                ),
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * 0.3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      print('$latitude L + $longitude longi');
                      // // determine th
                      //e current location using geolocator api.
                      // Position position = await determinePosition();
                      // // update the camera position
                      // gmapController.animateCamera(
                      //     CameraUpdate.newCameraPosition(CameraPosition(
                      //         target:
                      //             LatLng(position.latitude, position.longitude),
                      //         zoom: 14)));
                      // setState(() {
                      //   print(position);
                      //   mymarkersSet.clear();
                      //   mymarkersSet.add(Marker(
                      //       markerId: MarkerId('id1'),
                      //       position:
                      //           LatLng(position.latitude, position.longitude)));
                      // });

                      goToHomePage(context);
                    },
                    child: Text('Set Location',
                        style: TextStyle(color: Colors.black)),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      return Future.error('Location permission denied.');
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permission are permanently denied');
    }
    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}
