import 'dart:io';
import 'package:get/get.dart';
import 'package:tiktok_clone/services/video_services.dart';
import 'package:tiktok_clone/widgets/widgets.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class ConfirmScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;
  const ConfirmScreen(
      {Key? key, required this.videoFile, required this.videoPath})
      : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController _controller;
  final TextEditingController _songNameController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();
  UploadVideoController videoUploadController =
      Get.put(UploadVideoController());
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _controller = VideoPlayerController.file(widget.videoFile);
    });
    _controller.initialize();
    // _controller.play();
    // _controller.setVolume(1);
    // _controller.setLooping(true);
  }

  uploadVideo() {
    setState(() {
      _isLoading = true;
    });
    videoUploadController.uploadVideo(
        _songNameController.text, _captionController.text, widget.videoPath);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    videoUploadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: VideoPlayer(_controller),
            ),
            Positioned(
              bottom: 40,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    TextInput(
                      controller: _songNameController,
                      labelText: 'Song Name',
                      prefixIcon: const Icon(Icons.music_note),
                    ),
                    const SizedBox(height: 5),
                    TextInput(
                      controller: _captionController,
                      labelText: 'Caption',
                      prefixIcon: const Icon(Icons.closed_caption),
                    ),
                    const SizedBox(height: 10),
                    _isLoading
                        ? const LinearProgressIndicator(
                            color: Colors.red,
                          )
                        : Container(),
                    InkWell(
                        onTap: () => {uploadVideo()},
                        child: _isLoading == true
                            ? const CircularProgressIndicator(
                                color: Colors.blue,
                              )
                            : const SubmitButton(
                                text: 'Share',
                                color: Colors.blue,
                              )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
