import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hamro_menu_getx/pages/customer_page/customer_homepage_view.dart';
import 'package:hamro_menu_getx/pages/login_pages/login_page.dart';
import 'package:hamro_menu_getx/pages/restaurant_owner_page/CRUD/crud_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../login_pages/login_ui.dart';
import 'uploaded_restaurant_owner_page.dart';

TextEditingController controllerRestaurantName = TextEditingController();
TextEditingController controllerLocation = TextEditingController();
TextEditingController controllerPhoneNumber = TextEditingController();
TextEditingController ControllerMenuURL = TextEditingController();

String imageUrl = '';

class RestaurantUploadPage extends StatefulWidget {
  RestaurantUploadPage({super.key});

  @override
  State<RestaurantUploadPage> createState() => _RestaurantUploadPageState();
}

class _RestaurantUploadPageState extends State<RestaurantUploadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Restaurants Owner Page'),
      //   automaticallyImplyLeading: false,
      //   leading: ElevatedButton(
      //     onPressed: () {
      //       Navigator.of(context).push(MaterialPageRoute(
      //         builder: (context) => LogInPage(),
      //       ));
      //     },
      //     child: Icon(Icons.account_box),
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text(
                  'Thakali Hotels',
                  textScaleFactor: 1.3,
                ),
                Text('Baneshwor, Kathmandu'),
                SizedBox(height: 10),
                // Text(
                //   'Enter details of your Restaurant',
                //   textScaleFactor: 1.5,
                // ),
                // TextFormField(
                //   controller: controllerRestaurantName,
                //   decoration: const InputDecoration(
                //       icon: Icon(Icons.person),
                //       border: UnderlineInputBorder(),
                //       labelText: "Enter your Restaurant Name "),
                //   onChanged: (username) {
                //     print(username);
                //   },
                // ),
                // TextFormField(
                //   controller: controllerLocation,
                //   decoration: const InputDecoration(
                //       icon: Icon(Icons.subtitles),
                //       enabled: true,
                //       border: UnderlineInputBorder(),
                //       labelText: "Enter Address"),
                //   onChanged: (password) {
                //     print(password);
                //   },
                // ),
                // TextFormField(
                //   controller: controllerPhoneNumber,
                //   decoration: const InputDecoration(
                //       icon: Icon(Icons.phone),
                //       enabled: true,
                //       border: UnderlineInputBorder(),
                //       labelText: "Enter phone number "),
                //   onChanged: (password) {
                //     print(password);
                //   },
                // ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.network(imageUrl == ''
                      ? 'https://th.bing.com/th/id/R.712037bab8634a63b94c4cd1d22dc141?rik=3lotRj1zGK%2b0ag&riu=http%3a%2f%2fwww.pngall.com%2fwp-content%2fuploads%2f2%2fUpload-Transparent.png&ehk=1NW1RvOIMnDL%2bneLkwtLBWcJFFxE3uETUzRpfFe7RyA%3d&risl=&pid=ImgRaw&r=0'
                      : imageUrl),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                      /*
                      1. Pick/capture an image (image_picker)
                      2. Upload the image to firebase sotorage
                      3. Get the url of the uploaded image
                      4. Store the image url inside the corresponding
                      document of the database.
                      5. Display the image on the list.
                      */
                      // pick image
                      //
                      ImagePicker imagePicker = ImagePicker();
                      XFile? ourFile = await imagePicker.pickImage(
                          source: ImageSource.camera,
                          preferredCameraDevice: CameraDevice.rear);
                      print('${ourFile?.path}');
                      //if (ourFile == null) return;

                      // get the unique file name
                      String uniqueFileName =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      // firebase_storage
                      // get a reference to storage root
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      // to create a directory in firebase
                      Reference referenceDirImages =
                          referenceRoot.child('images');
                      Reference referenceImageToUpload =
                          referenceDirImages.child(uniqueFileName);

                      try {
                        // upload the file
                        await referenceImageToUpload
                            .putFile(File(ourFile!.path));
                        // success: get the download URL
                        imageUrl =
                            await referenceImageToUpload.getDownloadURL();
                        setState(() {});
                      } catch (err) {
                        debugPrint(err.toString());
                      }
                      final menu = ControllerMenuURL.text;
                      createUser(url: imageUrl);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.photo_camera),
                        Text('  Uplaoad Menu by Camera'),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 40,
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () async {
                      /*
                      1. Pick/capture an image (image_picker)
                      2. Upload the image to firebase sotorage
                      3. Get the url of the uploaded image
                      4. Store the image url inside the corresponding
                      document of the database.
                      5. Display the image on the list.
                      */
                      // pick image
                      //
                      ImagePicker imagePicker = ImagePicker();
                      XFile? ourFile = await imagePicker.pickImage(
                          source: ImageSource.gallery,
                          preferredCameraDevice: CameraDevice.rear);
                      print('${ourFile?.path}');
                      //if (ourFile == null) return;

                      // get the unique file name
                      String uniqueFileName =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      // firebase_storage
                      // get a reference to storage root
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      // to create a directory in firebase
                      Reference referenceDirImages =
                          referenceRoot.child('images');
                      Reference referenceImageToUpload =
                          referenceDirImages.child(uniqueFileName);

                      try {
                        // upload the file
                        await referenceImageToUpload
                            .putFile(File(ourFile!.path));
                        // success: get the download URL
                        imageUrl =
                            await referenceImageToUpload.getDownloadURL();
                        setState(() {});
                      } catch (err) {
                        debugPrint(err.toString());
                      }

                      final menu = ControllerMenuURL.text;
                      createUser(url: imageUrl);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.photo_album),
                        Text('  Uplaoad Menu by Gallery'),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                // submit button
                // SizedBox(
                //   height: 40,
                //   width: 300,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       // create a map with the input data
                //       Map<String, dynamic> dataToSave = {
                //         'name': controllerRestaurantName.text.toString(),
                //         'subtitle': controllerLocation.text.toString(),
                //         'phone': controllerPhoneNumber.text.toString(),
                //       };
                //       // add the data to the database by making a collection restaurant details
                //       FirebaseFirestore.instance
                //           .collection('restaurant_details')
                //           .add(dataToSave);
                //     },
                //     child: Text("Submit"),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future createUser({required String url}) async {
    // reference to document
    final docUser =
        FirebaseFirestore.instance.collection('menuLinksRestaurant').doc();

    final json = {
      'id': docUser.id,
      'email': loggedInUserDetails!.email,
      'name': 'Thakali Restaurant',
      'address': 'Baneshwor, kathmandu',
      'link': url.toString(),
    };

    // create document and write data to the firestore
    await docUser.set(json);
  }

  // // for the object
  // Future createUser({required String url}) async {
  //   // reference to document
  //   final docUser =
  //       FirebaseFirestore.instance.collection('restaurants').doc('restaurant1');

  //   final restaurant = Restaurant(
  //       id: docUser.id,
  //       name: controllerRestaurantName.text,
  //       location: controllerLocation.text,
  //       items: ['items1', 'items2'],
  //       URL: imageUrl,
  //       orderedBy: ['Kailash', 'Tribhuwan'],
  //       orders: {'Kailash': 1});

  //   // convert to json
  //   final json = restaurant.toFirestore();
  //   // create document and write data to the firestore
  //   await docUser.set(json);
  // }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class RestaurantOwnerPage extends StatefulWidget {
//   const RestaurantOwnerPage({super.key});

//   @override
//   State<RestaurantOwnerPage> createState() => _RestaurantOwnerPageState();
// }

// class _RestaurantOwnerPageState extends State<RestaurantOwnerPage> {
//   @override
//   TextEditingController _menuController = TextEditingController();
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Hamro Menu: RESTAURANT')),
//       body: SafeArea(
//         child: Column(
//           children: [
//             TextFormField(
//               controller: _menuController,
//               decoration: const InputDecoration(
//                   icon: Icon(Icons.phone),
//                   enabled: true,
//                   border: UnderlineInputBorder(),
//                   labelText: "Enter Menu"),
//               onChanged: (password) {
//                 print(password);
//               },
//             ),
//             ElevatedButton(
//                 onPressed: () {
//                   final menu = _menuController.text;
//                   createUser(name: menu);
//                 },
//                 child: Text('Upload Menu')),
//           ],
//         ),
//       ),
//     );
//   }

//   Future createUser({required String name}) async {
//     // reference to document
//     final docUser =
//         FirebaseFirestore.instance.collection('menuLinks').doc('my-id');

//     final json = {
//       'link': name.toString(),
//     };

//     // create document and write data to the firestore
//     await docUser.set(json);
//   }
// }
