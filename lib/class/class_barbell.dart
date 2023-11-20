import 'dart:math';

import 'package:body_gym/class/exercise.dart';
import 'package:body_gym/class/repetition_calculation.dart';
import 'package:body_gym/class/repetition_calculation_front.dart';

class BarbellExercise implements Exercise {
  BarbellExercise();

  RepetitionCalculationBarbelSide repetitionCalculation =
      RepetitionCalculationBarbelSide();

  @override
  int calculationRepetition(double angle) {
    // print('angle: $angle');
    return repetitionCalculation.calculationRepetition(angle);
  }

  @override
  Exercise createExercise() {
    return BarbellExercise();
  }
}
