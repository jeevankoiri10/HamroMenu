import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SearchController extends GetxController {
  var input = ''.obs;
  var inputRestaurantList = [].obs;
  var inputMenuList = [].obs;
  var isMenu = 0.obs;
  void changeInput(RxString inputdata, BuildContext context) {
    input = inputdata;
    print(input);
    if (input != null) {
      if (input.toLowerCase().contains('hotel') ||
          input.toLowerCase().contains('hotels') ||
          input.toLowerCase().contains('restaurant') ||
          input.toLowerCase().contains('restaurants')) {
        if (inputRestaurantList.contains(input)) {
        } else {
          inputRestaurantList.add(input);
        }
      }
      if (input.toLowerCase().contains('menu')) {
        if (inputMenuList.contains(input)) {
        } else {
          inputMenuList.add(input);
        }
      }
      print(inputRestaurantList);
      print(inputMenuList);
    }
    update();
  }
}
