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
                      SizedBox(
                        height: 260,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            food.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      LoyaltiText.description(
                        "Sint sit irure ipsum commodo enim aute nulla et minim minim. Adipisicing ipsum sit eiusmod ut dolor mollit tempor culpa qui. Consequat laborum pariatur sint ea nostrud est fugiat nostrud in enim irure. Dolor exercitation ad nisi aliqua irure cillum. Cupidatat nostrud consectetur cillum qui anim deserunt sint cupidatat eu esse nisi cillum amet. Excepteur quis elit minim occaecat quis reprehenderit tempor qui amet aliquip.",
                      ),
                      const SizedBox(height: 15),
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
                                  "${food.skus[index].name} ",
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
                    ],
                  ),
                ),
                Row(
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
                )
              ],
            ),
          ),
        ),
      ),
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
