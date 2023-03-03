import 'package:flutter/material.dart';
import 'package:hamro_menu_getx/pages/login_pages/signIn_google.dart';

class LogInPage extends StatelessWidget {
  bool isLoggedin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In Page'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 250, child: SignInWithGoogle()),
                TextFormField(
                  decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      border: UnderlineInputBorder(),
                      labelText: "Enter your Username"),
                  onChanged: (username) {
                    print(username);
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.key_outlined),
                      enabled: true,
                      border: UnderlineInputBorder(),
                      labelText: "Enter your Password"),
                  onChanged: (password) {
                    print(password);
                  },
                ),
                MaterialButton(
                  onPressed: () {
                    if (isLoggedin) {
                      Navigator.pushNamed(context, '/');
                    } else {
                      print('Unable to login. Enter correct password');
                    }
                  },
                  child: Text("Log In"),
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
