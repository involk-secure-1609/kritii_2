import 'dart:convert';

Comment CommentFromJson(String str) => Comment.fromJson(json.decode(str));

String CommentToJson(Comment data) => json.encode(data.toJson());

class Comment {
  Comment(
      {required this.comment, required this.senderId});

  String comment;
  String senderId;

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      comment: json['comment'],
      senderId: json['senderId'],
    );
  }

  Map<String, dynamic> toJson() => {
    "senderId": senderId,
    "comment": comment,
  };
}
