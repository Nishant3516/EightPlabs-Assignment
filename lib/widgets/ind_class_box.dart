import 'dart:math';
import 'package:flutter/material.dart';

class IndClassBox extends StatelessWidget {
  final Map<String, dynamic> indclass;
  const IndClassBox({
    super.key,
    required this.indclass,
  });

  Color _getRandomPastelColor() {
    final List<Color> pastelColors = [
      const Color(0xFFB2CCFF),
      const Color(0xFFD1A7FF),
      const Color(0xFFFFC3A0),
      const Color(0xFFFFCB80),
      const Color(0xFFB2F7EF),
    ];
    return pastelColors[Random().nextInt(pastelColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    Color boxColor = _getRandomPastelColor();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: boxColor,
      ),
      child: ListTile(
          onTap: () {},
          contentPadding: const EdgeInsets.all(10),
          style: ListTileStyle.list,
          leading: CircleAvatar(
            backgroundColor: Colors.black,
            foregroundColor: boxColor,
            child: Text(
              indclass["className"].toString().substring(0, 1),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          subtitle: Text(indclass["className"]),
          title: Text(
            indclass["classLongName"],
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          trailing: Random().nextInt(5) != 0
              ? Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey[350]!),
                    color: Colors.white, // Fixed color for the main Container
                  ),
                  child: Center(
                    child: Text(
                      indclass["schoolNotifications"]?.toString() ??
                          Random().nextInt(5).toString(),
                      style: TextStyle(
                        color: boxColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                )
              : null),
    );
  }
}
