import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hamro_menu_getx/pages/restaurant_owner_page/CRUD/crud_controller.dart';

class UploadedRestaurantOwnerPage extends StatefulWidget {
  const UploadedRestaurantOwnerPage({super.key});

  @override
  State<UploadedRestaurantOwnerPage> createState() =>
      _UploadedRestaurantOwnerPageState();
}

class _UploadedRestaurantOwnerPageState
    extends State<UploadedRestaurantOwnerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Hamro Menu')),
        body: SafeArea(
          child: Column(
            children: [],
          ),
        ));
  }
}
