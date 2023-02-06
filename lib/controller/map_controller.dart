import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MapController extends GetxController {
  var latitude = 27.6588.obs;
  var longitude = 85.3247.obs;
  var Address = ''.obs;

  void changeAddress(RxString address, BuildContext context) {
    Address = address;
    update();
    Navigator.of(context).popAndPushNamed('/');
  }

  void setLalitudeAndLongitude(double latitude, double longitude) {
    this.latitude = RxDouble(latitude);
    this.longitude = RxDouble(longitude);
  }
}
