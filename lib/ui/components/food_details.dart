import 'package:flutter/material.dart';
import 'package:loyalty/ui/components/food_card.dart';
import 'package:loyalty/ui/components/primaryButton.dart';
import 'package:loyalty/ui/components/svg_button.dart';
import 'package:loyalty/utils/text.dart';
import 'package:loyalty/utils/typography.dart';

class FoodDetailsSheet extends StatelessWidget {
  const FoodDetailsSheet({super.key, required this.food});

  final FoodItem food;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 200),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: SafeArea(
          top: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 150,
                child: Row(
                  children: [
                    SizedBox(
                      height: 150,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            food.image,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
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
                      ],
                    ))
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                constraints: const BoxConstraints(maxHeight: 230),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (_, index) => Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: LoyaltiText.bodyText("w/ half chicken tigh")),
                          SizedBox(
                            // width: 100,
                            child: Row(
                              children: [
                                LoyaltiText.sectionTitle("GHS 35"),
                                const SizedBox(width: 15),
                                SvgButton(
                                    icon: "assets/svg/minus.svg", width: 15, onPressed: () {}),
                                const SizedBox(width: 15),
                                LoyaltiText.sectionTitle("0"),
                                const SizedBox(width: 15),
                                SvgButton(icon: "assets/svg/plus.svg", width: 15, onPressed: () {})
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LoyaltiText.sectionTitle("Continue Shopping:"),
                  PrimaryButtonWidget(
                    title: "Checkout",
                    // width: 0,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
