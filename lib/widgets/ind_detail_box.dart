import 'package:flutter/material.dart';

class IndDetailBox extends StatelessWidget {
  final String parameter;
  final String parameterValue;
  const IndDetailBox({
    super.key,
    required this.parameter,
    required this.parameterValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[350],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(parameter,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(parameterValue, style: const TextStyle(fontSize: 16))
          ],
        ));
  }
}
