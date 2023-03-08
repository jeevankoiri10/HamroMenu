import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hamro_menu_getx/pages/details_favourite_page.dart';

class HomeRestaurantListPage extends StatelessWidget {
  HomeRestaurantListPage({super.key});
  List Items = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite Page'),
      ),
      body: Center(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: Items.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                  title: Text('Restaurant ${Items[index]}'),
                  // iconColor: Colors.blue,
                  leading: const Icon(Icons.favorite),
                  minLeadingWidth: 5,
                  trailing: const Icon(Icons.arrow_forward_ios),
                  horizontalTitleGap: 10,
                  onTap: () {
                    print('Item ${Items[index]}');
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailsFavourite(indexSent: index),
                    ));
                  },
                  subtitle: Text('Subtitile: ${Items[index]}'),
                ));
              })),
    );
  }
}
