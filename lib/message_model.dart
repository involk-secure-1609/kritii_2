import 'dart:convert';

Message MessageFromJson(String str) => Message.fromJson(json.decode(str));

String MessageToJson(Message data) => json.encode(data.toJson());

class Message {
  Message(
      {required this.message, required this.senderId, required this.timeSent,required this.image});

  String message;
  String image;
  DateTime timeSent;
  String senderId;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'],
      image:json['image'],
      senderId: json['senderId'],
      timeSent: DateTime.parse(json["timeSent"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "image":image,
    "senderId": senderId,
    "message": message,
    "timeSent":timeSent,
  };
}
