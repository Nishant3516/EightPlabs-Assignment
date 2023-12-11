import 'package:flutter/material.dart';

class PhotoCirlce extends StatelessWidget {
  final String firstSubstring;
  const PhotoCirlce({
    super.key,
    required this.firstSubstring,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: const Color(0xFFD1A7FF),
          child: Text(
            firstSubstring,
            style: const TextStyle(fontSize: 48),
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFD1A7FF),
              ),
              shape: BoxShape.circle,
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(
                Icons.camera_alt_outlined,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
