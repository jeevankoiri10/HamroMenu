import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hamro_menu_getx/animated_google_map_page.dart';
import 'package:hamro_menu_getx/pages/favourite_page.dart';
import 'package:hamro_menu_getx/pages/set_location_page/set_location_google_map_page.dart';
import 'package:hamro_menu_getx/homepage_view.dart';
import 'package:hamro_menu_getx/pages/login_pages/login_page.dart';
import 'package:hamro_menu_getx/set_location_main_page.dart';
import 'package:hamro_menu_getx/pages/search_page_view.dart';
import 'package:hamro_menu_getx/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.blue,
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LogInPage(), //SignInDemo(), //
        '/': (context) => HomePage(),
        '/mapPage': (context) => MapPage(),
        '/searchPage': (context) => SearchPage(),
        '/favorite': (context) => FavoritePage(),
        '/gmap': (context) => GoogleMapFlutterPage(),
        '/animatedMap': (context) => AnimatedGoogleMap(),
      },
    );
  }
}
