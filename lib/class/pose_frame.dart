import 'dart:math';

import 'package:camera/camera.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';
import 'package:body_gym/class/class_barbell.dart';
import 'package:body_gym/class/image_lib.dart';
import 'package:body_gym/class/slope_track.dart';

class PoseFrame {
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

    final double angle = getAngle(wrist, elbow, shoulder);

    return angle;
  }

  doPoseDetectionOnFrame(
      GetImage getImage,
      CameraDescription cameraDescription,
      dynamic controller,
      CameraImage img,
      dynamic poseDetection,
      List<Pose> poses,
      BarbellExercise barbellExercise,
      SlopeTrack slopeTrack,
      dynamic setState,
      int count,
      String slopePosition,
      dynamic scanResults,
      bool isBusy) async {
    // print("chamei");
    var frameImg = getImage.getInputImage(cameraDescription, controller, img);

    poses = await poseDetection.processImage(frameImg);

    for (Pose pose in poses) {
      double angleC = calculateAngleInBarbellCurls(pose);

      int countFunc = barbellExercise.calculationRepetition(angleC);

      String slopePosition = slopeTrack.verifySlopeAngle(
        pose.landmarks[PoseLandmarkType.leftShoulder]!.x,
        pose.landmarks[PoseLandmarkType.leftShoulder]!.y,
        pose.landmarks[PoseLandmarkType.leftHip]!.x,
        pose.landmarks[PoseLandmarkType.leftHip]!.y,
      );

      setState(() {
        // distanceWristAndShoulder = distanceWristAndShoulder;
        count = countFunc + count;

        slopePosition = slopePosition;
        // angleWristAndShoulder = distanceWristAndShoulder;
      });
    }

    setState(() {
      scanResults = poses;
      isBusy = false;
    });
  }
}
