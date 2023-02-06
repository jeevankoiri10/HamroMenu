import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
// use this to remove your error
//import 'package:latlong2/latlong.dart' as latlong;
// nepal 28.3949° N, 84.1240° E
//27.6588° N, 85.3247° E lalitpur

LatLng currentLocation = LatLng(27.65, 85.72);

class GoogleMapFlutterPage extends StatefulWidget {
  @override
  State<GoogleMapFlutterPage> createState() => _GoogleMapFlutterPageState();
}

class _GoogleMapFlutterPageState extends State<GoogleMapFlutterPage> {
  late GoogleMapController gmapController;
  Set<Marker> mymarkersSet = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentLocation,
                zoom: 14,
              ),
              onMapCreated: (controller) {
                gmapController = controller;
              },
              markers: mymarkersSet,
            ),
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

                    // clear and move the marker
                    print('making marker');
                    mymarkersSet.clear();
                    mymarkersSet.add(Marker(
                        markerId: MarkerId('id1'),
                        position:
                            LatLng(position.latitude, position.longitude)));
                    print("marker made");
                    //markers.clear()
                  },
                  child: Text('My Location',
                      style: TextStyle(color: Colors.black)),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white),
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
