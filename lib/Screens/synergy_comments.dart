import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/Widgets/container1.dart';
import 'package:untitled3/Widgets/skill_container.dart';

class SynergyComments extends StatefulWidget {
  final String title;
  final String review;
  final String user;
  final List<String> skills;
  final String comments_size;

  const SynergyComments(
      {super.key,
        required this.title,
        required this.review,
        required this.user,
        required this.comments_size, required this.skills});

  @override
  State<SynergyComments> createState() => _SynergyComments();
}

class _SynergyComments extends State<SynergyComments> {
  late final Stream<QuerySnapshot> comment_stream;
  late final String review_title;
  late final List<String> review_skills;
  late final String review_message;
  late final String review_user;

  @override
  void initState() {
    super.initState();
    comment_stream = FirebaseFirestore.instance
        .collection('SynergyComments')
        .doc('lEzHhcJ18wSAjhlw5IQ3')
        .collection('comments')
        .snapshots();
    review_skills= widget.skills;
    review_message = widget.review;
    review_title = widget.title;
    review_user = widget.user;
  }

  ScrollController scrollController = ScrollController();

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding:
            const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review_title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(224, 140, 56, 1),
                  ),
                ),
                SizedBox(height: 10),
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
                      review_user,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(240, 238, 238, 1),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // CommonContainer(
                //   children: [
                //     Text(
                //       review_message,
                //       style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 20,
                //           fontWeight: FontWeight.bold),
                //     ),
                //   ],
                // ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white), // White border
                  ),
                  padding: EdgeInsets.all(8.0),
                  // Padding for spacing between text and border
                  child: Text(
                    review_message,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // const Text(
                //   "Comments",
                //   style: TextStyle(
                //       color: Color.fromRGBO(224, 140, 56, 1),
                //       fontSize: 24,
                //       fontWeight: FontWeight.bold),
                // ),
                Row(
                  children: review_skills.map((skill) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: SkillContainer(
                        skill: skill,
                        fontSize: 11,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                const Icon(
                  Icons.comment_outlined,
                  size: 26,
                  color: Color.fromRGBO(224, 140, 56, 1),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: comment_stream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    return ListView(
                      shrinkWrap: true,
                      controller: scrollController, // Add this line
                      children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CommonContainer(
                              children: [
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
                                      data['senderId'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(238, 238, 238, 1),
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  data['comment'],
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(238, 238, 238, 1),
                                  ),
                                )
                              ],
                            ));
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}