// ignore: file_names
import 'package:body_gym/widget/Detail_Muscle/Card_tutorial.dart';
import 'package:flutter/material.dart';

class BoxCards extends StatelessWidget {
  const BoxCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          children: [
            // List of tutorial
            Expanded(
              child: ListView.separated(
                key: const PageStorageKey("list_tutorial"),
                physics: const BouncingScrollPhysics(),
                itemCount: 20,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => CardTutorial(
                  title: "Tutorial ${index + 1}",
                ),
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
              ),
            ),

            // Flexible(
            //   child: ListView.builder(
            //     itemCount: 15,
            //     scrollDirection: Axis.vertical,
            //     itemBuilder: (context, index) => CardTutorial(
            //       title: "Tutorial ${index + 1}",
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
