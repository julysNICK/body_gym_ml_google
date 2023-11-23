import 'dart:async';
import 'dart:io';
import 'package:body_gym/class/calculations_exercise.dart';
import 'package:body_gym/class/camExerciseStateData.dart';
import 'package:body_gym/class/pose_frame.dart';
import 'package:body_gym/screen/widgets/ListWidget.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:body_gym/class/slope_track.dart';
import 'package:body_gym/class/handle_camera.dart';
import 'package:body_gym/class/calculate_angle.dart';
import 'package:body_gym/class/calculate_distance_point.dart';
import 'package:body_gym/class/distance_range_checker.dart';
import 'package:body_gym/class/image_lib.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

late List<CameraDescription> cameras;

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
  int _Counter = 5;

  late Timer _timer;
  bool clickedExercise = false;
  bool clickedExerciseNoFuture = false;
  double distanceWristAndShoulder = 0.0;
  double angleBarbell = 0.0;
  bool isBusy = false;
  bool showStartText = false;
  bool showEndText = false;
  CameraLensDirection cameraLensDirection = CameraLensDirection.front;
  late CameraDescription cameraDescription;
  String suggestion = "";
  String slopePosition = "";
  CameraHandle cameraHandle = CameraHandle();
  int count = 0;
  dynamic _scanResults;

  late CamExerciseStateData _data;
  CameraImage? img;
  bool isRepeting = false;
  GetImage getImage = GetImage();
  CalculateAngle calculateAngle = CalculateAngle();
  CalculateDistancePoint calculateDistancePoint = CalculateDistancePoint();
  DistanceRangeChecker distanceRangeChecker = DistanceRangeChecker();

  final CalculationsExercise calculateRepetition = CalculationsExercise();
  void startTimer() {
    _Counter = 5;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_Counter > 0) {
        setState(() {
          _Counter--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

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
    _data = CamExerciseStateData(
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
    if (count == 1) {
      setState(() {
        showEndText = true;
        readyToStart = false;
      });
      return;
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

        angleC = calculateRepetition.calculateAngleExercise(
            widget.typeExercise, pose);

        // distanceS = calculateRepetition.calculateDistanceElbowExercise(widget.typeExercise, pose);

        // position = calculateRepetition.calculatePositionExercise(widget.typeExercise, distanceS);

        countRep = calculateRepetition.calculateRepetitionExercise(
            widget.typeExercise, angleC);

        setState(() {
          count = countRep + count;

          // slopePosition = position;
          // angleBarbell = angleC;
        });
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

  void functionOnTapStartExecise() {
    setState(() {
      clickedExerciseNoFuture = !clickedExerciseNoFuture;
    });
    startTimer();
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        readyToStart = true;
        clickedExercise = !clickedExercise;
        clickedExerciseNoFuture = !clickedExerciseNoFuture;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
            margin: const EdgeInsets.only(top: 0),
            color: Colors.black,
            child: Stack(
              children: listWidgetFn(
                context,
                functionOnTapStartExecise,
                clickedExerciseNoFuture,
                _Counter,
                clickedExerciseNoFuture,
                showEndText,
                count,
                _data,
                _scanResults,
                cameraLensDirection,
              ),
            )),
      ),
    );
  }
}
