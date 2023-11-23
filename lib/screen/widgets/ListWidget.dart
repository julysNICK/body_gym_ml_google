import 'package:body_gym/class/camExerciseStateData.dart';
import 'package:body_gym/screen/Camexercise.dart';
import 'package:body_gym/screen/widgets/buildCountDown.dart';
import 'package:body_gym/screen/widgets/buildExercise.dart';
import 'package:body_gym/screen/widgets/buildIfCameraInit.dart';
import 'package:body_gym/screen/widgets/buildResult.dart';
import 'package:body_gym/screen/widgets/buildTextSuccess.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

List<Widget> listWidgetFn(
    BuildContext context,
    void Function() functionOnTapStartExecise,
    bool clickedExercise,
    int counter,
    bool clickedExerciseNoFuture,
    bool showEndText,
    int count,
    CamExerciseStateData data,
    dynamic scanResults,
    CameraLensDirection cameraLensDirection) {
  final BoxDecoration decorationText = BoxDecoration(
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

  const TextStyle stylesText = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
  );

  List<Widget> stackChildren = [];
  Size size = MediaQuery.of(context).size;

  stackChildren.add(
    Positioned(
      top: 0.0,
      left: 0.0,
      width: size.width,
      height: size.height,
      child: buildIfCameraInit(data),
    ),
  );

  stackChildren.add(
    Positioned(
        top: 0.0,
        left: 0.0,
        width: size.width,
        height: size.height,
        child: buildResult(data, scanResults, cameraLensDirection)),
  );
  stackChildren.add(
    Positioned(
      top: 0.0,
      left: 0.0,
      width: size.width,
      height: size.height,
      child: buidExercice(count),
    ),
  );

  stackChildren.add(
    Positioned(
      top: 250.0,
      left: 0.0,
      width: size.width,
      height: size.height,
      child: AnimatedOpacity(
        opacity: showEndText ? 1.0 : 0.0,
        duration: const Duration(
          milliseconds: 500,
        ),
        child: buildTextSucess(),
      ),
    ),
  );

  stackChildren.add(
    Positioned(
      top: size.height / 2,
      left: 0.0,
      width: size.width,
      height: size.height,
      child: AnimatedOpacity(
        opacity: clickedExerciseNoFuture ? 1.0 : 0.0,
        duration: const Duration(
          milliseconds: 500,
        ),
        child: buildCountDown(
          counter,
        ),
      ),
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
          functionOnTapStartExecise();
        },
        child: Container(
          width: size.width,
          height: 10.0,
          decoration: decorationText,
          child: Center(
            child: Text(
              clickedExercise ? "Exercício iniciado" : "Clique para iniciar",
              style: stylesText,
            ),
          ),
        ),
      ),
    ),
  );
  return stackChildren;
}
