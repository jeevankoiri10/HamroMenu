import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hamro_menu_getx/pages/customer_page/customer_homepage_view.dart';
import 'package:hamro_menu_getx/pages/login_pages/login_Restaurant_name_fillup.dart';
import 'package:hamro_menu_getx/pages/login_pages/login_page.dart';
import 'package:hamro_menu_getx/pages/login_pages/restaurant_owner_list.dart';

import '../restaurant_owner_page/home_main_restaurant_owner.dart';
import '../restaurant_owner_page/menu/upload_menu_restaurant.dart';

GoogleSignInAccount? loggedInUserDetails;
GoogleSignIn _googleSignIn = GoogleSignIn();

class LoginUI extends StatefulWidget {
  LoginUI({super.key});

  @override
  State<LoginUI> createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Log In Page'),
      //   automaticallyImplyLeading: false,
      // ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icon/icon.png'),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50.0, 5, 50.0, 5),
                child: MaterialButton(
                    minWidth: double.maxFinite - 10,
                    color: Colors.blue,
                    elevation: 10,
                    onPressed: () {
                      _googleSignIn.signOut();
                      isLoggedin = true;
                      _googleSignIn.signIn().then((value) {
                        loggedInUserDetails = value;

                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ((isLoggedin == true) &&
                                  ( // loggedInUserDetails!.email.toLowerCase() ==
                                      RestaurantOwnersList.contains(
                                          loggedInUserDetails!.email
                                              .toLowerCase())))
                              ? RestaurantOwnerHomePage()
                              : CustomerHomePage(),
                        ));
                      });
                    },
                    child: Text('Log In as Customer')),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50.0, 5, 50.0, 5),
                child: MaterialButton(
                    minWidth: double.maxFinite - 10,
                    color: Colors.blue,
                    elevation: 10,
                    onPressed: () {
                      _googleSignIn.signOut();
                      isLoggedin = true;
                      _googleSignIn.signIn().then((value) {
                        loggedInUserDetails = value;
                        // RestaurantOwnersList.add(loggedInUserDetails!.email);
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => ((isLoggedin == true) &&
                        //           ( // loggedInUserDetails!.email.toLowerCase() ==
                        //               RestaurantOwnersList.contains(
                        //                   loggedInUserDetails!.email
                        //                       .toLowerCase())))
                        //       ? RestaurantOwnerHomePage()
                        //       : CustomerHomePage(),
                        // ));

                        // new login
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RestaurantRegistrationPage()));
                      });
                    },
                    child: Text('Log in as restaurant owner')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
