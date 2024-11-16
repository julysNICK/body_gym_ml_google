import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

Widget buildArrayTextExercise(
  String typeExercise,
) {
  List<String> phrasesAboutExercise = [
    "Faça o exercicio de forma lenta e controlada",
    "Mantenha a postura",
    "Não faça movimentos bruscos",
  ];

  var styleTextIn = const TextStyle(
    color: Colors.white,
    fontSize: 20.0,
  );

  return AnimatedContainer(
    duration: const Duration(seconds: 2),
    child: Column(
      children: [
        AnimatedTextKit(animatedTexts: [
          FadeAnimatedText(
            "Exercicio: $typeExercise",
            textStyle: styleTextIn,
          ),
          FadeAnimatedText(
            "Faça o exercicio de forma lenta e controlada",
            textStyle: styleTextIn,
          ),
          FadeAnimatedText(
            "Mantenha a postura",
            textStyle: styleTextIn,
          ),
          FadeAnimatedText(
            "Não faça movimentos bruscos",
            textStyle: styleTextIn,
          ),
        ])
      ],
    ),
  );
}
