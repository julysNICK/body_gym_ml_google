import 'package:body_gym/screen/Profile.dart';
import 'package:body_gym/screen/VideoList.dart';
import 'package:body_gym/screen/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    super.key,
    required this.displayWidth,
  });

  final double displayWidth;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final listPage = [
      {
        "icon": Icons.home,
        "title": "Home",
        "page": const HomeGym(),
      },
      {
        "icon": Icons.video_collection,
        "title": "Videos",
        "page": const VideoList(),
      },
      {
        "icon": Icons.person_3_rounded,
        "title": "Profile",
        "page": const Profile(),
      }
    ];

    return Container(
      margin: EdgeInsets.all(widget.displayWidth * 0.05),
      height: widget.displayWidth * .155,
      width: 10,
      decoration: BoxDecoration(
        color: const Color(0xFFA4BFCC).withOpacity(0.55),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(
          width: 50,
        ),
        itemCount: listPage.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: widget.displayWidth * 0.05),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            setState(() {
              currentIndex = index;
              HapticFeedback.mediumImpact();

              //change page

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => listPage[index]["page"] as Widget,
                ),
              );
            });

            //change page with delay
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Stack(
            children: [
              Center(
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  margin: const EdgeInsets.only(right: 10),
                  curve: Curves.fastOutSlowIn,
                  height: widget.displayWidth * 0.14,
                  width: widget.displayWidth * 0.14,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: currentIndex == index
                          ? Colors.white
                          : Colors.transparent,
                      width: 2,
                    ),
                    color: currentIndex == index
                        ? const Color(0xFFA4BFCC)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Icon(
                      listPage[index]["icon"] as IconData,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
