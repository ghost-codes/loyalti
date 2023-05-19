import 'package:json_annotation/json_annotation.dart';

part 'menu.g.dart';

@JsonSerializable()
class MenuItem {
  final String image = "assets/imgs/food.jpg";
  final String name;
  final String description;

  MenuItem(
    this.name,
    this.description,
  );

  factory MenuItem.fromJson(Map<String, dynamic> json) => _$MenuItemFromJson(json);

  Map<String, dynamic> toJson() => _$MenuItemToJson(this);
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
