import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_menu_getx/animated_google_map_page.dart';
import 'package:hamro_menu_getx/pages/favourite_page.dart';
import 'package:hamro_menu_getx/pages/restaurant_owner_page/home_main_restaurant_owner.dart';
import 'package:hamro_menu_getx/pages/customer_page/set_location_page/set_location_google_map_page.dart';
import 'package:hamro_menu_getx/pages/customer_page/customer_homepage_view.dart';
import 'package:hamro_menu_getx/pages/login_pages/login_page.dart';
import 'package:hamro_menu_getx/set_location_main_page.dart';
import 'package:hamro_menu_getx/pages/search_page_view.dart';
import 'package:hamro_menu_getx/splash_screen.dart';
import 'pages/restaurant_owner_page/menu/upload_menu_restaurant.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.length == 0) {
    await Firebase.initializeApp(
      // Replace with actual values
      options: FirebaseOptions(
        apiKey: "AIzaSyDk_WBSZSgo2Q0IouLfSoDbZnkcWrpScK0",
        appId: "1:299525860236:android:dd73215bd46fdc6a2f84a9",
        messagingSenderId: "299525860236",
        projectId: "hamromenu",
        storageBucket: 'gs://hamromenu.appspot.com',
      ),
    );
  }

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
      theme: FlexThemeData.light(scheme: FlexScheme.blue),
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LogInPage(),
        '/': (context) => CustomerHomePage(), //HomePage(),
        '/restaurant': (context) => RestaurantOwnerHomePage(),
        '/mapPage': (context) => MapPage(),
        '/searchPage': (context) => SearchPage(),
        '/favorite': (context) => FavouritePage(),
        '/animatedMap': (context) => AnimatedGoogleMap(),
      },
    );
  }
}
