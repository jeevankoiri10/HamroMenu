import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hamro_menu_getx/homepage_view.dart';
import 'package:hamro_menu_getx/pages/login_pages/login_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantOwnerPage extends StatefulWidget {
  RestaurantOwnerPage({super.key});

  @override
  State<RestaurantOwnerPage> createState() => _RestaurantOwnerPageState();
}

class _RestaurantOwnerPageState extends State<RestaurantOwnerPage> {
  TextEditingController _controllerRestaurant = TextEditingController();
  TextEditingController _controllerSubtitle = TextEditingController();
  TextEditingController _controllerPhoneNumber = TextEditingController();

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants Owner Page'),
        automaticallyImplyLeading: false,
        leading: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => LogInPage(),
            ));
          },
          child: Icon(Icons.account_box),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Enter details of your Restaurant',
                textScaleFactor: 1.5,
              ),
              TextFormField(
                controller: _controllerRestaurant,
                decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    border: UnderlineInputBorder(),
                    labelText: "Enter your Restaurant Name "),
                onChanged: (username) {
                  print(username);
                },
              ),
              TextFormField(
                controller: _controllerSubtitle,
                decoration: const InputDecoration(
                    icon: Icon(Icons.subtitles),
                    enabled: true,
                    border: UnderlineInputBorder(),
                    labelText: "Enter Address"),
                onChanged: (password) {
                  print(password);
                },
              ),
              TextFormField(
                controller: _controllerPhoneNumber,
                decoration: const InputDecoration(
                    icon: Icon(Icons.phone),
                    enabled: true,
                    border: UnderlineInputBorder(),
                    labelText: "Enter phone number "),
                onChanged: (password) {
                  print(password);
                },
              ),
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
                      await referenceImageToUpload.putFile(File(ourFile!.path));
                      // success: get the download URL
                      imageUrl = await referenceImageToUpload.getDownloadURL();
                      setState(() {});
                    } catch (err) {
                      debugPrint(err.toString());
                    }
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
                      await referenceImageToUpload.putFile(File(ourFile!.path));
                      // success: get the download URL
                      imageUrl = await referenceImageToUpload.getDownloadURL();
                      setState(() {});
                    } catch (err) {
                      debugPrint(err.toString());
                    }
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
              SizedBox(
                height: 40,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    // create a map with the input data
                    Map<String, dynamic> dataToSave = {
                      'name': _controllerRestaurant.text.toString(),
                      'subtitle': _controllerSubtitle.text.toString(),
                      'phone': _controllerPhoneNumber.text.toString(),
                    };
                    // add the data to the database by making a collection restaurant details
                    FirebaseFirestore.instance
                        .collection('restaurant_details')
                        .add(dataToSave);
                  },
                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
