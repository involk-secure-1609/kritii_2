import 'dart:convert';

Conversation coversationFromJson(String str) =>
    Conversation.fromJson(json.decode(str));

String ConversationToJson(Conversation data) => json.encode(data.toJson());

class Conversation {
  Conversation({
    required this.chatName,
    required this.members,
  });

  String chatName;
  List<String> members;

  factory Conversation.fromJson(Map<dynamic, dynamic> json) {
    return Conversation(
      chatName: json['chatName'],
      members: List<String>.from(json["members"].map((x) => x)),
    );
  }

  Map<dynamic, dynamic> toJson() => {
    "chatName": chatName,
    "members": List<dynamic>.from(members.map((x) => x)),
  };
}
