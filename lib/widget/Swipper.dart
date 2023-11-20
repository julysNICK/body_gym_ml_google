import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Swipper extends StatelessWidget {
  const Swipper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      width: 300,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFA4BFCC).withOpacity(0.8),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Icon(
              Icons.swipe,
              color: Colors.white,
              size: 20,
            ),
          )
        ],
      ),
    );
  }
}
