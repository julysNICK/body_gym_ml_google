import 'package:body_gym/class/arm_flexion_repetition_calculation.dart';
import 'package:body_gym/class/exercise.dart';

class ArmFlexionExercise implements Exercise {
  ArmFlexionExercise();

  RepetitionCalculationArmFlexion repetitionCalculation =
      RepetitionCalculationArmFlexion();

  @override
  int calculationRepetition(double angle) {
    // print('angle: $angle');
    return repetitionCalculation.calculationRepetition(angle.roundToDouble());
  }

  @override
  Exercise createExercise() {
    return ArmFlexionExercise();
  }
}
