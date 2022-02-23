import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String imageSrc;
  const Avatar({Key? key, required this.imageSrc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(imageSrc),
          radius: 30,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: const Icon(
                Icons.add_a_photo_outlined,
                size: 15,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
