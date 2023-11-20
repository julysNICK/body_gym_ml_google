import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListHelp extends StatelessWidget {
  const ListHelp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      width: 50,
      height: 200,
      child: Container(
          height: 200,
          width: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFA4BFCC).withOpacity(0.8),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1.2,
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/man.jpg'),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/man.jpg'),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/man.jpg'),
                  ),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/man.jpg'),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
