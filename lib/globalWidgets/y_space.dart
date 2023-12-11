import 'package:flutter/material.dart';

class YSpace extends StatelessWidget {
  final double height;
  const YSpace({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}
