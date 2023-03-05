import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hamro_menu_getx/pages/login_pages/login_ui.dart';
import '../login_pages/login_page.dart';

class UserAccountUI extends StatefulWidget {
  const UserAccountUI({super.key});

  @override
  State<UserAccountUI> createState() => _UserAccountUIState();
}

class _UserAccountUIState extends State<UserAccountUI> {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Account Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 100,
                // minRadius: 100,
                // maxRadius: 200,
                child: Image.network(loggedInUserDetails!.photoUrl ??
                    "https://pluspng.com/img-png/png-user-icon-circled-user-icon-2240.png"),
              ),
              SizedBox(height: 20),
              Text(
                'Name: ${loggedInUserDetails!.displayName}',
                textScaleFactor: 2,
              ),
              SizedBox(height: 10),
              Text('Email: ${loggedInUserDetails!.email}'),
              SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () {
                    _googleSignIn.signOut();
                    isLoggedin = false;
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginUI()));
                  },
                  child: Text('Log Out')),
            ],
          ),
        ),
      ),
    );
  }
}
