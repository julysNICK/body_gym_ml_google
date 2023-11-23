import 'package:body_gym/class/slope_track.dart';

class CamExerciseStateData {
  late dynamic controller;
  late dynamic poseDetection;
  late SlopeTrack slopeTrack;

  CamExerciseStateData({
    required this.poseDetection,
    required this.controller,
    required this.slopeTrack,
  });

  void dispose() {
    controller.dispose();
  }
}
