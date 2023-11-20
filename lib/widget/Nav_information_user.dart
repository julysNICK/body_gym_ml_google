import 'package:body_gym/widget/Avatar_and_name.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavInformationUser extends StatelessWidget {
  const NavInformationUser({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFA4BFCC).withOpacity(0.55),
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AvatarAndName(),
            Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
