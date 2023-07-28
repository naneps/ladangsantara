import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/shape/rounded_container.dart';
import 'package:ladangsantara/app/common/ui/heading_text.dart';
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
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    const CarouselContent(),
                    const SizedBox(height: 10),
                    RoundedContainer(
                      height: 120,
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
