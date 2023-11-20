import 'package:flutter/cupertino.dart';

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      width: 300,
      height: 500,
      bottom: 0,
      child: Image.asset(
        'assets/images/frontmuscleV3.png',
        width: 500,
      ),
    );
  }
}
