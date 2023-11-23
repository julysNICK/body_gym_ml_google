import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Widget buildIfCameraInit(data) {
  return Container(
    child: (data.controller.value.isInitialized)
        ? Container(
            child: CameraPreview(data.controller),
          )
        : Container(),
  );
}
