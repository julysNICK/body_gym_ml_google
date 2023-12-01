import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Widget buildIfCameraInit(data) {
  print("buildIfCameraInit");
  print(data.controller == null);
  return Container(
    child: data.controller == null
        ? Container(
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : (data.controller.value.isInitialized)
            ? Container(
                child: CameraPreview(data.controller),
              )
            : Container(),
  );
}
