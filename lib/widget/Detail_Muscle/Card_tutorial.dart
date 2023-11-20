import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardTutorial extends StatelessWidget {
  String title;
  CardTutorial({
    super.key,
    this.title = "Tutorial 1",
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFA4BFCC),
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Center(
            child: Text(
              "1",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: const Text(
          "Tutorial 1",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(
          Icons.play_arrow,
          color: Colors.black,
        ),
      ),
    );
  }
}
