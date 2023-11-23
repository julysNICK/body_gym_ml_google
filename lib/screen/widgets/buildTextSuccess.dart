import 'package:flutter/material.dart';

Widget buildTextSucess() {
  return Container(
    margin: const EdgeInsets.only(top: 0.0, left: 20.0, right: 0.0),
    child: const Column(
      children: [
        Text(
          "💪💪Parabéns, você concluiu o exercício!💪💪",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
          ),
        ),
      ],
    ),
  );
}
