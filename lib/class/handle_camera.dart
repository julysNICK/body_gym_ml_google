import 'dart:io';

import 'package:camera/camera.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

late List<CameraDescription> cameras;

class CameraHandle {
  dynamic poseDetection = false;
  dynamic controller;
  late CameraDescription cameraDescription = cameras[1];
  bool isBusy = false;
  CameraImage? img;

  Future<void> initializeCamera(
    bool mounted,
    Function doPoseDetectionOnFrame,
  ) async {
    final options = PoseDetectorOptions(
      mode: PoseDetectionMode.stream,
    );

    poseDetection = PoseDetector(options: options);

    controller = CameraController(
      cameraDescription,
      ResolutionPreset.max,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );

    await controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      controller.startImageStream((CameraImage image) async {
        if (!isBusy) {
          isBusy = true;
          img = image;
          doPoseDetectionOnFrame();
        }
      });
    });
  }
}
