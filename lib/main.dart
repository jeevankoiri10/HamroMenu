import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_menu_getx/animated_google_map_page.dart';
import 'package:hamro_menu_getx/pages/favourite_page.dart';
import 'package:hamro_menu_getx/pages/login_pages/login_ui.dart';
import 'package:hamro_menu_getx/pages/set_location_page/set_location_google_map_page.dart';
import 'package:hamro_menu_getx/homepage_view.dart';
import 'package:hamro_menu_getx/pages/login_pages/login_page.dart';
import 'package:hamro_menu_getx/set_location_main_page.dart';
import 'package:hamro_menu_getx/pages/search_page_view.dart';
import 'package:hamro_menu_getx/splash_screen.dart';

import 'pages/restaurant_owner_page/restaurant_owner_homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: FirebaseOptions(
      apiKey: "AIzaSyDk_WBSZSgo2Q0IouLfSoDbZnkcWrpScK0",
      appId: "1:299525860236:android:dd73215bd46fdc6a2f84a9",
      messagingSenderId: "299525860236",
      projectId: "hamromenu",
    ),
  );

  runApp(ProviderScope(child: const MyApp()));
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
        '/': (context) => HomePage(),
        '/mapPage': (context) => MapPage(),
        '/searchPage': (context) => SearchPage(),
        '/favorite': (context) => FavouritePage(),
        '/gmap': (context) => GoogleMapFlutterPage(),
        '/animatedMap': (context) => AnimatedGoogleMap(),
      },
    );
  }
}
