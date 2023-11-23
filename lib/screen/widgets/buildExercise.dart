import 'package:flutter/material.dart';

Widget buidExercice(int count) {
  return Container(
    child: Column(
      children: [
        Text(
          "Repetition: $count",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 50.0,
          ),
        ),
      ],
    ),
  );
}
