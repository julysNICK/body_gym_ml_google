import 'dart:math';

import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class CalculateDistancePoint {
  double calculateDistanceY(double y1, double y2) {
    double distance = y1 - y2;
    return distance;
  }

  double calculateDistanceX(double x1, double x2) {
    double distance = x1 - x2;
    return distance;
  }

  double CalculateDistance(double x1, double y1, double x2, double y2) {
    double distance = sqrt(pow((x2 - x1), 2) + pow((y2 - y1), 2));
    return distance;
  }

  double distancePointKnee(Pose pose) {
    final PoseLandmark kneeLeft = pose.landmarks[PoseLandmarkType.leftKnee]!;
    final PoseLandmark kneeRight = pose.landmarks[PoseLandmarkType.rightKnee]!;

    final PoseLandmark shoulderLeft =
        pose.landmarks[PoseLandmarkType.leftShoulder]!;

    final PoseLandmark shoulderRight =
        pose.landmarks[PoseLandmarkType.rightShoulder]!;

    // double distance =
    //     CalculateDistance(kneeLeft.x, kneeLeft.y, kneeRight.x, kneeRight.y);

    double distanceKneeX = calculateDistanceX(kneeLeft.x, kneeRight.x);

    double distanceShoulderX =
        calculateDistanceX(shoulderLeft.x, shoulderRight.x);
    return distanceKneeX / distanceShoulderX;
  }

  double distanceElbow(Pose pose) {
    final PoseLandmark elbowLeft = pose.landmarks[PoseLandmarkType.leftElbow]!;
    final PoseLandmark elbowRight =
        pose.landmarks[PoseLandmarkType.rightElbow]!;

    final PoseLandmark shoulderLeft =
        pose.landmarks[PoseLandmarkType.leftShoulder]!;

    final PoseLandmark shoulderRight =
        pose.landmarks[PoseLandmarkType.rightShoulder]!;

    double distanceElbowX = calculateDistanceX(elbowLeft.x, elbowRight.x);

    double distanceShoulderX =
        calculateDistanceX(shoulderLeft.x, shoulderRight.x);
    return distanceElbowX / distanceShoulderX;
  }
}
