import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Widgets/container1.dart';
import '../Widgets/skill_container.dart';
import '../database_provider.dart';

class CourseReviewComments extends StatefulWidget {
  final String title;
  final String course;
  final String review;
  final String user;
  final String comments_size;

  const CourseReviewComments(
      {super.key,
      required this.title,
      required this.course,
      required this.review,
      required this.user,
      required this.comments_size});

  @override
  State<CourseReviewComments> createState() => _CourseReviewComments();
}

class _CourseReviewComments extends State<CourseReviewComments> {
  late final Stream<QuerySnapshot> comment_stream;
  late final String review_title;
  late final String review_course;
  late final String review_message;
  late final String review_user;

  @override
  void initState() {
    super.initState();
    comment_stream = FirebaseFirestore.instance
        .collection('CourseReviewComments')
        .doc('PH3LGMJWduVZVo9R3ewQ')
        .collection('comments')
        .snapshots();
    review_course = widget.course;
    review_message = widget.review;
    review_title = widget.title;
    review_user = widget.user;
  }
  DatabaseProvider databaseProvider = DatabaseProvider();
  TextEditingController textController = TextEditingController();
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
                SkillContainer(
                  skill: review_course,
                  fontSize: 12,
                ),
                SizedBox(height: 10),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(85, 85, 85, 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Add Comments',
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: textController,
                          maxLines: 10,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Type here...',
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        ElevatedButton(
                          onPressed: () {

                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Send Comment',
                            style: TextStyle(color: Colors.black87),
                          ),
                        ),
                        // ElevatedButton(
                        //   onPressed: () {
                        //     Navigator.of(context).pop();
                        //   },
                        //   child: Text(
                        //     'Cancel',
                        //     style: TextStyle(color: Colors.black87),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.orange,
        ),
      ),
    );
  }
}
