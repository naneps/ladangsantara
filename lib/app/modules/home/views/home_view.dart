import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/shape/rounded_container.dart';
import 'package:ladangsantara/app/common/ui/heading_text.dart';
import 'package:ladangsantara/app/common/utils.dart';
import 'package:ladangsantara/app/models/product_model.dart';
import 'package:ladangsantara/app/modules/home/controllers/home_controller.dart';
import 'package:ladangsantara/app/modules/home/widgets/appbar_home.dart';
import 'package:ladangsantara/app/modules/home/widgets/card_product.dart';
import 'package:ladangsantara/app/modules/home/widgets/carousel_conten.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const AppbarHome(),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const CarouselContent(),
                    const SizedBox(
                      height: 10,
                    ),
                    RoundedContainer(
                      padding: const EdgeInsets.all(10.0),
                      height: 120,
                      width: Get.width,
                      hasBorder: true,
                      child: Column(
                        children: [
                          HeadingText(
                            leftText: "kategori",
                            rightText: "Lihat Semua",
                            fontSize: 14,
                            onPressRightText: () {},
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return RoundedContainer(
                                  width: 80,
                                  height: 80,
                                  hasBorder: true,
                                  margin: const EdgeInsets.only(right: 10),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.ac_unit,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Kategori",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RoundedContainer(
                      width: Get.width,
                      hasBorder: true,
                      height: 240,
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          HeadingText(
                            leftText: "Buah Buahan",
                            rightText: "Lihat Semua",
                            onPressRightText: () {},
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: controller.obx(
                              (fruits) {
                                return GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: controller.fruits.length,
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio: 2 / 1.6,
                                  ),
                                  itemBuilder: (context, index) {
                                    ProductModel product =
                                        controller.fruits[index];
                                    return CardProduct(
                                      product: product,
                                    );
                                  },
                                );
                              },
                              onLoading: Center(
                                child: Utils.loadingWidget(
                                  size: 30,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    RoundedContainer(
                      width: Get.width,
                      hasBorder: true,
                      height: 240,
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          HeadingText(
                            leftText: "Sayur Sayuran",
                            rightText: "Lihat Semua",
                            onPressRightText: () {},
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: controller.obx(
                              (vegetables) {
                                return GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: controller.vegetables.length,
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1,
                                    childAspectRatio: 2 / 1.6,
                                  ),
                                  itemBuilder: (context, index) {
                                    // print(controller.vegetables.length);
                                    ProductModel product =
                                        controller.vegetables[index];
                                    return CardProduct(
                                      product: product,
                                    ).animate().slideX(
                                          duration: const Duration(
                                            milliseconds: 500,
                                          ),
                                          begin: -1,
                                          end: 0,
                                          delay: Duration(
                                            milliseconds: (index + 1) * 100,
                                          ),
                                        );
                                  },
                                );
                              },
                              onLoading: Center(
                                child: Utils.loadingWidget(
                                  size: 30,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
