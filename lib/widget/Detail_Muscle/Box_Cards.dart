// ignore: file_names
import 'package:body_gym/widget/Detail_Muscle/Card_tutorial.dart';
import 'package:flutter/material.dart';

class BoxCards extends StatefulWidget {
  List<Map<String, dynamic>> listTutorial = [];
  BoxCards({super.key, required this.listTutorial});

  @override
  State<BoxCards> createState() => _BoxCardsState();
}

class _BoxCardsState extends State<BoxCards> {
  void tranverseList() {
    for (var i = 0; i < widget.listTutorial.length; i++) {
      print(widget.listTutorial[i]);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tranverseList();
  }

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
                itemCount: widget.listTutorial.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => CardTutorial(
                  title: widget.listTutorial[index]["title"],
                  title2: widget.listTutorial[index]["channel"],
                  thumUrl: widget.listTutorial[index]["thumb"],
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
