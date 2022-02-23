import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;
File profilePhoto = File('');
pickImage(ImageSource source) async {
  final pickedImage = await ImagePicker().pickImage(source: source);
  if (pickedImage != null) {
    Get.snackbar('Profile Picture', 'Selected');
  }
  profilePhoto = File(pickedImage!.path);
  return profilePhoto;
}
