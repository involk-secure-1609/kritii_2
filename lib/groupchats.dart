import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled3/splash.dart';
import 'groupmessages.dart';

class GroupChatScreen extends StatefulWidget {
  @override
  _GroupChatScreen createState() => _GroupChatScreen();
}

class _GroupChatScreen extends State<GroupChatScreen> {
  TextEditingController textController1 = TextEditingController();
  final Stream<QuerySnapshot> _chatStream =
  FirebaseFirestore.instance.collection('GroupConversations').snapshots();

  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    double screenHeight=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: const Icon(
          Icons.graphic_eq,
          color: Color.fromRGBO(224, 140, 56, 1),
        ),
        backgroundColor: Color.fromRGBO(85, 85, 85, 1),
        title: Center(
          child: Container(
            width: screenWidth*0.8, // Adjust the width as needed
            decoration: BoxDecoration(
              color: Color.fromRGBO(102, 102, 102, 1),
              borderRadius:
              BorderRadius.circular(30.0), // Set the desired radius
            ),
            child: TextField(
              controller: textController1,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none, // Remove the default border
              ),
              style: TextStyle(color: Colors.black), // Set the text color
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Color.fromRGBO(224, 140, 56, 1),
            ),
            onPressed: () {
              // Handle the action when the three dots icon is pressed
              print('Three dots icon pressed');
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _chatStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print(snapshot);

            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            print(snapshot);
            return SplashScreen1();
          }
          print(snapshot);


          return ListView(
            children: snapshot.data!.docs.where((DocumentSnapshot document) {
              Map<String, dynamic> data =
              document.data()! as Map<String, dynamic>;
              var isContain = false;
              String userId = "user1";
              if (data['members'].includes(userId)) {
                isContain = true;
              }
              return isContain;
            }).map((DocumentSnapshot document) {
              String GroupId = document.id;
              Map<String, dynamic> data =
              document.data()! as Map<String, dynamic>;
              String lastMsg =data['lastMessage'];
              Timestamp time=data['lastTime'];
              DateTime dateTime = time.toDate();
              String formattedDateTime = DateFormat('dd/MM/yyyy').format(dateTime);

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GroupMessageScreen(
                        groupId: GroupId,
                        team: data['chatName'],
                      ),
                    ),
                  );
                },
                child: Container(
                  width: screenWidth*0.8,
                  height: screenHeight*0.1,
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
                  padding: EdgeInsets.fromLTRB(5, 5, 20, 20),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(85, 85, 85, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        child: Icon(
                            Icons.person), // You can use any icon you prefer
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                              child: Row(
                                children: [
                                  Text(
                                    data['chatName'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 120,),
                                  Text(
                                    formattedDateTime,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            RichText(
                              maxLines: 1,
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: data['lastSender'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' : ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: data['lastMessage'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  // Add more TextSpan widgets for additional texts with different styles
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
