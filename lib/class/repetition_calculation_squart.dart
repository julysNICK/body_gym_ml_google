import 'package:body_gym/class/angle_verifier.dart';
import 'package:body_gym/class/manipulation_array.dart';

const double squatLimit = 187;

const double limitHigherFallSquat = 220;

const double limitLowerFallSquat = 180;

const double limitHigherSquat = 170;

const double limitLowerRiseSquat = 180;

class RepetitionCalculationSquatFront {
  int historyLength = 5;

  double angleThresholdMin = 100.0;

  double angleThresholdMax = 230.0;

  ManipulationArray manipulationArray = ManipulationArray();

  AngleVerifier angleVerifier = AngleVerifier();

  RepetitionCalculationSquatFront({
    this.historyLength = 5,
    this.angleThresholdMin = 100.0,
    this.angleThresholdMax = 230.0,
  });

  final List<double> angleHistory = [];

  final List<double> angleHistoryApproved = [];

  int calculationRepetition(double angle) {
    // print('angle: $angle');
    manipulationArray.addAngleInArray2(
      angleHistory,
      angle,
      1,
      limitHigherFallSquat,
      limitLowerFallSquat,
      limitHigherSquat,
      limitLowerRiseSquat,
      200,
      230,
    );
    // print("linha 48: angleHistory: $angleHistory");
    manipulationArray.verifyArray(angleHistory, historyLength, squatLimit);
    bool isGrowth = manipulationArray.analyzeArray(angleHistory);

    // print('isGrowth: $isGrowth');
    if (angleHistory.isNotEmpty && !isGrowth) {
      angleHistory.removeLast();
    }

    return angleVerifier.verifyAngle(angleHistory, angleThresholdMin,
        angleThresholdMax, historyLength, angleHistoryApproved, squatLimit);
  }
}
