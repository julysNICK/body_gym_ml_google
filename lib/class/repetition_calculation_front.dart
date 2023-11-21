import 'package:body_gym/class/angle_verifier.dart';
import 'package:body_gym/class/manipulation_array.dart';

const double barbellLimit = 190;

const double limitHigherFallBarbell = 230;

const double limitLowerFallBarbell = 160;

const double limitHigherRiseBarbell = 160;

const double limitLowerRiseBarbell = 20;

class RepetitionCalculationBarbelFront {
  int historyLength = 3;

  double angleThresholdMin = 0.0;

  double angleThresholdMax = 350.0;

  ManipulationArray manipulationArray = ManipulationArray();

  AngleVerifier angleVerifier = AngleVerifier();

  RepetitionCalculationBarbelFront({
    this.historyLength = 3,
    this.angleThresholdMin = 0.0,
    this.angleThresholdMax = 350.0,
  });

  final List<double> angleHistory = [];

  final List<double> angleHistoryApproved = [];

  int calculationRepetition(double angle) {
    manipulationArray.addAngleInArray2(
        angleHistory,
        angle,
        5,
        limitHigherFallBarbell,
        limitLowerFallBarbell,
        limitHigherRiseBarbell,
        limitLowerRiseBarbell,
        150,
        165);

    manipulationArray.verifyArray(angleHistory, historyLength, barbellLimit);
    print('angleHistory: $angleHistory');

    // bool isGrowth = manipulationArray.analyzeArray(angleHistory);

    // print('isGrowth: $isGrowth');
    // if (angleHistory.isNotEmpty && !isGrowth) {
    //   angleHistory.removeLast();
    // }

    // manipulationArray.verifyLengthArray(angleHistory, barbellLimit);
    return angleVerifier.verifyAngle(angleHistory, angleThresholdMin,
        angleThresholdMax, historyLength, angleHistoryApproved, barbellLimit);
  }
}
