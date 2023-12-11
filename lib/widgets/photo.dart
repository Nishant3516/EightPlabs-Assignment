import 'package:flutter/material.dart';

class PhotoCirlce extends StatelessWidget {
  const PhotoCirlce({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        CircleAvatar(radius: 50),
        Positioned(
          right: 0,
          bottom: 0,
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 15,
            child: Icon(
              Icons.camera_alt_outlined,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
