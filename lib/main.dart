import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hamro_menu_getx/pages/favourite_page.dart';
import 'package:hamro_menu_getx/pages/google_map/googlemap_page.dart';
import 'package:hamro_menu_getx/pages/homepage_view.dart';
import 'package:hamro_menu_getx/pages/login_pages/login_page.dart';
import 'package:hamro_menu_getx/pages/map_page_view.dart';
import 'package:hamro_menu_getx/pages/search_page_view.dart';
import 'package:hamro_menu_getx/splash_screen.dart';
import './pages/animated_google_map/animated_google_map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.blue,
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LogInPage(),
        '/': (context) => const HomePage(),
        '/mapPage': (context) => MapPage(),
        '/searchPage': (context) => SearchPage(),
        '/favorite': (context) => FavoritePage(),
        '/gmap': (context) => GoogleMapFlutterPage(),
        '/animatedMap': (context) => AnimatedGoogleMap(),
      },
    );
  }
}
