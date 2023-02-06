import 'package:geolocator/geolocator.dart';
import 'package:hamro_menu_getx/main.dart';

class MyMap {
  double lat = 0;
  double long = 0;
  String pos = 'My Location';

  Future<void> getLocation() async {
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    var pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print('Pos:' + pos.toString());
    if (pos != null) {
      lat = pos.latitude;
      long = pos.longitude;
    }
  }
}
