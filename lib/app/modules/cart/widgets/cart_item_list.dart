import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/input/increment_decrement.dart';
import 'package:ladangsantara/app/common/shape/rounded_container.dart';
import 'package:ladangsantara/app/common/ui/xpicture.dart';
import 'package:ladangsantara/app/models/cart_item_model.dart';
import 'package:ladangsantara/app/models/cart_model.dart';
import 'package:ladangsantara/app/modules/cart/controllers/cart_controller.dart';
import 'package:ladangsantara/app/themes/theme.dart';

class CartItemListWidget extends StatelessWidget {
  final List<CartItemModel> cartItems;
  final CartModel cart;
  final controller = Get.find<CartController>();
  CartItemListWidget({
    super.key,
    required this.cartItems,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      constraints: const BoxConstraints(
        // minHeight: 100,
        maxHeight: 500,
      ),
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => const Divider(),
        shrinkWrap: true,
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = cartItems[index];
          return Obx(() {
            return RoundedContainer(
              hasBorder: true,
              child: ListTile(
                contentPadding: const EdgeInsets.all(5),
                leading: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      Checkbox(
                        value: cartItem.selected!.value,
                        onChanged: (value) {
                          // cartItem.selected!.value = value!;
                          controller.toggleItemSelection(cartItem, cart);
                          controller.update();
                        },
                        // ...
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
                      ),
                      XPicture(
                        imageUrl: cartItem.product!.image!,
                        size: 40,
                      ),
                    ],
                  ),
                ),
                title: Text(
                  cartItem.product!.name!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: RoundedContainer(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 2,
                  ),
                  child: Text(
                    cartItem.product!.priceFormatted,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                trailing: IncDecWidget(
                  onIncTap: () {
                    // controller.incrementQty(cartItem);
                    //
                    controller.increaseQty(cartItem);
                  },
                  onDecTap: () {
                    // controller.decrementQty(cartItem);
                    controller.decreaseQty(cartItem);
                  },
                  onChange: (val) {},
                  minValue: 1,
                  maxValue: int.tryParse(cartItem.product!.stock!)!,
                  isDisabled: int.parse(cartItem.qty!) >=
                      int.parse(cartItem.product!.stock!),
                  initialValue: int.parse(cartItem.qty.toString()),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
