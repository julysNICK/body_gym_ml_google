import 'package:body_gym/class/calculate_angle.dart';
import 'package:body_gym/class/calculate_distance_point.dart';
import 'package:body_gym/class/class_arm_flexion.dart';
import 'package:body_gym/class/class_barbell_front.dart';
import 'package:body_gym/class/class_squat_front.dart';
import 'package:body_gym/class/distance_range_checker.dart';
import 'package:body_gym/class/exercise.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class CalculationsExercise {
  CalculateAngle calculateAngle = CalculateAngle();
  CalculateDistancePoint calculateDistancePoint = CalculateDistancePoint();
  DistanceRangeChecker distanceRangeChecker = DistanceRangeChecker();
  final Exercise _squatExercise = SquatExerciseFront().createExercise();
  final Exercise _armFlexionExercise = ArmFlexionExercise().createExercise();

  final Exercise _babelFrontExercise = BarbellExerciseFront().createExercise();
  double calculateAngleExercise(String typeExercise, Pose pose) {
    switch (typeExercise) {
      case "biceps":
        return calculateAngle.calculateAngleInBarbellCurls(pose);
      case "squat":
        return calculateAngle.calculateAngleInSquat(pose);
      case "armFlexion":
        return calculateAngle.calculateAngleInArmFlexion(pose);
      default:
        return 0.0;
    }
  }

  int calculateRepetitionExercise(String typeExercise, double angleC) {
    switch (typeExercise) {
      case "biceps":
        return _babelFrontExercise.calculationRepetition(angleC);
      case "squat":
        return _squatExercise.calculationRepetition(angleC);
      case "armFlexion":
        return _armFlexionExercise.calculationRepetition(angleC);
      default:
        return 0;
    }
  }

  double calculateDistanceElbowExercise(String typeExercise, Pose pose) {
    switch (typeExercise) {
      case "biceps":
        return calculateDistancePoint.distanceElbow(pose);
      case "squat":
        return calculateDistancePoint.distanceElbow(pose);
      case "armFlexion":
        return calculateDistancePoint.distanceElbow(pose);
      default:
        return 0.0;
    }
  }
}
