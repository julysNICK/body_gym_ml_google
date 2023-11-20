import 'package:body_gym/class/angle_verifier.dart';
import 'package:body_gym/class/manipulation_array.dart';

const double FlexionLimit = 180;

const double limitHigherFallFlexion = 220;

const double limitLowerFallFlexion = 200;

const double limitHigherFlexion = 200;

const double limitLowerRiseFlexion = 170;

class RepetitionCalculationArmFlexion {
  int historyLength = 5;

  double angleThresholdMin = 170.0;

  double angleThresholdMax = 220.0;

  ManipulationArray manipulationArray = ManipulationArray();

  AngleVerifier angleVerifier = AngleVerifier();

  RepetitionCalculationArmFlexion({
    this.historyLength = 5,
    this.angleThresholdMin = 170.0,
    this.angleThresholdMax = 220.0,
  });

  final List<double> angleHistory = [];

  final List<double> angleHistoryApproved = [];

  int calculationRepetition(double angle) {
    manipulationArray.addAngleInArray2(
      angleHistory,
      angle,
      1,
      limitHigherFallFlexion,
      limitLowerFallFlexion,
      limitHigherFlexion,
      limitLowerRiseFlexion,
      205,
      215,
    );

    manipulationArray.verifyArray(angleHistory, historyLength, FlexionLimit);
    // print('angleHistory: $angleHistory');

    bool isGrowth = manipulationArray.analyzeArray(angleHistory);

    // print('isGrowth: $isGrowth');
    if (angleHistory.isNotEmpty && angleHistory.length > 1 && !isGrowth) {
      angleHistory.removeLast();
    }

    return angleVerifier.verifyAngle(angleHistory, angleThresholdMin,
        angleThresholdMax, historyLength, angleHistoryApproved, FlexionLimit);
  }
}
