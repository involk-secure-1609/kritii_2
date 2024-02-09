import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'chat_model.dart';
import 'message_model.dart';
import 'comment_model.dart';

class DatabaseProvider {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> sendMessage(String groupId, bool isGroup, Message message) async {
    if (isGroup) {
      CollectionReference collectionRef = db.collection("GroupConversations");
      DocumentReference docRef = collectionRef.doc(groupId);
      debugPrint("sent");
      debugPrint(message.toString());
      CollectionReference messages = docRef.collection("messages");
      await messages.add(message.toJson());
    } else {
      CollectionReference collectionRef = db.collection("DmConversations");
      DocumentReference docRef = collectionRef.doc(groupId);
      debugPrint("sent");
      debugPrint(message.toString());
      CollectionReference messages = docRef.collection("messages");
      await messages.add(message.toJson());
    }
  }

  Future<void> sendComments(String docId, bool isSynergy, Comment comment) async {
    if (isSynergy) {
      CollectionReference collectionRef = db.collection("SynergyComments");
      DocumentReference docRef = collectionRef.doc(docId);
      CollectionReference comments = docRef.collection("comments");
      await comments.add(comment.toJson());
    } else {
      CollectionReference collectionRef = db.collection("CourseReviewComments");
      DocumentReference docRef = collectionRef.doc(docId);
      CollectionReference comments = docRef.collection("comments");
      await comments.add(comment.toJson());
    }
  }

  Future<Stream<List<Message>>> getDmMessages(String groupId) async {
    CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("DmConversations");
    DocumentReference dbRef = collectionRef.doc(groupId);
    CollectionReference messages = dbRef.collection('messages');

    return messages.snapshots().map((QuerySnapshot querySnapshot) {
      List<Message> messageList = [];

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        // Assuming you have a constructor in your Message class that accepts a map
        Message message = Message.fromJson(data);
        messageList.add(message);
      }

      return messageList;
    });
  }

  Future<Stream<List<Message>>> getGroupMessages(String groupId) async {
    CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("GroupConversations");
    DocumentReference dbRef = collectionRef.doc(groupId);
    CollectionReference messages = dbRef.collection('messages');

    return messages.snapshots().map((QuerySnapshot querySnapshot) {
      List<Message> messageList = [];

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        // Assuming you have a constructor in your Message class that accepts a map
        Message message = Message.fromJson(data);
        messageList.add(message);
      }

      return messageList;
    });
  }

  Stream<List<Conversation>> getDmConversations(String userId) {
    CollectionReference conversations = db.collection("DmConversations");

    return conversations.snapshots().map((QuerySnapshot querySnapshot) {
      List<Conversation> conversationList = [];

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        if (data['user1'] == userId || data['user2'] == userId) {
          Conversation conversation = Conversation.fromJson(data);
          conversationList.add(conversation);
        }
      }
      return conversationList;
    });
  }

  Future<Stream<List<Conversation>>> getGroupConversations(
      String userId) async {
    CollectionReference conversations = db.collection("GroupConversations");
    return conversations.snapshots().map((QuerySnapshot querySnapshot) {
      List<Conversation> convos = [];

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        List<String> members = List<String>.from(data['members'] ?? []);

        if (members.contains(userId)) {
          Conversation conversation = Conversation.fromJson(data);
          convos.add(conversation);
        }
      }
      return convos;
    });
  }
}
