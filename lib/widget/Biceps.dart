import 'package:body_gym/main.dart';
import 'package:body_gym/screen/Detail_Muscle_Biceps.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class biceps extends StatelessWidget {
  const biceps({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 150,
      right: 64,
      width: 35,
      height: 35,
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DetailMuscle()));
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
