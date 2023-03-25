import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hamro_menu_getx/pages/login_pages/login_ui.dart';
import 'package:hamro_menu_getx/pages/restaurant_owner_page/menu/upload/upload_details.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

TextEditingController controllerRestaurantName = TextEditingController();
TextEditingController controllerLocation = TextEditingController();
TextEditingController controllerPhoneNumber = TextEditingController();
TextEditingController ControllerMenuURL = TextEditingController();

String imageUrl = '';

class FirestoreWidgetMenuUpload extends StatefulWidget {
  @override
  _FirestoreWidgetMenuUploadState createState() =>
      _FirestoreWidgetMenuUploadState();
}

class _FirestoreWidgetMenuUploadState extends State<FirestoreWidgetMenuUpload> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            'Thakali Hotels',
            textScaleFactor: 1.3,
          ),
          Text('Baneshwor, Kathmandu'),
          SizedBox(height: 10),

          /// showing the list of images here of the menu

          SizedBox(
            height: 378,
            child: Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('myCollection')
                    .orderBy('timestamp', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final documents = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      final document = documents[index];
                      final text = document['text'] as String?;
                      final timestamp = document['timestamp'] as Timestamp?;

                      return ListTile(
                        title: Image.network(text ?? ''),
                        //subtitle: Text(timestamp?.toDate().toString() ?? ''),
                      );
                    },
                  );
                },
              ),
            ),
          ),

          ///
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => UploadMenuDetails())));
              },
              child: Text('Go to FULL Screen')),

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
                  // add to firestore
                  // final text = _textController.text;
                  if (imageUrl.isNotEmpty) {
                    FirebaseFirestore.instance.collection('myCollection').add({
                      'text': imageUrl,
                      'timestamp': FieldValue.serverTimestamp(),
                    });
                    _textController.clear();
                  }
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
                Reference referenceDirImages = referenceRoot.child('images');
                Reference referenceImageToUpload =
                    referenceDirImages.child(uniqueFileName);

                try {
                  // upload the file
                  await referenceImageToUpload.putFile(File(ourFile!.path));
                  // success: get the download URL
                  imageUrl = await referenceImageToUpload.getDownloadURL();
                  // add to the firestore
                  // final text = _textController.text;
                  if (imageUrl.isNotEmpty) {
                    FirebaseFirestore.instance.collection('myCollection').add({
                      'text': imageUrl,
                      'timestamp': FieldValue.serverTimestamp(),
                    });
                    _textController.clear();
                  }
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
            height: 05,
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

          ///
          // TextField(
          //   controller: _textController,
          //   decoration: InputDecoration(
          //     hintText: 'Enter text',
          //     border: OutlineInputBorder(),
          //   ),
          // ),
          // SizedBox(height: 16),
          // ElevatedButton(
          //   child: Text('Add to Firestore'),
          //   onPressed: () {
          //     // // final text = _textController.text;
          //     // if (imageUrl.isNotEmpty) {
          //     //   FirebaseFirestore.instance.collection('myCollection').add({
          //     //     'text': imageUrl,
          //     //     'timestamp': FieldValue.serverTimestamp(),
          //     //   });
          //     //   _textController.clear();
          //     // }
          //   },
          // ),
          // SizedBox(height: 16),
        ],
      ),
    );
  }
}
