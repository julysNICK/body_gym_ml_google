class AngleArrayLengthVerifier {
  bool verifyLengthArray(
      List<double> angleArray, int minLength, int maxLength) {
    if (angleArray.length >= minLength && angleArray.length <= maxLength) {
      return true;
    }

    return false;
  }
}

class AngleArrayValueVerifier {
  bool verifyAngleArray(
      List<double> angleArray, double minAngle, double maxAngle) {
    if (angleArray.every((a) => a >= minAngle && a <= maxAngle)) {
      return true;
    }

    return false;
  }
}

class AngleVerifier {
  final AngleArrayLengthVerifier angleArrayLengthVerifier =
      AngleArrayLengthVerifier();
  final AngleArrayValueVerifier angleArrayValueVerifier =
      AngleArrayValueVerifier();

  double saveTheLastAngle = 0.0;

  bool verifyLengthArray(
    angleArray, {
    int minLength = 4,
    int maxLength = 5,
  }) {
    return angleArrayLengthVerifier.verifyLengthArray(
        angleArray, minLength, maxLength);
  }

  int verifyAngle(angleHistory, angleThresholdMin, angleThresholdMax,
      historyLength, angleHistoryApproved, limitAccept) {
    // print("angleHistory $angleHistory");
    // print(
    //     "verifyLengthArray(5, angleHistory) ${verifyLengthArray(angleHistory)}");

    bool isAngleInRange = angleArrayValueVerifier.verifyAngleArray(
        angleHistory, angleThresholdMin, angleThresholdMax);
    // print("isAngleInRange $isAngleInRange");
    // print("---------------------------------------------------------");
    // print(
    //     "angleHistory.length == historyLength: ${angleHistory.length} == $historyLength ${angleHistory.length == historyLength}");
    // print("isAngleInRange: $isAngleInRange");
    // print(
    //     "angleHistory.last <= limitAccept: ${angleHistory.length ?? angleHistory.last} <= $limitAccept ${angleHistory.length ?? angleHistory.last <= limitAccept}");
    // print("---------------------------------------------------------");

    if (angleHistory.length == historyLength &&
        isAngleInRange &&
        angleHistory.last <= limitAccept) {
      // print("ConteiConteiConteiConteiContei");
      //70 -> 75
      angleHistoryApproved.addAll(angleHistory);
      saveTheLastAngle = 0.0;
      angleHistory.clear();

      return 1;
    }
    //  else if (verifyLengthArray(angleHistory,
    //         minLength: 3, maxLength: historyLength) &&
    //     isAngleInRange &&
    //     angleHistory.last <= limitAccept) {
    //   // print("Contei");
    //   angleHistoryApproved.addAll(angleHistory);
    //   saveTheLastAngle = 0.0;
    //   angleHistory.clear();
    //   return 1;
    // }
    // saveTheLastAngle = angleHistory.last;
    // if (saveTheLastAngle > 0.0 &&
    //     saveTheLastAngle == angleHistory.last &&
    //     angleHistory.length == 2 &&
    //     saveTheLastAngle - limitAccept <= 10.0) {
    //   angleHistory.removeLast();
    //   saveTheLastAngle = 0.0;
    // }
    // print("não contei");
    // print(angleHistory);
    return 0;
  }
}
