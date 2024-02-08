import 'package:flutter/material.dart';
import 'package:untitled3/Screens/synergy_comments.dart';
import 'package:untitled3/Widgets/skill_container.dart';
import 'container1.dart';

class SynergyContainer extends StatelessWidget {
  final String title;
  final String review;
  final String user;
  final List<String> skills;
  final String comments_size;

  const SynergyContainer(
      {super.key,
      required this.title,
      required this.review,
      required this.user,
      required this.comments_size,
      required this.skills});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the CourseReviewScreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SynergyComments(title: title, review: review, user: user, comments_size: comments_size, skills:skills,)),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: CommonContainer(
          children: [
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
              children: skills.map((skill) {
                return Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: SkillContainer(
                    skill: skill,
                    fontSize: 11,
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/circular_user.png',
                  height: 25,
                  width: 25,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  user,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(238, 238, 238, 1),
                  ),
                ),
                SizedBox(
                  width: 35,
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
            ),
          ],
        ),
      ),
    );
  }
}
