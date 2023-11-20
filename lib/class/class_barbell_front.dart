import 'dart:math';

import 'package:body_gym/class/exercise.dart';
import 'package:body_gym/class/repetition_calculation.dart';
import 'package:body_gym/class/repetition_calculation_front.dart';

class BarbellExerciseFront implements Exercise {
  BarbellExerciseFront();

  RepetitionCalculationBarbelFront repetitionCalculation =
      RepetitionCalculationBarbelFront();

  @override
  int calculationRepetition(double angle) {
    print('angle front: $angle');
    return repetitionCalculation.calculationRepetition(angle);
  }

  @override
  Exercise createExercise() {
    return BarbellExerciseFront();
  }
}
