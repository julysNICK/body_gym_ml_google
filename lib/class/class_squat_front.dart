import 'dart:math';

import 'package:body_gym/class/exercise.dart';
import 'package:body_gym/class/repetition_calculation_squart.dart';

class SquatExerciseFront implements Exercise {
  SquatExerciseFront();

  RepetitionCalculationSquatFront repetitionCalculation =
      RepetitionCalculationSquatFront();

  @override
  int calculationRepetition(double angle) {
    // print('angle: $angle');
    return repetitionCalculation.calculationRepetition(angle.roundToDouble());
  }

  @override
  Exercise createExercise() {
    return SquatExerciseFront();
  }
}
