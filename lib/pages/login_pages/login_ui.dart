import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hamro_menu_getx/homepage_view.dart';
import 'package:hamro_menu_getx/pages/login_pages/login_page.dart';

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
      appBar: AppBar(
        title: Text('Log In Page'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    _googleSignIn.signOut();
                    isLoggedin = true;
                    _googleSignIn.signIn().then((value) {
                      loggedInUserDetails = value;

                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    });
                  },
                  child: Text('Log In with Google')),
            ],
          ),
        ),
      ),
    );
  }
}
