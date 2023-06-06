import 'package:json_annotation/json_annotation.dart';


part 'category.g.dart';

@JsonSerializable()
class Category {
  int? id;
  String? name;
  String? image_url;

  Category({this.id, this.name, this.image_url});
  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}