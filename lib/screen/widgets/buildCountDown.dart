import 'package:flutter/material.dart';

Widget buildCountDown(int counter) {
  return Container(
    margin: const EdgeInsets.only(top: 0.0, left: 10.0, right: 0.0),
    child: Column(
      children: [
        Text(
          "🔥🔥Começando em: $counter🔥🔥",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,
          ),
        ),
      ],
    ),
  );
}
