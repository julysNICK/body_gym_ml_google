import 'package:body_gym/screen/Detail_Muscle_Squat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Forearm extends StatelessWidget {
  const Forearm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 190,
      left: 42,
      width: 35,
      height: 35,
      child: InkWell(
        onTap: () {
          HapticFeedback.mediumImpact();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DetailMuscleSquat(),
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
            Icons.heart_broken_sharp,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
