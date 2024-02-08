import 'package:untitled3/models/project.dart';

class UserInfo {
  final String name;
  final String rollNumber;
  final List<dynamic> skills;
  final List<String> courses;
  final String email;
  final String? url;
  final String program;
  final List<Project>? projects;

  UserInfo(
      {required this.name,
      required this.rollNumber,
      required this.skills,
      required this.courses,
      required this.email,
      required this.url,
      required this.program,
      required this.projects});
  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        name: json['name'] as String,
        rollNumber: json['rollNumber'] as String,
        skills: json['skills'] as List<dynamic>,
        courses:
            (json['courses'] as List<dynamic>).map((e) => e as String).toList(),
        email: json['email'] as String,
        url: json['url'] as String?,
        program: json['program'] as String,
        projects: (json['projects'] as List<dynamic>?)
            ?.map((e) => Project.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  Map<String, dynamic> toJson(UserInfo instance) => <String, dynamic>{
        'name': instance.name,
        'rollNumber': instance.rollNumber,
        'skills': instance.skills,
        'courses': instance.courses,
        'email': instance.email,
        'url': instance.url,
        'program': instance.program,
        'projects': instance.projects,
      };
}
