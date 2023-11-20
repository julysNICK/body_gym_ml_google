class AngleArrayAdder {
  void addAngleToArray(List<double> angleArray, double angle) {
    angleArray.add(angle);
  }
}

class AngleArrayVerifier {
  bool verifyAngleArray(
      List<double> angleArray, int length, double limitToAccept) {
    if (angleArray.isNotEmpty) {
      double? theLastAngle = angleArray.last;
      if (angleArray.length == length && theLastAngle > limitToAccept) {
        return true;
      }
    }
    return false;
  }
}

class ManipulationArray {
  final AngleArrayAdder angleArrayAdder = AngleArrayAdder();
  final AngleArrayVerifier angleArrayVerifier = AngleArrayVerifier();
  double repetitionLength = 0;
  double salveLengthTheLastExecute = 0;

  int _lastLength = 0;

  int get lastLength => _lastLength;

  set lastLength(int value) {
    _lastLength = value;
  }

  bool isInBetweenInFall(
      int roundedAngle, double limitHigherFall, double limitLowerFall) {
    return (roundedAngle >= limitLowerFall &&
        roundedAngle <= limitHigherFall); // 190 - 220
  }

  bool isInBetweenRise(
      int roundedAngle, double limitHigherRise, double limitLowerRise) {
    return (roundedAngle >= limitLowerRise &&
        roundedAngle < limitHigherRise); // 180 - 186
  }

  bool analyzeArray(
    List<double> angleArray,
  ) {
    print("angleArray $angleArray");
    print("lastLength $lastLength");
    if (angleArray.length > lastLength) {
      lastLength = angleArray.length;
      // print("cresceu");
      return true;
    }

    // print("não cresceu");
    lastLength = 0;
    return false;
  }

  bool shouldAddAngleToArray(
      double angle,
      double? theLastAngle,
      double diff,
      double limitHigherFallSquat,
      double limitLowerFallSquat,
      double limitHigherSquat,
      double limitLowerRiseSquat,
      double acceptPrimaryAngle,
      double acceptPrimaryAngle2) {
    // print("entrei aqui");

    // print(
    //     "------------------------------------------------------------------------");
    // print("angle.round(): ${angle.round()}");
    // print("limitHigherFallSquat: $limitHigherFallSquat");
    // print("limitLowerFallSquat: $limitLowerFallSquat");
    // print(
    //     "isInBetweenInFall: ${isInBetweenInFall(angle.round(), limitHigherFallSquat, limitLowerFallSquat)}");

    // print(
    //     "------------------------------------------------------------------------");
    // print("angle.round(): ${angle.round()}");
    // print("limitHigherSquat: $limitHigherSquat");
    // print("limitLowerRiseSquat: $limitLowerRiseSquat");
    // print(
    //     "isInBetweenRise: ${isInBetweenRise(angle.round(), limitHigherSquat, limitLowerRiseSquat)}");
    // print(
    //     "------------------------------------------------------------------------");

    if (theLastAngle == null &&
        isInBetweenInFall(
            angle.round(), limitHigherFallSquat, limitLowerFallSquat) &&
        angle.round() > acceptPrimaryAngle &&
        angle.round() < acceptPrimaryAngle2) {
      // print("linha 52:angulo maior que 170");
      print("linha 53:angle: $angle");
      return true;
    } else if (theLastAngle != null &&
        isInBetweenInFall(
            angle.round(), limitHigherFallSquat, limitLowerFallSquat) &&
        angle < theLastAngle) {
      double diffAngle = theLastAngle - angle;
      // print("linha 60 diff: $theLastAngle - $angle = $diffAngle");
      if (diffAngle >= diff) {
        // && diffAngle <= diff + 3
        // print("linha 62:diffAngle($diffAngle) >= diff($diff)");
        return true;
      }
    } else if (theLastAngle != null &&
        isInBetweenRise(angle.round(), limitHigherSquat, limitLowerRiseSquat) &&
        angle < theLastAngle) {
      double diffAngle = angle - theLastAngle;
      // print("linha 69 diff: $theLastAngle - $angle = $diffAngle");
      if (diffAngle.abs() >= diff) {
        // && diffAngle <= diff + 3
        // print("linha 71:diffAngle($diffAngle) >= diff($diff)");
        return true;
      }
    }
    // print("sai aqui com false");
    return false;
  }

  double convertAngleHighestLimit(
    double angle,
    List<double> angleArray,
  ) {
    if (angle.round() > 190 &&
        angleArray.isNotEmpty &&
        angleArray.length == 2) {
      return 25;
    }
    return angle.roundToDouble();
  }

  void addAngleInArray2(
    List<double> angleArray,
    double angle,
    double diff,
    double limitHigherFall,
    double limitLowerFall,
    double limitHigherRise,
    double limitLowerRise,
    double acceptPrimaryAngle,
    double acceptPrimaryAngle2,
  ) {
    if (shouldAddAngleToArray(
        angle,
        angleArray.isNotEmpty ? angleArray.last : null,
        diff,
        limitHigherFall,
        limitLowerFall,
        limitHigherRise,
        limitLowerRise,
        acceptPrimaryAngle,
        acceptPrimaryAngle2)) {
      angleArrayAdder.addAngleToArray(angleArray, angle);
    } else if (angleArray.isNotEmpty &&
        angleArray.length == 2 &&
        angle.round() < 20) {
      // print("entrei aqui na linha 117 na pasta manipulation_array");

      angleArrayAdder.addAngleToArray(angleArray, angle);
    }
  }

  void verifyArray(List<double> angleArray, int length, double limitToAccept) {
    if (angleArrayVerifier.verifyAngleArray(
        angleArray, length, limitToAccept)) {
      angleArray.removeAt(0);
    }
  }

  void verifyLengthArray(List<double> angleArray, double limitAccept) {
    salveLengthTheLastExecute = angleArray.isNotEmpty ? angleArray.last : 0;

    if (repetitionLength != 0) {
      if (angleArray.length > 1 &&
          angleArray.last == salveLengthTheLastExecute &&
          salveLengthTheLastExecute - limitAccept <= 10.0) {
        // print("o array não cresceu");
        angleArray.removeLast();
        repetitionLength = 0;
        return;
      }
      repetitionLength = 0;
      return;
    }
    repetitionLength = 1;
  }
}
