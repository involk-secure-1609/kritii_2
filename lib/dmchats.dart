import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled3/groupchats.dart';
import 'dmmessages.dart';

class DmChatScreen extends StatefulWidget {
  @override
  _DmChatScreen createState() => _DmChatScreen();
}

class _DmChatScreen extends State<DmChatScreen> {
  TextEditingController textController1 = TextEditingController();
  final Stream<QuerySnapshot> _chatStream =
      FirebaseFirestore.instance.collection('DmConversations').snapshots();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.width;
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
            width: screenWidth * 0.8, // Adjust the width as needed
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
              Icons.group,
              color: Color.fromRGBO(224, 140, 56, 1),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => GroupChatScreen()
                ),
              );
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
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Something went wrong');
          }

          return ListView(
            children: snapshot.data!.docs.where((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

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
              String lastMsg = data['lastMessage'];
              Timestamp time = data['lastTime'];
              DateTime dateTime = time.toDate();
              String formattedDateTime =
                  DateFormat('dd/MM/yyyy').format(dateTime);

              if (data['user1'] == "user1") {
                return Flexible(
                  child: GestureDetector(
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
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.22,
                      margin: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                      padding: const EdgeInsets.fromLTRB(5, 5, 20, 20),
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
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                                  child: Row(
                                    children: [
                                      Text(
                                        data['user2'],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 70,
                                      ),
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
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const TextSpan(
                                        text: ' : ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      TextSpan(
                                        text: data['lastMessage'],
                                        style: const TextStyle(
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
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.22,
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                                child: Row(
                                  children: [
                                    Text(
                                      data['user2'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 100,
                                    ),
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
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const TextSpan(
                                      text: ' : ',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    TextSpan(
                                      text: data['lastMessage'],
                                      style: const TextStyle(
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
              }
            }).toList(),
          );
        },
      ),
    );
  }
}
