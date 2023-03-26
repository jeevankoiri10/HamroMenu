import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hamro_menu_getx/pages/restaurant_owner_page/user/user_crud.dart';
import 'package:path/path.dart';

import '../menu/uploaded_restaurant_owner_page.dart';
// import 'package:kapaas/pages/boutique_owner/pages/controllers/crud_firebase/controller_CRUD_users.dart';

class RestaurantItemUploadPage extends StatefulWidget {
  RestaurantItemUploadPage({super.key});

  @override
  State<RestaurantItemUploadPage> createState() =>
      _RestaurantItemUploadPageState();
}

class _RestaurantItemUploadPageState extends State<RestaurantItemUploadPage> {
  TextEditingController _nameController = TextEditingController();

  TextEditingController _priceController = TextEditingController();

  TextEditingController editNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget buildItem(Items item) => ListTile(
          leading: CircleAvatar(child: Text('${item.price}')),
          title: Text(item.item),
          subtitle: Text('Created On: ${item.createdOn.toIso8601String()}'),
          // trailing: IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => UploadedRestaurantOwnerPage())));
          },
          isThreeLine: true,
        );
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Chiya Adda',
              textScaleFactor: 1.3,
            ),
            Text('Baneshwor, Kathmandu'),
            SizedBox(height: 10),
            TextField(
                controller: _nameController,
                // onChanged: ((value) {}),
                decoration: new InputDecoration(
                  labelText: "Enter Item",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                )),
            SizedBox(height: 10),
            TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                // onChanged: ((value) {}),
                decoration: new InputDecoration(
                  labelText: "Enter Price",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                )),
            ElevatedButton(
                onPressed: () async {
                  await createItem(
                    item: _nameController.text,
                    price: int.parse(_priceController.text),
                  );
                  print('${_nameController.text}');
                },
                child: Text('Upload')),
            Text('Items Enlisted are: '),
            SizedBox(
              height: 450,
              child: StreamBuilder<List<Items>>(
                stream: readItems(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong! ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final users = snapshot.data!;
                    return ListView(children: users.map(buildItem).toList());
                  } else {
                    return Center(child: LinearProgressIndicator());
                  }
                },
              ),

              // new where we cannot change the UI of the app using the flutter
              //
              //     FutureBuilder<List<User>>(
              //   future: readUsers().first,
              //   builder: ((context, snapshot) {
              //     if (snapshot.hasError) {
              //       return Text('Something went Wrong! ${snapshot.error}');
              //     } else if (snapshot.hasData) {
              //       final users = snapshot.data!;

              //       // change here
              //       return ListView(children: users.map(buildUser).toList());
              //     } else {
              //       return Center(child: LinearProgressIndicator());
              //     }
              //   }),
              // ),
//
              // to show a single user with the cerain id
              //     FutureBuilder<User?>(
              //   future: readUserOne(),
              //   builder: ((context, snapshot) {
              //     if (snapshot.hasError) {
              //       return Text('Something went Wrong! ${snapshot.error}');
              //     } else if (snapshot.hasData) {
              //       final user = snapshot.data!;

              //       // change here
              //       return user == null
              //           ? Center(
              //               child: Text('No user'),
              //             )
              //           : buildUser(
              //               user); //ListView(children: users.map(buildUser).toList());
              //     } else {
              //       return Center(child: CircularProgressIndicator());
              //     }
              //   }),
              // ),
              //
              //
            ),
            Divider(),
            TextFormField(
                controller: editNameController,
                // onChanged: ((value) {}),
                decoration: new InputDecoration(
                  labelText: "Enter Name to update",
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(),
                  ),
                )),
            ElevatedButton(
                onPressed: () {
                  // code for updating a particular user on the database
                  final docUser = FirebaseFirestore.instance
                      .collection('items')
                      .doc('my-id');

// one way to update the data
                  // docUser.update({
                  //   'name': editNameController.text,
                  // });
// to delete a field
                  // docUser.update({
                  //   'name': FieldValue.delete(),
                  // });

                  docUser.set({
                    'name': 'James',
                  });
                },
                child: Text('Update')),
            ElevatedButton(
                onPressed: () {
                  // code for updating a particular user on the database
                  final docUser = FirebaseFirestore.instance
                      .collection('items')
                      .doc('my-id');
                  docUser.delete();
                },
                child: Text('Delete a document')),
          ],
        ),
      ),
    );
  }
}
