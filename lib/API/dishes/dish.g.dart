// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dish.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dish _$DishFromJson(Map<String, dynamic> json) => Dish(
      id: json['id'] as int?,
      name: json['name'] as String?,
      price: json['price'] as int?,
      weight: json['weight'] as int?,
      description: json['description'] as String?,
      image_url: json['image_url'] as String?,
      tegs: (json['tegs'] as List<dynamic>?)?.map((e) => e as String).toSet(),
    );

Map<String, dynamic> _$DishToJson(Dish instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'weight': instance.weight,
      'description': instance.description,
      'image_url': instance.image_url,
      'tegs': instance.tegs,
    };
