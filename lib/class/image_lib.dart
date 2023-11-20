import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class GetImage {
  final _orientations = {
    DeviceOrientation.portraitUp: 0,
    DeviceOrientation.landscapeLeft: 90,
    DeviceOrientation.portraitDown: 180,
    DeviceOrientation.landscapeRight: 270,
  };
  InputImage? getInputImage(
    CameraDescription cameraDescription,
    CameraController? controller,
    CameraImage? img,
  ) {
    final camera = cameraDescription;

    final sensorOrientation = camera.sensorOrientation;

    InputImageRotation? imageRotation;

    var rotationCompensation =
        _orientations[controller!.value.deviceOrientation];

    if (rotationCompensation == null) return null;

    if (camera.lensDirection == CameraLensDirection.front) {
      rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
    } else {
      rotationCompensation =
          (sensorOrientation - rotationCompensation + 360) % 360;
    }

    imageRotation = InputImageRotationValue.fromRawValue(rotationCompensation);

    if (imageRotation == null) return null;

    final format = InputImageFormatValue.fromRawValue(img!.format.raw);

    if (format == null ||
        (Platform.isAndroid && format != InputImageFormat.nv21) ||
        (Platform.isIOS && format != InputImageFormat.bgra8888)) return null;

    if (img.planes.isEmpty) return null;

    final plane = img.planes.first;

    return InputImage.fromBytes(
        bytes: plane.bytes,
        metadata: InputImageMetadata(
          size: Size(img.width.toDouble(), img.height.toDouble()),
          rotation: imageRotation,
          format: format,
          bytesPerRow: plane.bytesPerRow,
        ));
  }
}
