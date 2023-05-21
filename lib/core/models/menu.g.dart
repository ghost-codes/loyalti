// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) => MenuItem(
      json['image_url'] as String,
      json['name'] as String,
      json['description'] as String,
      (json['menu_item_skus'] as List<dynamic>)
          .map((e) => MenuItemSku.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuItemToJson(MenuItem instance) => <String, dynamic>{
      'image_url': instance.imageUrl,
      'name': instance.name,
      'description': instance.description,
      'menu_item_skus': instance.skus,
    };

MenuItemSku _$MenuItemSkuFromJson(Map<String, dynamic> json) => MenuItemSku(
      json['name'] as String,
      (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$MenuItemSkuToJson(MenuItemSku instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
    };

Menu _$MenuFromJson(Map<String, dynamic> json) => Menu(
      json['special'] == null
          ? null
          : MenuItem.fromJson(json['special'] as Map<String, dynamic>),
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
