import 'package:json_annotation/json_annotation.dart';

part 'dish.g.dart';

@JsonSerializable()
class Dish {
  int? id;
  String? name;
  int? price;
  int count = 1;
  int? weight;
  String? description;
  String? image_url;
  Set<String>? tegs;


  Dish({this.id, this.name, this.price, this.weight, this.description, this.image_url, this.tegs});
  factory Dish.fromJson(Map<String, dynamic> json) => _$DishFromJson(json);
  Map<String, dynamic> toJson() => _$DishToJson(this);
}