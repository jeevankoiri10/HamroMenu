import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hamro_menu_getx/animated_google_map_page.dart';

class MapPageHome extends StatelessWidget {
  const MapPageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              child: Text('Go to Map GUI'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AnimatedGoogleMap()));
              },
            ),
          )
        ],
      ),
    );
  }
}
