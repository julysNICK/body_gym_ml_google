import 'package:body_gym/main.dart';
import 'package:body_gym/widget/Biceps.dart';
import 'package:body_gym/widget/Body.dart';
import 'package:body_gym/widget/Bottom_bar.dart';
import 'package:body_gym/widget/Forearm.dart';
import 'package:body_gym/widget/List_help.dart';
import 'package:body_gym/widget/Nav_information_user.dart';
import 'package:body_gym/widget/Shoulder.dart';

import 'package:body_gym/widget/Chest.dart';
import 'package:body_gym/widget/Swipper.dart';
import 'package:flutter/material.dart';

class HomeGym extends StatefulWidget {
  const HomeGym({super.key});

  @override
  State<HomeGym> createState() => _HomeGymState();
}

class _HomeGymState extends State<HomeGym> {
  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomBar(displayWidth: displayWidth),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const NavInformationUser(),
                SizedBox(
                  width: 300,
                  height: 520,
                  child: Stack(
                    children: [
                      const Body(),
                      const Shoulder(),
                      Chest(
                        fn: () {},
                      ),
                      const biceps(),
                      const Forearm(),
                      const Swipper(),
                      const ListHelp()
                      // popupMuscle(openBox: openBox),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
