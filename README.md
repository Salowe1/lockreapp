<<<<<<< HEAD
# lockre

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null;
    }
  }
}




-----photocnib.dart-----
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lockre/constants/colors.dart';
import 'package:lockre/screens/auth/signup/password.dart';

class PhotoCnib extends StatefulWidget {
  @override
  _PhotoCnibState createState() => _PhotoCnibState();
}

class _PhotoCnibState extends State<PhotoCnib> {
  final TextEditingController _idNumberController = TextEditingController();
  File? _frontImage;
  File? _backImage;
  final ImagePicker _picker = ImagePicker();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> _pickImage(ImageSource source, bool isFront) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        if (isFront) {
          _frontImage = File(pickedFile.path);
        } else {
          _backImage = File(pickedFile.path);
        }
      }
    });
  }

  Future<void> _submitDetails() async {
    User? user = _auth.currentUser;
    if (user != null && _frontImage != null && _backImage != null) {
      String userId = user.uid;
      
      String frontImageUrl = await _uploadFile(_frontImage!, '$userId/front_image.jpg');
      String backImageUrl = await _uploadFile(_backImage!, '$userId/back_image.jpg');

      await _firestore.collection('users').doc(userId).update({
        'idNumber': _idNumberController.text,
        'frontImageUrl': frontImageUrl,
        'backImageUrl': backImageUrl,
      });

      Get.offAll(() => PasswordPage());
    }
  }

  Future<String> _uploadFile(File file, String path) async {
    UploadTask uploadTask = _storage.ref().child(path).putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: AppColors.primaryColor),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Image.asset('assets/logo/lockre.png', height: 200),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _idNumberController,
                decoration: _inputDecoration('Numéro de la carte d\'identité'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.gallery, true),
                child: Text(_frontImage == null ? 'Télécharger la face avant' : 'Modifier la face avant'),
              ),
              if (_frontImage != null) Image.file(_frontImage!, height: 150),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.gallery, false),
                child: Text(_backImage == null ? 'Télécharger la face arrière' : 'Modifier la face arrière'),
              ),
              if (_backImage != null) Image.file(_backImage!, height: 150),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitDetails,
                  child: const Text(
                    'Suivant',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
# lockre
=======
>>>>>>> main
# lockre
# lockreapp
