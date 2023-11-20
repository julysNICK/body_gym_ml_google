import 'dart:math';

class SLopeVerifier {
  final List<double> angleHistorySlope = [];

  String result = "";

  verifySlopeAngle(double angle) {
    angleHistorySlope.add(angle);

    if (angleHistorySlope.length == 5) {
      double media =
          angleHistorySlope.reduce((a, b) => a + b) / angleHistorySlope.length;

      if (media >= 1.5 && media <= 1.7) {
        result = "coluna reta";
      } else if (media < 1.5) {
        result = "coluna arqueada para frente";
      } else if (media > 1.7) {
        result = "coluna arqueada para trás";
      }

      angleHistorySlope.clear();
    }

    return result;
  }
}

class AngleCalculator {
  double slopeLine(double x1, double y1, double x2, double y2) {
    double angle = atan2(y2 - y1, x2 - x1);
    return angle;
  }

  double slopeLineWithZPoint(double z1, double z2) {
    double plain = 0;

    double column = (z1 + z2) / 2;

    double angle = atan2(column - plain, z2 - z1);

    return angle;
  }
}

class SlopeTrack {
  final AngleCalculator angleCalculator = AngleCalculator();
  final SLopeVerifier slopeVerifier = SLopeVerifier();

  SlopeTrack();

  verifySlopeAngle(
      double xShoulder, double yShoulder, double xHip, double yHip) {
    double angle = angleCalculator.slopeLine(xShoulder, yShoulder, xHip, yHip);

    return slopeVerifier.verifySlopeAngle(angle);
  }
}
