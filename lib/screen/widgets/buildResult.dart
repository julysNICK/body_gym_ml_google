import 'package:body_gym/screen/pose_painter.dart';
import 'package:flutter/material.dart';

Widget buildResult(data, scanResults, cameraLensDirection) {
  if (scanResults == null || !data.controller.value.isInitialized) {
    return const Text('');
  }

  final Size imageSize = Size(
    data.controller.value.previewSize!.height,
    data.controller.value.previewSize!.width,
  );
  CustomPainter painter =
      PosePainter(imageSize, scanResults, cameraLensDirection);
  return CustomPaint(
    painter: painter,
  );
}
