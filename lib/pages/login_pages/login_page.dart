import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hamro_menu_getx/pages/login_pages/login_ui.dart';
import 'package:hamro_menu_getx/pages/login_pages/user_account_ui.dart';

bool isLoggedin = false;

class LogInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Log In Page'),
      //   automaticallyImplyLeading: false,
      // ),
      body: isLoggedin ? UserAccountUI() : LoginUI(),
      // Center(
      //   child: Padding(
      //     padding: const EdgeInsets.all(15.0),
      //     child: SingleChildScrollView(
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: <Widget>[
      //           TextFormField(
      //             decoration: const InputDecoration(
      //                 icon: Icon(Icons.person),
      //                 border: UnderlineInputBorder(),
      //                 labelText: "Enter your Username"),
      //             onChanged: (username) {
      //               print(username);
      //             },
      //           ),
      //           TextFormField(
      //             obscureText: true,
      //             decoration: const InputDecoration(
      //                 icon: Icon(Icons.key_outlined),
      //                 enabled: true,
      //                 border: UnderlineInputBorder(),
      //                 labelText: "Enter your Password"),
      //             onChanged: (password) {
      //               print(password);
      //             },
      //           ),
      //           MaterialButton(
      //             onPressed: () {
      //               if (isLoggedin) {
      //                 Navigator.pushNamed(context, '/');
      //               } else {
      //                 print('Unable to login. Enter correct password');
      //               }
      //             },
      //             child: Text("Log In"),
      //             color: Colors.blue,
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
