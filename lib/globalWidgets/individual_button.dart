import 'package:flutter/material.dart';

class IndividualButton extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final String buttonText;
  final Widget? buttonWidget;
  final void Function() buttonFunction;
  const IndividualButton({
    super.key,
    required this.buttonText,
    required this.buttonFunction,
    this.buttonWidget,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        side: BorderSide(color: borderColor, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        minimumSize: const Size(double.infinity, 55),
      ),
      onPressed: buttonFunction,
      child: buttonWidget ??
          Text(
            buttonText,
            style: TextStyle(
                color: (backgroundColor == Colors.black)
                    ? Colors.white
                    : Colors.black),
          ),
    );
  }
}
