import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/screens/confirm_screen.dart';

class AddVideo extends StatelessWidget {
  const AddVideo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    pickVideo(ImageSource source) async {
      final video = await ImagePicker().pickVideo(source: source);
      if (video != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ConfirmScreen(
                videoFile: File(video.path), videoPath: video.path),
          ),
        );
      }
    }

    showOptionsDialog(BuildContext context) {
      return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          title: const Text('Add Video'),
          children: [
            SimpleDialogOption(
              onPressed: () => {pickVideo(ImageSource.gallery)},
              child: Row(
                children: const [
                  Icon(Icons.photo),
                  SizedBox(width: 15),
                  Text('Add from gallery'),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () => {pickVideo(ImageSource.camera)},
              child: Row(
                children: const [
                  Icon(Icons.camera_alt_outlined),
                  SizedBox(width: 15),
                  Text('Add from camera'),
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Row(
                children: const [
                  Icon(Icons.cancel_outlined),
                  SizedBox(width: 15),
                  Text('Cancel'),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.blue,
          child: TextButton.icon(
            onPressed: () => {showOptionsDialog(context)},
            icon: const Icon(
              Icons.add_to_photos_outlined,
              color: Colors.white,
            ),
            label: const Text(
              'Add Video',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
