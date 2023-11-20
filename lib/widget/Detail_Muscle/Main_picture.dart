import 'dart:io';

import 'package:body_gym/main.dart';
import 'package:body_gym/screen/Camexercise.dart';
import 'package:body_gym/screen/Exercise_cam.dart';
import 'package:body_gym/widget/Detail_Muscle/Navbar.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class MainPicture extends StatefulWidget {
  const MainPicture({
    super.key,
    required this.typeExercise,
  });

  final String typeExercise;

  @override
  State<MainPicture> createState() => _MainPictureState();
}

class _MainPictureState extends State<MainPicture> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          const ImageCompress(),
          const NavBar(),
          Positioned(
            bottom: 10,
            left: 0,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CamExercise(
                              title: "Exercise",
                              typeExercise: widget.typeExercise,
                            )));
              },
              child: Container(
                height: 30,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: const Color(0xFFA4BFCC),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Center(
                  child: Row(
                    children: [
                      Icon(
                        Icons.play_arrow,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Training with IA assistant",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageCompress extends StatelessWidget {
  const ImageCompress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: compressAndResizeImage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Image.asset(
            'assets/images/workout-biceps.jpg',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

Future<void> compressAndResizeImage() async {
  String path = 'assets/images/workout-biceps.jpg';

  var compresseImage = await FlutterImageCompress.compressWithFile(
    path,
    minWidth: 2300,
    minHeight: 1500,
    quality: 94,
  );

  String newPath = 'assets/images/workout-biceps-compressed.jpg';

  await File(newPath).writeAsBytes(compresseImage as List<int>);
}
