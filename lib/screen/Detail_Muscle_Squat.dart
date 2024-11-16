import 'package:body_gym/repositories/videosRepository.dart';
import 'package:body_gym/widget/Detail_Muscle/Box_Cards.dart';
import 'package:body_gym/widget/Detail_Muscle/Main_picture.dart';

import 'package:flutter/material.dart';

class DetailMuscleSquat extends StatefulWidget {
  const DetailMuscleSquat({super.key});

  @override
  State<DetailMuscleSquat> createState() => _DetailMuscleSquatState();
}

class _DetailMuscleSquatState extends State<DetailMuscleSquat> {
  VideosRepository videosRepository = VideosRepository();

  List<Map<String, dynamic>> resultVideos = [];
  List<Map<String, dynamic>> resultVideosFormat = [];
  Future getVideosLegs() async {
    try {
      var resultVideosCall = await videosRepository.getVideosLegs();

      for (var i = 0; i < resultVideosCall.length; i++) {
        resultVideosFormat.add({
          "title": resultVideosCall[i]["title"],
          "thumb": resultVideosCall[i]["thumb"],
          "url": resultVideosCall[i]["url"],
          "channel": resultVideosCall[i]["chanel"],
        });
      }

      setState(() {
        resultVideos = resultVideosFormat;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVideosLegs();
  }

  printResult() {
    print(resultVideos);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFA4BFCC).withOpacity(0.4),
      // backgroundColor: const Color(0xFFA4BFCC),
      body: Container(
        padding: const EdgeInsets.only(
          bottom: 10,
        ),
        height: size.height,
        child: Column(
          children: [
            const MainPicture(
              typeExercise: "squat",
            ),
            BoxCards(
              listTutorial: resultVideos,
            ),
          ],
        ),
      ),
    );
  }
}
