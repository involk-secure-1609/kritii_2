import 'package:flutter/material.dart';
import '../Widgets/course_review_container.dart';
class CourseReviewScreen extends StatefulWidget {
  const CourseReviewScreen({super.key});

  @override
  State<CourseReviewScreen> createState() => _CourseReviewScreen();
}

class _CourseReviewScreen extends State<CourseReviewScreen> {
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
                return CourseReviewContainer(
                    title: "My experience with CS101",
                    course: "CS101:Basic Computing",
                    review: "Why are we studying this course, I dont know why we are doing this i want to stop studying pleaseeeeeeeeeeeeeeee",
                    user: "Kevin Jacob(Btech,CSE)",
                    comments_size: "109",
                    rating: "4.9");
              } else if (index == 1) {
                return CourseReviewContainer(
                    title: "My experience with CS101",
                    course: "CS101:Basic Computing",
                    review: "Why are we studying this course",
                    user: "Kevin Jacob(Btech,CSE)",
                    comments_size: "109",
                    rating: "4.9");
              } else {
                return CourseReviewContainer(
                    title: "My experience with CS101",
                    course: "CS101:Basic Computing",
                    review: "Why are we studying this course",
                    user: "Kevin Jacob(Btech,CSE)",
                    comments_size: "109",
                    rating: "4.9");
              }
            },
          ),
        ),
      ),
    );
  }
}
