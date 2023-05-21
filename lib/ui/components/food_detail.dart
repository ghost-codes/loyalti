import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loyalty/core/models/menu.dart';
import 'package:loyalty/core/network/selis_api.dart';
import 'package:loyalty/core/router/userRouter.dart';
import 'package:loyalty/core/service/injection_container.dart';
import 'package:loyalty/ui/components/pill.dart';
import 'package:loyalty/ui/components/primaryButton.dart';
import 'package:loyalty/ui/components/svg_button.dart';
import 'package:loyalty/utils/data/data_page.dart';
import 'package:loyalty/utils/text.dart';

class FoodDetailPage extends StatefulWidget {
  const FoodDetailPage({super.key, required this.id});

  final String id;

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends DataPage<FoodDetailPage> {
  late MenuItem food;

  late MenuItemSku selectedSku;

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: SvgButton(
          icon: "assets/svg/chevron-left.svg",
          onPressed: () {
            context.goNamed(UserRoutes.home);
          },
        ),
        title: LoyaltiText.title(food.name, color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      buildImageBanner(),
                      const SizedBox(height: 15),
                      LoyaltiText.description(food.description),
                      const SizedBox(height: 15),
                      buildSkuSection(),
                      if (food.extras.isNotEmpty) buildExtrasSection(),
                    ],
                  ),
                ),

                // ==================> Foooter
                buildFooterSection(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildFooterSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            context.pop();
          },
          child: LoyaltiText.bodyText("GHS ${selectedSku.price}",
              fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 40),
        Expanded(
          child: SizedBox(
            height: 50,
            child: PrimaryButtonWidget(
              title: "Add to cart",
            ),
          ),
        ),
      ],
    );
  }

  Widget buildExtrasSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 60,
              child: Divider(
                height: 0,
                color: Colors.grey,
                thickness: 0.5,
              ),
            ),
            const SizedBox(width: 10),
            LoyaltiText.sectionTitle("Extras"),
            const SizedBox(width: 10),
            const SizedBox(
              width: 60,
              child: Divider(
                height: 0,
                color: Colors.grey,
                thickness: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: food.extras.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, index) => Row(
            children: [
              Expanded(
                  child: LoyaltiText.bodyText(
                food.extras[index].name,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              )),
              const SizedBox(width: 10),
              if (food.extras[index].price > 0) ...[
                LoyaltiText.bodyText("GHS ${food.extras[index].price}"),
                const SizedBox(width: 20),
                SvgButton(
                  icon: "assets/svg/minus.svg",
                  onPressed: () {},
                  color: Colors.red,
                  width: 20,
                ),
                const SizedBox(width: 15),
                LoyaltiText.bodyText("0", fontSize: 20),
                const SizedBox(width: 10),
                SvgButton(
                  icon: "assets/svg/plus.svg",
                  color: Colors.green,
                  onPressed: () {},
                  width: 20,
                )
              ] else
                Switch(value: true, onChanged: (val) {})
            ],
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  SizedBox buildImageBanner() {
    return SizedBox(
      height: 260,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          food.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildSkuSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          height: 60,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: food.skus.length,
            separatorBuilder: (context, _) => const SizedBox(width: 10),
            itemBuilder: (_, index) => Pill(
              onTap: () => setState(() {
                selectedSku = food.skus[index];
              }),
              isActive: food.skus[index].id == selectedSku.id,
              builder: (color, bgColor) => Row(
                children: [
                  LoyaltiText.bodyText(
                    food.skus[index].name,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                  LoyaltiText.bodyText(
                    " GHS ${food.skus[index].price}",
                    fontSize: 12,
                    color: color,
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgButton(
              icon: "assets/svg/minus.svg",
              onPressed: () {},
              color: Colors.red,
              width: 25,
            ),
            const SizedBox(width: 15),
            LoyaltiText.bodyText("1", fontSize: 32),
            const SizedBox(width: 10),
            SvgButton(
              icon: "assets/svg/plus.svg",
              color: Colors.green,
              onPressed: () {},
              width: 30,
            ),
          ],
        )
      ],
    );
  }

  @override
  Future<void> onLoad() async {
    food = await getIt.get<SelisApi>().getFoodItem(widget.id);
    selectedSku = food.skus.first;
  }

  @override
  Future<void> onRefresh() async {
    await onLoad();
  }
}
