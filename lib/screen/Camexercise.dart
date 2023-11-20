import 'dart:io';
import 'dart:math';

import 'package:body_gym/class/class_arm_flexion.dart';
import 'package:body_gym/class/class_squat_front.dart';
import 'package:body_gym/class/exercise.dart';
import 'package:body_gym/class/pose_frame.dart';
import 'package:body_gym/screen/pose_painter.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:body_gym/class/slope_track.dart';
import 'package:body_gym/class/handle_camera.dart';
import 'package:body_gym/class/calculate_angle.dart';
import 'package:body_gym/class/class_barbell.dart';
import 'package:body_gym/class/calculate_distance_point.dart';
import 'package:body_gym/class/class_barbell_front.dart';
import 'package:body_gym/class/distance_range_checker.dart';
import 'package:body_gym/class/image_lib.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

late List<CameraDescription> cameras;

class _CamExerciseStateData {
  late dynamic controller;
  late dynamic poseDetection;
  late SlopeTrack slopeTrack;

  _CamExerciseStateData({
    required this.poseDetection,
    required this.controller,
    required this.slopeTrack,
  });

  void dispose() {
    controller.dispose();
  }
}

class CamExercise extends StatefulWidget {
  const CamExercise(
      {super.key, required this.title, required this.typeExercise});

  final String title;
  final String typeExercise;

  @override
  State<CamExercise> createState() => _CamExerciseState();
}

class _CamExerciseState extends State<CamExercise> {
  List<Pose> poses = <Pose>[];
  bool readyToStart = false;
  double distanceWristAndShoulder = 0.0;
  double angleBarbell = 0.0;
  bool isBusy = false;
  bool showEndText = false;
  CameraLensDirection cameraLensDirection = CameraLensDirection.front;
  late CameraDescription cameraDescription;
  String suggestion = "";
  String slopePosition = "";
  CameraHandle cameraHandle = CameraHandle();
  int count = 0;
  dynamic _scanResults;
  //in use

  late _CamExerciseStateData _data;
  CameraImage? img;
  bool isRepeting = false;
  GetImage getImage = GetImage();
  CalculateAngle calculateAngle = CalculateAngle();
  CalculateDistancePoint calculateDistancePoint = CalculateDistancePoint();
  DistanceRangeChecker distanceRangeChecker = DistanceRangeChecker();

  final Exercise _babelExercise = BarbellExercise().createExercise();
  final Exercise _squatExercise = SquatExerciseFront().createExercise();
  final Exercise _armFlexionExercise = ArmFlexionExercise().createExercise();

  final Exercise _babelFrontExercise = BarbellExerciseFront().createExercise();

  Future initCamera() async {
    try {
      cameras = await availableCameras();
      cameraDescription = cameras[1];
      cameraLensDirection = CameraLensDirection.front;
      initializeCamera();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    initCamera();
    _data = _CamExerciseStateData(
      controller: cameraHandle.controller,
      poseDetection: false,
      slopeTrack: SlopeTrack(),
    );
  }

  PoseFrame poseFrame = PoseFrame();

  Future<void> initializeCamera() async {
    final options = PoseDetectorOptions(
      mode: PoseDetectionMode.stream,
    );

    _data.poseDetection = PoseDetector(options: options);

    _data.controller = CameraController(
      cameraDescription,
      ResolutionPreset.max,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid
          ? ImageFormatGroup.nv21
          : ImageFormatGroup.bgra8888,
    );

    await _data.controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      _data.controller.startImageStream((CameraImage image) async {
        if (!isBusy) {
          isBusy = true;
          img = image;
          doPoseDetectionOnFrame();
        }
      });
    });
  }

  void exitExercise12Repetition(int count) {
    if (count == 5) {
      print("Acabou o exercicio");
      return;
    }
  }

  void exitExercise12RepetitionText(int count) {
    _data.dispose();

    if (count == 12) {
      setState(() {
        showEndText = true;
      });
      return;
    }

    setState(() {
      showEndText = false;
    });
  }

  double calculateAngleExercise(String typeExercise, Pose pose) {
    switch (typeExercise) {
      case "biceps":
        return calculateAngle.calculateAngleInBarbellCurls(pose);
      case "squat":
        return calculateAngle.calculateAngleInSquat(pose);
      case "armFlexion":
        return calculateAngle.calculateAngleInArmFlexion(pose);
      default:
        return 0.0;
    }
  }

  int calculateRepetitionExercise(String typeExercise, double angleC) {
    switch (typeExercise) {
      case "biceps":
        return _babelFrontExercise.calculationRepetition(angleC);
      case "squat":
        return _squatExercise.calculationRepetition(angleC);
      case "armFlexion":
        return _armFlexionExercise.calculationRepetition(angleC);
      default:
        return 0;
    }
  }

  double calculateDistanceElbowExercise(String typeExercise, Pose pose) {
    switch (typeExercise) {
      case "biceps":
        return calculateDistancePoint.distanceElbow(pose);
      case "squat":
        return calculateDistancePoint.distanceElbow(pose);
      case "armFlexion":
        return calculateDistancePoint.distanceElbow(pose);
      default:
        return 0.0;
    }
  }

  String calculatePositionExercise(String typeExercise, double distanceS) {
    switch (typeExercise) {
      case "biceps":
        return distanceRangeChecker.rangeKneeShoulder(distanceS);
      case "squat":
        return distanceRangeChecker.rangeKneeShoulder(distanceS);
      case "armFlexion":
        return distanceRangeChecker.rangeKneeShoulder(distanceS);
      default:
        return "";
    }
  }

  final AngleCalculator angleCalculator = AngleCalculator();
  _updatePoseState() async {
    var frameImg =
        getImage.getInputImage(cameraDescription, _data.controller, img);

    poses = await _data.poseDetection.processImage(frameImg);

    for (Pose pose in poses) {
      if (readyToStart == true) {
        double angleC = 0.0;
        double distanceS = 0.0;
        String position = "";
        int countRep = 0;

        angleC = calculateAngleExercise(widget.typeExercise, pose);

        distanceS = calculateDistanceElbowExercise(widget.typeExercise, pose);

        position = calculatePositionExercise(widget.typeExercise, distanceS);

        countRep = calculateRepetitionExercise(widget.typeExercise, angleC);

        setState(() {
          // distanceWristAndShoulder = distanceWristAndShoulder;
          count = countRep + count;
          suggestion = suggestion;
          slopePosition = position;
          angleBarbell = angleC;
        });

        // exitExercise12RepetitionText(count);
      }
    }

    print("count: $count");
    exitExercise12Repetition(count);

    setState(() {
      _scanResults = poses;
      isBusy = false;
    });
  }

  doPoseDetectionOnFrame() async {
    await _updatePoseState();
  }

  Widget buildResult() {
    if (_scanResults == null || !_data.controller.value.isInitialized) {
      return const Text('');
    }

    final Size imageSize = Size(
      _data.controller.value.previewSize!.height,
      _data.controller.value.previewSize!.width,
    );
    CustomPainter painter =
        PosePainter(imageSize, _scanResults, cameraLensDirection);
    return CustomPaint(
      painter: painter,
    );
  }

  Widget _buidExercice() {
    return Container(
      child: Column(
        children: [
          Text(
            "Repetition: $count",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 50.0,
            ),
          ),
          Text(
            "Angle flexion Arm: $angleBarbell",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 50.0,
            ),
          ),
          Text(
            "DIstance Knee: $slopePosition",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIfCameraInit() {
    return Container(
      child: (_data.controller.value.isInitialized)
          ? Container(
              child: CameraPreview(_data.controller),
            )
          : Container(),
    );
  }

  final BoxDecoration _decorationText = BoxDecoration(
    color: Colors.blue.withOpacity(0.5),
    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    boxShadow: const [
      BoxShadow(
        color: Colors.black,
        spreadRadius: 1,
        blurRadius: 1,
        offset: Offset(0, 1), // changes position of shadow
      ),
    ],
  );

  final TextStyle _stylesText = const TextStyle(
    color: Colors.white,
    fontSize: 20.0,
  );

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [];
    final size = MediaQuery.of(context).size;
    stackChildren.add(
      Positioned(
        top: 0.0,
        left: 0.0,
        width: size.width,
        height: size.height,
        child: _buildIfCameraInit(),
      ),
    );
    stackChildren.add(
      Positioned(
          top: 0.0,
          left: 0.0,
          width: size.width,
          height: size.height,
          child: buildResult()),
    );

    stackChildren.add(
      Positioned(
        top: 0.0,
        left: 0.0,
        width: size.width,
        height: size.height,
        child: _buidExercice(),
      ),
    );

    stackChildren.add(
      Positioned(
        bottom: 0.0,
        left: 0.0,
        width: size.width,
        height: 50.0,
        child: InkWell(
          onTap: () {
            //change readyToStart to true after 5 seconds
            // print("chamei onTap");

            Future.delayed(const Duration(seconds: 5), () {
              // print("chamei Future.delayed");
              setState(() {
                readyToStart = true;
              });
            });
          },
          child: Container(
            width: size.width,
            height: 10.0,
            decoration: _decorationText,
            child: Center(
              child: Text(
                "Começar a treinar",
                style: _stylesText,
              ),
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
            margin: const EdgeInsets.only(top: 0),
            color: Colors.black,
            child: Stack(
              children: stackChildren,
            )),
      ),
    );
  }
}
