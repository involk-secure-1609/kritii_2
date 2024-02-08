import 'package:flutter/material.dart';
import 'package:untitled3/Screens/course_review.dart';
import 'package:untitled3/Screens/course_review_comments.dart';
import 'package:untitled3/Widgets/skill_container.dart';
import 'container1.dart';

class CourseReviewContainer extends StatelessWidget {
  final String title;
  final String course;
  final String review;
  final String user;
  final String comments_size;
  final String rating;

  const CourseReviewContainer(
      {super.key,
      required this.title,
      required this.course,
      required this.review,
      required this.user,
      required this.comments_size,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      // Navigate to the CourseReviewScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CourseReviewComments(title: title, course: course, review: review, user: user, comments_size: comments_size)),
      );
    },
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: CommonContainer(
          children: [
            SkillContainer(skill: course),
            SizedBox(
              height: 8,
            ),
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(238, 238, 238, 1),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/circular_user.png',
                  height: 15,
                  width: 15,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  user,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(238, 238, 238, 1),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              review,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(238, 238, 238, 1),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                GestureDetector(
                  child: Icon(
                    Icons.keyboard_double_arrow_up_sharp,
                    size: 25,
                    color: Colors.green,
                  ),
                  onTap: (){},
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  child: Icon(
                    Icons.keyboard_double_arrow_down_sharp,
                    size: 25,
                    color: Colors.red,
                  ),
                  onTap: (){},
                ),
                SizedBox(
                  width: 130,
                ),
                Text(
                  comments_size,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromRGBO(238, 238, 238, 1),
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Image.asset(
                  'assets/comment_bubble.png',
                  height: 16,
                  width: 16,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
