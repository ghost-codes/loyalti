// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) => MenuItem(
      json['name'] as String,
      json['description'] as String,
    );

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
    };

Menu _$MenuFromJson(Map<String, dynamic> json) => Menu(
      json['special'] == null ? null : MenuItem.fromJson(json['special'] as Map<String, dynamic>),
      (json['food'] as List<dynamic>)
          .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['drinks'] as List<dynamic>)
          .map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'special': instance.special,
      'food': instance.food,
      'drinks': instance.drinks,
    };
