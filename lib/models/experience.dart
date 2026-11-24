import 'package:json_annotation/json_annotation.dart';

part 'experience.g.dart';

/// Portfolio project synchronized with the Django REST Framework API.
@JsonSerializable(fieldRename: FieldRename.snake)
class Experience {
  const Experience({
    this.id, 
    required this.title,
    required this.organization,
    this.orgLogo = '',
    this.location = '',
    required this.description,
    required this.startedAt,
    this.endedAt,
    this.skills = '',
    this.likedBy = const [],
  });

  factory Experience.fromJson(Map<String, dynamic> json) => 
    _$ExperienceFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;
  @JsonKey(includeToJson: false)
  final List<int> likedBy;
  
  final String title;
  final String organization;
  final String description;
  final String orgLogo;
  final String? location;
  final DateTime startedAt;
  final DateTime? endedAt;
  final String skills;

  Map<String, dynamic> toJson() => _$ExperienceToJson(this);
}