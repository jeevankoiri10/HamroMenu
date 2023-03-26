import 'dart:ui';

//import 'package:splashscreen/splashscreen.dart';

// File Import

// import 'package:pmc_app/screens/splash.dart';

// void main() {
//   runApp(const MyHomePage());
// }

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Pulchowk Music Club',
//       // theme: ThemeData.dark(),
//       theme: FlexThemeModeButtonOrder.light()
//       // ThemeData(
//       //   primaryColor: const Color(0xff222E50), // primary
//       //   bottomAppBarColor: const Color(0xff048BA8), // secondary
//       //   backgroundColor:
//       //       const Color(0xffEFF9F0), // Background color or Base color

//       //   colorScheme: ColorScheme(
//       //     primary: const Color(0xff222E50),
//       //     onPrimary: const Color(0xff222E50),
//       //     secondary: const Color(0xff048BA8),
//       //     onSecondary: const Color(0xff048BA8),
//       //     brightness: Brightness.light,
//       //     error: Colors.red,
//       //     onError: Colors.redAccent,
//       //     background: const Color(0xffEFF9F0), // base color
//       //     onBackground: const Color(0xffEFF9F0),
//       //     surface: const Color(0xffFEA82F),
//       //     onSurface: const Color(0xffFEA82F),
//       //   ),
//         // splashColor: const Color(0xff1e2952),
//       ),
//       home: HomeState(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hamro_menu_getx/pages/restaurant_owner_page/menu/upload_menu_restaurant.dart';
import 'package:hamro_menu_getx/pages/restaurant_owner_page/menu/test.dart';
import 'package:hamro_menu_getx/pages/restaurant_owner_page/menu/upload/upload_photo_menu_serially.dart';
import 'package:hamro_menu_getx/pages/restaurant_owner_page/user/user_ui.dart';

import '../login_pages/user_account_ui.dart';
import 'CRUD/restaurant_customer.dart';
import 'menu/product_page.dart';
import 'menu/uploaded_restaurant_owner_page.dart';

class RestaurantOwnerHomePage extends StatefulWidget {
  const RestaurantOwnerHomePage({super.key});

  @override
  State<RestaurantOwnerHomePage> createState() => _HomeState();
}

class _HomeState extends State<RestaurantOwnerHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.9,
        leading: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Image.asset('assets/icon/icon.png'),
        ),
        title: const Text(
          'Restaurant Owner',
          // style: TextStyle(
          //   color: const Color(0xff222E50),
          // ),
        ),
        // backgroundColor: Colors.white,
      ),
      // endDrawer: HomeDrawerBoutique(),
      body: getBody(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        //backgroundColor: Theme.of(context).primaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.stackOverflow),
            label: 'Items',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.moneyCheck),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.peopleGroup),
            label: 'Customers',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(FontAwesomeIcons.cartFlatbed),
          //   label: 'Ongoing Order',
          // ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.user),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Color.fromARGB(255, 34, 43, 34),
        //selectedItemColor: Color.fromARGB(255, 144, 172, 179),
        onTap: (int index) {
          setState(
            () {
              _selectedIndex = index;
            },
          );
        },
      ),
    );
  }

  Widget getBody(int index) {
    switch (index) {
      case 0:
        return RestaurantItemUploadPage();
      case 1:
        return FirestoreWidgetMenuUpload();
      //RestaurantUploadPage();
      case 2:
        return CustomerPage();
      // case 3:
      //   return FirestoreWidgetMenuUpload(); //TextListFirestoreWidget();
      case 3:
        return UserAccountUI();
    }
    return RestaurantUploadPage();
  }
}
