import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/buttons/x_icon_button.dart';
import 'package:ladangsantara/app/common/shape/rounded_container.dart';
import 'package:ladangsantara/app/models/product_model.dart';
import 'package:ladangsantara/app/modules/product/bindings/product_binding.dart';
import 'package:ladangsantara/app/modules/product/views/product_detail_view.dart';
import 'package:ladangsantara/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    this.onAddToCart,
    required this.product,
  });

  final ProductModel product;
  final VoidCallback? onAddToCart;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          () => const ProductDetailView(),
          binding: ProductBinding(),
          fullscreenDialog: true,
          curve: Curves.easeIn,
          arguments: product,
          duration: const Duration(milliseconds: 500),
        );
      },
      child: RoundedContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://picsum.photos/200/300',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      RoundedContainer(
                        hasBorder: true,
                        color: ThemeApp.lightColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        child: const Text(
                          'Rp 10.000',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  XIconButton(
                    supportColor: ThemeApp.primaryColor.withOpacity(0.5),
                    icon: MdiIcons.cartPlus,
                    padding: const EdgeInsets.all(5),
                    size: 25,
                    onTap: () {
                      onAddToCart?.call();
                      // controller.addToCart(product: product);
                    },
                    color: ThemeApp.primaryColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
