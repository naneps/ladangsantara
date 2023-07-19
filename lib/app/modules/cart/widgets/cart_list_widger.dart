import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/shape/rounded_container.dart';
import 'package:ladangsantara/app/common/ui/empty_state_view.dart';
import 'package:ladangsantara/app/common/ui/xpicture.dart';
import 'package:ladangsantara/app/common/utils.dart';
import 'package:ladangsantara/app/models/cart_model.dart';
import 'package:ladangsantara/app/modules/cart/controllers/cart_controller.dart';
import 'package:ladangsantara/app/modules/cart/widgets/cart_item_list.dart';
import 'package:ladangsantara/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CartListWidget extends StatelessWidget {
  final List<CartModel> items;
  final controller = Get.find<CartController>();
  CartListWidget({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: controller.obx(
        (items) {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: items!.length,
            itemBuilder: (context, index) {
              final cart = items[index];
              return RoundedContainer(
                hasBorder: true,
                child: Obx(() {
                  return Column(
                    children: [
                      // Cart store row
                      Row(
                        children: [
                          Checkbox(
                            value: cart.selected!.value,
                            onChanged: (value) {
                              // cart.selected!.value = value!;
                              controller.toggleStoreSelection(cart);
                              controller.update();
                            },
                            side: BorderSide(
                              color: ThemeApp.primaryColor,
                              style: BorderStyle.solid,
                            ),
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.all<Color>(
                                ThemeApp.primaryColor),
                            activeColor: ThemeApp.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            // ...
                          ),
                          XPicture(
                            imageUrl:
                                cart.cartItems.first.product!.store!.logo!,
                            size: 25,
                            radius: 5,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            cart.store!.name!,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: ThemeApp.darkColor,
                            ),
                          ),
                        ],
                      ),
                      // ...

                      // Cart item list
                      CartItemListWidget(
                        cartItems: cart.cartItems,
                        cart: cart,
                      ),
                    ],
                  );
                }),
              );
            },
          );
        },
        // ...
        onEmpty: Center(
          child: EmptyStateView(
            label: 'Keranjang Kamu Kosong',
            icon: MdiIcons.cartOff,
            iconColor: ThemeApp.primaryColor,
          ),
        ),
        onLoading: Center(
          child: Utils.loadingWidget(
            size: 40,
          ),
        ),
      ),
    );
  }
}

// Add the CartModel class definition here
