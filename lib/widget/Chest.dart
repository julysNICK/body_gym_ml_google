import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Chest extends StatefulWidget {
  void Function() fn;
  Chest({super.key, required this.fn});

  @override
  State<Chest> createState() => _ChestState();
}

class _ChestState extends State<Chest> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 120,
      left: 155,
      width: 35,
      height: 35,
      child: InkWell(
        onTap: () {
          widget.fn();

          HapticFeedback.mediumImpact();
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
