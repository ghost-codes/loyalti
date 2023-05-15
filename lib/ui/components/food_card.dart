import 'package:flutter/material.dart';
import 'package:loyalty/ui/components/food_details.dart';
import 'package:loyalty/utils/text.dart';
import 'package:loyalty/utils/typography.dart';

class FoodItem {
  final String image = "assets/imgs/food.jpg";
  final String name = "Vegetable rice";
  final String desc =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.";
  final double price = 35.0;
  final String curr = "GHS";
}

class FoodCard extends StatelessWidget {
  const FoodCard({super.key});

  @override
  Widget build(BuildContext context) {
    final FoodItem food = FoodItem();
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isDismissible: true,
          builder: (context) => FoodDetailsSheet(
            food: food,
          ),
        );
      },
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 150,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    food.image,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LoyaltiText.sectionTitle(food.name),
                    Expanded(
                      child: Text(
                        food.desc,
                        style: LoyaltiTypography.bodyText(),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    LoyaltiText.sectionTitle("${food.curr}${food.price}")
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
