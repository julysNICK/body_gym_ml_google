import 'package:body_gym/widget/Detail_Muscle/Box_Cards.dart';
import 'package:body_gym/widget/Detail_Muscle/Main_picture.dart';

import 'package:flutter/material.dart';

class DetailMuscleArm extends StatefulWidget {
  const DetailMuscleArm({super.key});

  @override
  State<DetailMuscleArm> createState() => _DetailMuscleArmState();
}

class _DetailMuscleArmState extends State<DetailMuscleArm> {
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
        child: const Column(
          children: [
            MainPicture(
              typeExercise: "armFlexion",
            ),
            BoxCards(),
          ],
        ),
      ),
    );
  }
}
