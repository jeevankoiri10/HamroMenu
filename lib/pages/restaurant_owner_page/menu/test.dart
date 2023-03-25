import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hamro_menu_getx/pages/login_pages/login_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'uploaded_restaurant_owner_page.dart';

TextEditingController controllerRestaurantName = TextEditingController();
TextEditingController controllerLocation = TextEditingController();
TextEditingController controllerPhoneNumber = TextEditingController();
TextEditingController ControllerMenuURL = TextEditingController();

String imageUrl = '';

class TextListFirestoreWidget extends StatefulWidget {
  @override
  _TextListFirestoreWidgetState createState() =>
      _TextListFirestoreWidgetState();
}

class _TextListFirestoreWidgetState extends State<TextListFirestoreWidget> {
  final TextEditingController _textEditingController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Text List Firestore Widget'),
      // ),
      body: Column(
        children: [
          Text(
            'Thakali Hotels',
            textScaleFactor: 1.3,
          ),
          Text('Baneshwor, Kathmandu'),
          SizedBox(height: 10),
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
                Reference referenceDirImages = referenceRoot.child('images');
                Reference referenceImageToUpload =
                    referenceDirImages.child(uniqueFileName);

                try {
                  // upload the file
                  await referenceImageToUpload.putFile(File(ourFile!.path));
                  // success: get the download URL
                  imageUrl = await referenceImageToUpload.getDownloadURL();
                  // upload to the textList file on firestore
                  final text = imageUrl;

                  if (text.isEmpty) {
                    return;
                  }

                  await _firestore.collection('textList').add({
                    'text': text,
                  });

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
                Reference referenceDirImages = referenceRoot.child('images');
                Reference referenceImageToUpload =
                    referenceDirImages.child(uniqueFileName);

                try {
                  // upload the file
                  await referenceImageToUpload.putFile(File(ourFile!.path));
                  // success: get the download URL
                  imageUrl = await referenceImageToUpload.getDownloadURL();
                  // upload to the textList file on firestore
                  final text = imageUrl;

                  if (text.isEmpty) {
                    return;
                  }

                  await _firestore.collection('textList').add({
                    'text': text,
                  });

                  // _textEditingController.clear();
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
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('textList').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                final documents = snapshot.data!.docs;
                // displaying the text on the screen
                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final document = documents[index];
                    final text = (document.data()
                        as Map<String, dynamic>)['text'] as String;
                    return ListTile(
                      // title: Text(text),
                      title: Image.network(text),
                    );
                  },
                );
              },
            ),
          ),
          // input the text to display here below
          TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              hintText: 'Enter text...',
              suffixIcon: IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  // final text = _textEditingController.text.trim();
                  // final text = imageUrl;

                  // if (text.isEmpty) {
                  //   return;
                  // }

                  // await _firestore.collection('textList').add({
                  //   'text': text,
                  // });

                  // _textEditingController.clear();
                },
              ),
            ),
          ),
        ],
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

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
