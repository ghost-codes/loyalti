import 'package:json_annotation/json_annotation.dart';

part 'menu.g.dart';

@JsonSerializable()
class MenuItem {
  final String id;
  @JsonKey(name: "image_url")
  final String imageUrl;
  final String name;
  final String description;
  @JsonKey(name: "menu_item_skus")
  late final List<MenuItemSku> skus;
  @JsonKey(name: "special_day")
  final String? specialDay;

  MenuItem(
    this.imageUrl,
    this.name,
    this.description,
    List<MenuItemSku> skus,
    int id,
    this.specialDay,
  ) : id = id.toString() {
    skus.sort((a, b) => a.price.compareTo(b.price));
    this.skus = skus;
  }

  double? get displayPrice {
    if (skus.isNotEmpty) return skus.first.price;
    return null;
  }

  factory MenuItem.fromJson(Map<String, dynamic> json) => _$MenuItemFromJson(json);

  Map<String, dynamic> toJson() => _$MenuItemToJson(this);
}

@JsonSerializable()
class MenuItemSku {
  final String id;
  final String name;
  final double price;

  MenuItemSku(this.name, this.price, int id) : id = id.toString();

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
