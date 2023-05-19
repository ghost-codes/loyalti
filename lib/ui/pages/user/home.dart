import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loyalty/core/models/menu.dart';
import 'package:loyalty/core/network/selis_api.dart';
import 'package:loyalty/core/service/injection_container.dart';
import 'package:loyalty/ui/components/food_card.dart';
import 'package:loyalty/ui/components/svg_button.dart';
import 'package:loyalty/utils/data/data_page.dart';
import 'package:loyalty/utils/text.dart';
import 'package:loyalty/utils/typography.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends DataPage<HomePage> {
  late Menu menu;

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: SvgButton(
          icon: "assets/svg/menu.svg",
          onPressed: () {},
        ),
        actions: [
          SvgButton(
            icon: "assets/svg/notification.svg",
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent.shade400,
        child: SvgPicture.asset(
          "assets/svg/cart.svg",
          width: 25,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              "Welcome, Adele",
              style: LoyaltiTypography.title(fontSize: 26),
            ),
            const SizedBox(height: 20),
            Text(
              "Today's Special",
              style: LoyaltiTypography.title(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            if (menu.special != null)
              FoodCard(
                food: menu.special!,
              ),
            const SizedBox(height: 30),
            Text(
              "Menu",
              style: LoyaltiTypography.title(fontSize: 22),
            ),
            Row(
              children: [
                _SectionButton(
                  isSelected: true,
                  icon: "assets/svg/food.svg",
                  name: "Food",
                  onPressed: () {},
                ),
                const SizedBox(width: 15),
                _SectionButton(
                  isSelected: false,
                  icon: "assets/svg/drinks.svg",
                  name: "Drinks",
                  onPressed: () {},
                ),
              ],
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: menu.food.length,
              itemBuilder: (context, index) => FoodCard(food: menu.food[index]),
              separatorBuilder: (context, index) => const SizedBox(height: 10),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Future<void> onLoad() async {
    menu = await getIt.get<SelisApi>().menu();
  }

  @override
  Future<void> onRefresh() async {}
}

class _SectionButton extends StatelessWidget {
  const _SectionButton({
    required this.icon,
    required this.name,
    required this.onPressed,
    required this.isSelected,
  });
  final String icon;
  final String name;
  final Function onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? Colors.pinkAccent.shade400 : Colors.white,
          border: !isSelected
              ? Border.all(
                  color: Colors.black,
                )
              : null,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 20,
              color: isSelected ? Colors.white : Colors.black,
            ),
            const SizedBox(width: 10),
            LoyaltiText.bodyText(name, color: isSelected ? Colors.white : Colors.black),
          ],
        ),
      ),
    );
  }
}
