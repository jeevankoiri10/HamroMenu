import 'package:flutter/material.dart';
import 'package:hamro_menu_getx/animated_google_map_page.dart';
import 'package:hamro_menu_getx/pages/favourite_page.dart';
import 'package:hamro_menu_getx/pages/set_location_page/googlemap_page.dart';
import 'package:hamro_menu_getx/homepage_view.dart';
import 'package:hamro_menu_getx/pages/login_pages/login_page.dart';
import 'package:hamro_menu_getx/set_location_main_page.dart';
import 'package:hamro_menu_getx/pages/search_page_view.dart';
import 'package:hamro_menu_getx/splash_screen.dart';

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
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => LogInPage(),
        '/': (context) => const HomePage(),
        '/mapPage': (context) => MapPage(),
        '/searchPage': (context) => const SearchPage(),
        '/favorite': (context) => FavoritePage(),
        '/gmap': (context) => GoogleMapFlutterPage(),
        '/animatedMap': (context) => AnimatedGoogleMap(),
      },
    );
  }
}
