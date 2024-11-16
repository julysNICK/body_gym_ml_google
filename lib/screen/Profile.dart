import 'package:body_gym/repositories/UserRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserRepository userRepository = UserRepository();

  User? userLog = FirebaseAuth.instance.currentUser;

  Future getUser() async {
    try {
      var user = await userRepository.getCurrentUser();

      print(user!.email);

      setState(() {
        userLog = user;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
            ),
            Information(
              title: "Email",
              value: userLog!.email.toString(),
            ),
            Information(
              title: "Height",
              value: "90kg",
            ),
            Information(
              title: "Weight",
              value: "180cm",
            ),
            Information(
              title: "Age",
              value: "20",
            ),
            Information(
              title: "BMI",
              value: "20",
            ),
            Information(
              title: 'Start using app',
              value: '20/10/2021',
            )
          ],
        ),
      ),
    );
  }
}

class Information extends StatefulWidget {
  String title;
  String value;
  Information({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${widget.title}: ",
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              widget.value,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
