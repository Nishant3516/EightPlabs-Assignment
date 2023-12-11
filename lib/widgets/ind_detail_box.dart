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
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color(0xFFD1A7FF),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(parameter,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(parameterValue, style: const TextStyle(fontSize: 16))
        ],
      ),
    );
  }
}
