import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/shape/rounded_container.dart';
import 'package:ladangsantara/app/common/ui/empty_state_view.dart';
import 'package:ladangsantara/app/common/ui/heading_text.dart';
import 'package:ladangsantara/app/common/utils.dart';
import 'package:ladangsantara/app/models/product_model.dart';
import 'package:ladangsantara/app/modules/home/controllers/home_controller.dart';
import 'package:ladangsantara/app/modules/home/widgets/card_product.dart';
import 'package:ladangsantara/app/modules/product/bindings/product_binding.dart';
import 'package:ladangsantara/app/modules/product/views/product_view.dart';

class ProductSectionWidget extends GetView<HomeController> {
  final String title;
  final List<ProductModel> productList;

  const ProductSectionWidget({
    Key? key,
    required this.title,
    required this.productList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: 240,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          HeadingText(
            leftText: title,
            rightText: "Lihat Semua",
            onPressRightText: () {
              Get.to(
                () => const ProductView(),
                binding: ProductBinding(),
                fullscreenDialog: true,
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 500),
              );
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: controller.obx(
              (state) => GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: productList.length,
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 2 / 1.6,
                ),
                itemBuilder: (context, index) {
                  final product = productList[index];
                  return CardProduct(
                    product: product,
                    onAddToCart: () {
                      controller.addToCart(product: product);
                    },
                  ).animate().slideX(
                        duration: const Duration(milliseconds: 500),
                        begin: -1,
                        end: 0,
                        delay: Duration(milliseconds: (index + 1) * 100),
                      );
                },
              ),
              onLoading: Center(
                child: Utils.loadingWidget(
                  size: 30,
                ),
              ),
              onEmpty: Center(
                child: EmptyStateView(
                  icon: Icons.info_outline,
                  label: "Belum ada produk",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
