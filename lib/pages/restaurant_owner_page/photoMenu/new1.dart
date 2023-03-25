import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploader extends StatefulWidget {
  final Function(List<String>) onImagesUploaded;

  ImageUploader({required this.onImagesUploaded});

  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  List<String> _imageUrls = [];

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _uploadImage(File(pickedFile.path));
      });
    }
  }

  Future<void> _uploadImage(File file) async {
    // Get a reference to the storage service
    final storage = FirebaseStorage.instance;

    // Create a reference to the location where we will upload the file
    final reference =
        storage.ref().child('images/${DateTime.now().toIso8601String()}');

    // Upload the file to Firebase Storage
    final uploadTask = reference.putFile(file);

    // Get the download URL of the uploaded file
    final downloadUrl = await (await uploadTask).ref.getDownloadURL();

    setState(() {
      _imageUrls.add(downloadUrl);
      widget.onImagesUploaded(_imageUrls);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _pickImage(ImageSource.camera),
          child: Text('Take Photo'),
        ),
        ElevatedButton(
          onPressed: () => _pickImage(ImageSource.gallery),
          child: Text('Choose Photo'),
        ),
      ],
    );
  }
}
