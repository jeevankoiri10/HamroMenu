import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controller/map_controller.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    // You can ask Get to find a Controller that is being used by another page and redirect you to it.
    final MapController controller = Get.find();
    Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
    LatLng _center =
        LatLng(controller.latitude.toDouble(), controller.longitude.toDouble());

    void _onMapCreated(GoogleMapController controller) {
      final marker = Marker(
        markerId: MarkerId('place_name'),
        position: LatLng(9.669111, 80.014007),
        // icon: BitmapDescriptor.,
        infoWindow: InfoWindow(
          title: 'title',
          snippet: 'address',
        ),
      );

      setState(() {
        markers[MarkerId('place_name')] = marker;
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          //     SafeArea(
          //       child: Align(
          //         alignment: Alignment.centerLeft,
          //         child: Text('Safe Area'),
          //       ),
          //     ),
          //     Stack(
          //       children: [
          //         GoogleMap(
          //           onMapCreated: _onMapCreated,
          //           initialCameraPosition:
          //               CameraPosition(target: _center, zoom: 14.14),
          //           compassEnabled: true,
          //           myLocationButtonEnabled: true,
          //           markers: markers.values.toSet(),
          //         ),
          //         Positioned(
          //           left: MediaQuery.of(context).size.width / 4,
          //           right: MediaQuery.of(context).size.width / 4,
          //           bottom: 1,
          //           child: Padding(
          //             padding: const EdgeInsets.all(8.0),
          //             child: ElevatedButton(
          //                 onPressed: () {}, child: Text('Set Current Location')),
          //           ),
          //         ),
          //       ],
          //     ),

          OpenStreetMapSearchAndPick(
            center: LatLong(controller.latitude.toDouble(),
                controller.longitude.toDouble()),
            buttonText: 'Set Current Location',
            onPicked: (pickedData) {
              // print(pickedData.latLong.latitude);
              // print(pickedData.latLong.longitude);
              // print(pickedData.address);
              controller.changeAddress(
                  RxString(pickedData.address.toString()), context);
            },
          ),
        ],
      ),
    );
  }
}
