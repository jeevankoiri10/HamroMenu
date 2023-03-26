import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hamro_menu_getx/pages/login_pages/login_page.dart';
import 'package:hamro_menu_getx/pages/login_pages/login_ui.dart';
import 'package:hamro_menu_getx/pages/login_pages/restaurant_owner_list.dart';
import 'package:path_provider/path_provider.dart';

import '../customer_page/customer_homepage_view.dart';
import '../restaurant_owner_page/home_main_restaurant_owner.dart';

class RestaurantRegistrationPage extends StatefulWidget {
  @override
  _RestaurantRegistrationPageState createState() =>
      _RestaurantRegistrationPageState();
}

class _RestaurantRegistrationPageState
    extends State<RestaurantRegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/restaurant_registration.json');
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _saveData() async {
    final data = {
      'name': nameController.text,
      'address': addressController.text,
      'email': emailController.text,
    };
    final file = await _localFile;
    file.writeAsStringSync(json.encode(data));
  }

  void _loadData() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      final data = json.decode(contents);
      setState(() {
        nameController.text = data['name'] ?? '';
        addressController.text = data['address'] ?? '';
        emailController.text = data['email'] ?? '';
      });
    } catch (e) {
      // handle errors reading from the file
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Registration'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Restaurant Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a restaurant name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    labelText: 'Restaurant Address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a restaurant address';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Restaurant Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a restaurant email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        _saveData();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Data saved'),
                          ),
                        );
                      }

                      // new
                      RestaurantOwnersList.add(loggedInUserDetails!.email);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ((isLoggedin == true) &&
                                ( // loggedInUserDetails!.email.toLowerCase() ==
                                    RestaurantOwnersList.contains(
                                        loggedInUserDetails!.email
                                            .toLowerCase())))
                            ? RestaurantOwnerHomePage()
                            : CustomerHomePage(),
                      ));

                      // Navigator.push(context, route)
                    },
                    child: Text('Save Permanently'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
