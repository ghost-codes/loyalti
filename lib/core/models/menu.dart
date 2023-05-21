import 'package:json_annotation/json_annotation.dart';

part 'menu.g.dart';

@JsonSerializable()
class MenuItem {
  @JsonKey(name: "image_url")
  final String imageUrl;
  final String name;
  final String description;
  @JsonKey(name: "menu_item_skus")
  final List<MenuItemSku> skus;

  MenuItem(
    this.imageUrl,
    this.name,
    this.description,
    this.skus,
  );

  double? get displayPrice {
    final prices = skus.map((e) => e.price).toList();
    prices.sort();
    if (prices.isNotEmpty) return prices[0];
    return null;
  }

  factory MenuItem.fromJson(Map<String, dynamic> json) => _$MenuItemFromJson(json);

  Map<String, dynamic> toJson() => _$MenuItemToJson(this);
}

@JsonSerializable()
class MenuItemSku {
  final String name;
  final double price;

  MenuItemSku(this.name, this.price);

  factory MenuItemSku.fromJson(Map<String, dynamic> json) => _$MenuItemSkuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuItemSkuToJson(this);
}

@JsonSerializable()
class Menu {
  final MenuItem? special;
  final List<MenuItem> food;
  final List<MenuItem> drinks;

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  Menu(this.special, this.food, this.drinks);

  @override
  Map<String, dynamic> toJson() => _$MenuToJson(this);
}
