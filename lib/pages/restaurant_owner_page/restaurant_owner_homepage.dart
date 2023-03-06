import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hamro_menu_getx/pages/login_pages/login_page.dart';

class RestaurantOwnerPage extends StatelessWidget {
  const RestaurantOwnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants Owner Page'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Enter details of your Restaurant',
              textScaleFactor: 1.5,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  border: UnderlineInputBorder(),
                  labelText: "Enter your Restaurant Name "),
              onChanged: (username) {
                print(username);
              },
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                  icon: Icon(Icons.subtitles),
                  enabled: true,
                  border: UnderlineInputBorder(),
                  labelText: "Enter Restaurant Subtitle"),
              onChanged: (password) {
                print(password);
              },
            ),
            TextFormField(
              obscureText: true,
              decoration: const InputDecoration(
                  icon: Icon(Icons.phone),
                  enabled: true,
                  border: UnderlineInputBorder(),
                  labelText: "Enter phone number "),
              onChanged: (password) {
                print(password);
              },
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Add Details"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LogInPage(),
                ));
              },
              child: Text('Go to User Account Page'),
            ),
          ],
        ),
      ),
    );
  }
}
