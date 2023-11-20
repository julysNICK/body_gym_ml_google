import 'dart:math';

import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class CalculateAngle {
  getAngle(
      PoseLandmark firstPoint, PoseLandmark midPoint, PoseLandmark lastPoint) {
    double result = atan2(lastPoint.y - midPoint.y, lastPoint.x - midPoint.x) -
        atan2(firstPoint.y - midPoint.y, firstPoint.x - midPoint.x);
    result = result * 180 / pi;
    result = result < 0 ? 360 + result : result;
    return result;
  }

  double calculateAngleInBarbellCurls(Pose pose) {
    final PoseLandmark wrist = pose.landmarks[PoseLandmarkType.leftWrist]!;
    final PoseLandmark shoulder =
        pose.landmarks[PoseLandmarkType.leftShoulder]!;

    final PoseLandmark elbow = pose.landmarks[PoseLandmarkType.leftElbow]!;

    final double angle = getAngle(shoulder, elbow, wrist);

    return angle;
  }

  double calculateAngleInSquat(Pose pose) {
    final PoseLandmark hip = pose.landmarks[PoseLandmarkType.leftHip]!;
    final PoseLandmark ankle = pose.landmarks[PoseLandmarkType.leftAnkle]!;

    final PoseLandmark knee = pose.landmarks[PoseLandmarkType.leftKnee]!;

    final double angle = getAngle(hip, knee, ankle);

    return angle;
  }

  double calculateAngleInArmFlexion(Pose pos) {
    final elbowPositionLeft = pos.landmarks[PoseLandmarkType.leftElbow]!;
    final shoulderPositionLeft = pos.landmarks[PoseLandmarkType.leftShoulder]!;
    final headPositionLeft = pos.landmarks[PoseLandmarkType.nose]!;
    final wristPositionLeft = pos.landmarks[PoseLandmarkType.leftWrist]!;
    // final shoulderAngle =
    //     getAngle(shoulderPositionLeft, elbowPositionLeft, headPositionLeft);

    // final shoulderAngle1 = getAngle(headPositionLeft, shoulderPositionLeft,
    //     elbowPositionLeft); //gostei desse

    final shoulderAngle2 =
        getAngle(shoulderPositionLeft, elbowPositionLeft, wristPositionLeft);

    return shoulderAngle2;
  }
}
