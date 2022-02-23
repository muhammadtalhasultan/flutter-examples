import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/models/user.dart' as model;
import 'package:tiktok_clone/screens/screens.dart';

class AuthServices extends GetxController {
  /// register a user
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late Rx<User?> _user;

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const SignIn());
    } else {
      Get.offAll(() => const NavScreen());
    }
  }

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  /// Uploads profile image to firebase storage and returns the download url.
  Future<String> _uploadToFirebaseStorage(File image) async {
    Reference reference =
        firebaseStorage.ref().child('profilePics').child(auth.currentUser!.uid);
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  void registerUser(
      {required String username,
      required String email,
      required String password,
      required File? image}) async {
    try {
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
        UserCredential userCredential = await auth
            .createUserWithEmailAndPassword(email: email, password: password);
        String downloadUrl = await _uploadToFirebaseStorage(image!);
        model.User user = model.User(
          email: email,
          imageUrl: downloadUrl,
          uid: userCredential.user!.uid,
          username: username,
        );
        await firebaseFirestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar(
          'Error creating account',
          'Provide all the informations!',
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error creating account',
        e.toString(),
      );
    }
  }

  void loginUser(String email, String password, BuildContext context) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        Get.snackbar('Error', 'Please enter your login and password');
      }
      Get.snackbar('Welcome', 'Welcome to your profile.');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } catch (e) {
      Get.snackbar('Login Error', e.toString());
    }
  }
}
