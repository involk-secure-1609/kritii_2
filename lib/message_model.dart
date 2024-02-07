import 'dart:convert';

Message MessageFromJson(String str) => Message.fromJson(json.decode(str));

String MessageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message(
      {required this.message, required this.senderId, required this.timeSent});

  String message;
  DateTime timeSent;
  String senderId;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'],
      senderId: json['senderId'],
      timeSent: DateTime.parse(json["timeSent"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "senderId": senderId,
    "message": message,
    "timeSent":timeSent,
  };
}
