import 'dart:math';
import 'package:flutter/material.dart';

class IndClassBox extends StatelessWidget {
  final Map<String, dynamic> indclass;
  const IndClassBox({
    super.key,
    required this.indclass,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey,
      ),
      child: ListTile(
        onTap: () {},
        contentPadding: const EdgeInsets.all(10),
        style: ListTileStyle.list,
        leading: CircleAvatar(
          child: Text(indclass["className"].toString().substring(0, 1)),
        ),
        subtitle: Text(indclass["className"]),
        title: Text(indclass["classLongName"]),
        trailing: CircleAvatar(
          radius: 15,
          backgroundColor: Colors.black,
          child: Text(
            indclass["schoolNotifications"]?.toString() ??
                Random().nextInt(5).toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
