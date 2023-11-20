// ignore: file_names
import 'package:body_gym/screen/Detail_Muscle_Arm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Shoulder extends StatelessWidget {
  const Shoulder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 105,
      left: 75,
      width: 35,
      height: 35,
      child: InkWell(
        onTap: () {
          HapticFeedback.mediumImpact();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DetailMuscleArm(),
            ),
          );
        },
        child: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: const Color(0xFFA4BFCC).withOpacity(0.8),
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(
            Icons.heart_broken,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
