import 'package:flutter/material.dart';
import 'screens/home_page_map.dart';

// void mainwala() {
//   runApp(const ProviderScope(child: AnimatedGoogleMap()));
// }

class AnimatedGoogleMap extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter Demo',
      // debugShowCheckedModeBanner: false,
      // theme: ThemeData(),
      home: HomePageMap(),
    );
  }
}
