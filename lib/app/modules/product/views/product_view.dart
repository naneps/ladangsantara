import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/input/search_field.dart';
import 'package:ladangsantara/app/common/ui/empty_state_view.dart';
import 'package:ladangsantara/app/common/utils.dart';
import 'package:ladangsantara/app/modules/product/widgets/product_card.dart';
import 'package:ladangsantara/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../controllers/product_controller.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Produk',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ThemeApp.darkColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(50),
        //   child: SearchField(),
        // ),
        iconTheme: IconThemeData(
          color: ThemeApp.darkColor,
        ),
        actions: [
          IconButton(
            onPressed: () {
              showFilter();
            },
            icon: Icon(
              MdiIcons.filterVariant,
              color: ThemeApp.darkColor,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SearchField(
              onChanged: (val) {
                controller.filter.value.search!.value = val;
              },
            ),
          ),
          Expanded(
            child: controller.obx(
              (products) {
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    final product = products![index];
                    return ProductCard(
                      product: product,
                      onAddToCart: () {
                        controller.addToCart(product);
                      },
                    ).animate(
                      onInit: (controller) {
                        controller.forward();
                      },
                    ).scaleXY(
                      curve: Curves.easeInOutBack,
                      duration: const Duration(milliseconds: 500),
                      delay:
                          Duration(milliseconds: (100 * index).clamp(100, 500)),
                    );
                  },
                );
              },
              onEmpty: EmptyStateView(
                icon: MdiIcons.informationOutline,
              ),
              onLoading: Center(
                child: Utils.loadingWidget(size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showFilter() {
    Get.bottomSheet(
      Container(
        height: 300,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }
}
