import 'package:flutter/material.dart';
import 'package:untitled3/Widgets/synergy_container.dart';

class SynergyScreen extends StatefulWidget {
  const SynergyScreen({super.key});

  @override
  State<SynergyScreen> createState() => _SynergyScreen();
}

class _SynergyScreen extends State<SynergyScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
          child: ListView.builder(
            itemCount: 3, // Number of items in the list
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return SynergyContainer(
                  title: "Carousel code not working",
                  review:
                      "Why are we studying this course, I dont know why we are doing this i want to stop studying pleaseeeeeeeeeeeeeeee",
                  user: "Kevin Jacob(Btech,CSE)",
                  comments_size: "109",
                  skills: ["CSS", "Javascript", "React"],
                );
              } else if (index == 1) {
                return SynergyContainer(
                  title: "Carousel code not working",
                  review: "Why are we studying this course",
                  user: "Kevin Jacob(Btech,CSE)",
                  comments_size: "109",
                  skills: ["CSS", "NodeJs", "React"],
                );
              } else {
                return SynergyContainer(
                  title: "Carousel code not working",
                  review: "Why are we studying this course",
                  user: "Kevin Jacob(Btech,CSE)",
                  comments_size: "109",
                  skills: ["CSS", "Flutter"],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
