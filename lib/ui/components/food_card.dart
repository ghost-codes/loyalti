import 'package:flutter/material.dart';
import 'package:loyalty/core/models/menu.dart';
import 'package:loyalty/ui/components/food_details.dart';
import 'package:loyalty/utils/text.dart';
import 'package:loyalty/utils/typography.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({
    super.key,
    required this.food,
  });

  final MenuItem food;

  @override
  Widget build(BuildContext context) {
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
                        food.description,
                        style: LoyaltiTypography.bodyText(),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    LoyaltiText.sectionTitle("GHS 35.0")
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
