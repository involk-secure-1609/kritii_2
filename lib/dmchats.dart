import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/splash.dart';
import 'dmmessages.dart';

class DmChatScreen extends StatefulWidget {
  @override
  _DmChatScreen createState() => _DmChatScreen();
}

class _DmChatScreen extends State<DmChatScreen> {
  TextEditingController textController1 = TextEditingController();
  final Stream<QuerySnapshot> _chatStream = FirebaseFirestore.instance.collection('DmConversations').snapshots();

  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    double screenHeight=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: const Icon(
          Icons.keyboard_arrow_left_rounded,
          color: Color.fromRGBO(224, 140, 56, 1),
        ),
        backgroundColor: const Color.fromRGBO(85, 85, 85, 1),
        title: Center(
          child: Container(
            width: screenWidth*0.8, // Adjust the width as needed
            decoration: BoxDecoration(
              color: const Color.fromRGBO(102, 102, 102, 1),
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
              style: const TextStyle(color: Colors.black), // Set the text color
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
          print("_____________________________________________________________");
          print("error>");
          print(snapshot);
          if (snapshot.hasError) {

            print(snapshot);
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            print(snapshot);

            return SplashScreen1();
          }

          return ListView(
            children: snapshot.data!.docs.where((DocumentSnapshot document) {
              print("_____________________________________________________________");
              Map<String, dynamic> data =
              document.data()! as Map<String, dynamic>;

              print(data.runtimeType);
              print(data);
              var isContain = false;
              String userId = "user1";
              if (data['user1'] == userId || data['user2'] == userId) {
                isContain = true;
              }
              return isContain;
            }).map((DocumentSnapshot document) {
              String groupId = document.id;
              Map<String, dynamic> data =
              document.data()! as Map<String, dynamic>;
              if (data['user1'] == "user1") {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DmMessageScreen(
                          groupId: groupId,
                          user: data['user2'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: screenWidth*0.8,
                    height: screenHeight*0.2,
                    margin: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                    padding: const EdgeInsets.fromLTRB(5, 5, 10, 10),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(85, 85, 85, 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          child: Icon(
                              Icons.person), // You can use any icon you prefer
                        ),
                        const SizedBox(width: 10.0),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                          child: Text(
                            data['user1'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DmMessageScreen(
                          groupId: groupId,
                          user: data['user1'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: screenWidth*0.8,
                    height: screenHeight*0.1,
                    margin: const EdgeInsets.all(20.0),
                    padding: const EdgeInsets.fromLTRB(5, 5, 10, 10),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(217, 217, 217, 1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          child: Icon(
                              Icons.person), // You can use any icon you prefer
                        ),
                        const SizedBox(width: 10.0),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                          child: Text(
                            data['user2'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }).toList(),
          );
        },
      ),
    );
  }
}
