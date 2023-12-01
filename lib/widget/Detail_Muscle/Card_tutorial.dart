import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardTutorial extends StatelessWidget {
  String title;
  String title2;
  String thumUrl;
  CardTutorial({
    super.key,
    this.title = "Tutorial 1",
    this.title2 = "Tutorial 2",
    this.thumUrl = "https://i.ytimg.com/vi/2Vv-BfVoq4g/maxresdefault.jpg",
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
          child: Center(
            child: Image.network(
              thumUrl,
              fit: BoxFit.cover,
              height: 50,
              width: 50,
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
        subtitle: Text(
          title2,
          style: const TextStyle(
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
