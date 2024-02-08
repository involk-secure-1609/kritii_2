import 'admin.dart';

class Project {
  final String projectName;
  final String description;
  final List<dynamic> skills;
  final List<String>? urls;
  final String duration;
  final bool isActive;
  final String id;
  final List<Admin>? admin;
  final List<String>? starBy;
  final Admin owner;

  Project(
      {required this.projectName,
      required this.description,
      required this.skills,
      required this.urls,
      required this.duration,
      required this.isActive,
      required this.id,
      required this.admin,
      required this.starBy,
      required this.owner});
  factory Project.fromJson(Map<String, dynamic> json) => Project(
        projectName: json['projectName'] as String,
        description: json['description'] as String,
        skills: json['skills'] as List<dynamic>,
        urls:
            (json['urls'] as List<dynamic>?)?.map((e) => e as String).toList(),
        duration: json['duration'] as String,
        isActive: json['isActive'] as bool,
        id: json['_id'] as String,
        admin:
            (json['admin'] as List<dynamic>?)?.map((e) => Admin.fromJson(e as Map<String, dynamic>)).toList(),
        starBy: (json['starBy'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        owner: Admin.fromJson(json['owner']),
      );

  Map<String, dynamic> toJson(Project instance) => <String, dynamic>{
        'projectName': instance.projectName,
        'description': instance.description,
        'skills': instance.skills,
        'urls': instance.urls,
        'duration': instance.duration,
        'isActive': instance.isActive,
        '_id': instance.id,
        'admin': instance.admin,
        'starBy': instance.starBy,
        'owner': instance.owner,
      };
}
