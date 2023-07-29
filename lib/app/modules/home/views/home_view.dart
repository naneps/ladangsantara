import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/shape/rounded_container.dart';
import 'package:ladangsantara/app/common/ui/heading_text.dart';
import 'package:ladangsantara/app/common/ui/xpicture.dart';
import 'package:ladangsantara/app/modules/home/controllers/home_controller.dart';
import 'package:ladangsantara/app/modules/home/widgets/appbar_home.dart';
import 'package:ladangsantara/app/modules/home/widgets/carousel_conten.dart';
import 'package:ladangsantara/app/modules/home/widgets/list_categories.dart';
import 'package:ladangsantara/app/modules/home/widgets/product_section_widget.dart';

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
              const SizedBox(height: 10),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    controller.getFruits();
                    controller.getVegetables();
                  },
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      CarouselContent(),
                      const SizedBox(height: 10),
                      RoundedContainer(
                        padding: const EdgeInsets.all(10),
                        height: 110,
                        child: Column(
                          children: [
                            HeadingText(
                              leftText: "kategori",
                              rightText: "Lihat Semua",
                              fontSize: 14,
                              onPressRightText: () {},
                            ),
                            const SizedBox(height: 10),
                            ListCategory()
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      ProductSectionWidget(
                        title: "Buah Buahan",
                        productList: controller.fruits,
                      ),
                      const SizedBox(height: 10),
                      ProductSectionWidget(
                        title: "Sayur Sayuran",
                        productList: controller.vegetables,
                      ),
                      const SizedBox(height: 10),
                      RoundedContainer(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            HeadingText(
                              leftText: "Rekomendasi Resep",
                              rightText: "Lihat Semua",
                              fontSize: 14,
                            ),
                            const SizedBox(height: 10),
                            RoundedContainer(
                              height: 120,
                              width: Get.width,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemExtent: 120,
                                itemBuilder: (context, index) {
                                  return RoundedContainer(
                                    margin: const EdgeInsets.only(right: 10),
                                    hasBorder: true,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        XPicture(
                                          imageUrl: "",
                                          sizeHeight: 70,
                                          sizeWidth: Get.width,
                                          radius: 0,
                                        ),
                                        const SizedBox(height: 5),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text(
                                            "Resep ${index + 1}",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 10,
                                              ),
                                              Text(
                                                "4.5",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
