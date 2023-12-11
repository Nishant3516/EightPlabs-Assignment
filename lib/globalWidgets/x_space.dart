import 'package:flutter/material.dart';

class XSpace extends StatelessWidget {
  final double width;
  const XSpace({
    super.key,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
