import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/buttons/x_button.dart';
import 'package:ladangsantara/app/common/input/increment_decrement.dart';
import 'package:ladangsantara/app/common/shape/rounded_container.dart';
import 'package:ladangsantara/app/common/ui/empty_state_view.dart';
import 'package:ladangsantara/app/common/ui/xpicture.dart';
import 'package:ladangsantara/app/common/utils.dart';
import 'package:ladangsantara/app/routes/app_pages.dart';
import 'package:ladangsantara/app/themes/theme.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Keranjang Ira (20)',
              style: TextStyle(
                fontSize: 16,
                color: ThemeApp.darkColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            // const SizedBox(height: 5),
            // Text(
            //   'Rp 1.000.000',
            //   style: TextStyle(
            //     fontSize: 12,
            //     color: ThemeApp.darkColor,
            //     fontWeight: FontWeight.w500,
            //   ),
            // ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: controller.obx(
              (items) {
                return ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: items!.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return RoundedContainer(
                      hasBorder: true,
                      child: ListTile(
                        dense: true,
                        // isThreeLine: true,
                        leading: Obx(() {
                          return RoundedContainer(
                            width: 100,
                            child: Row(
                              children: [
                                Checkbox.adaptive(
                                  activeColor: ThemeApp.primaryColor,
                                  fillColor: MaterialStateProperty.all(
                                      ThemeApp.primaryColor),
                                  value: item.selected!.value,
                                  onChanged: (value) {
                                    controller.selectItem(item);
                                  },
                                  tristate: false,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        // color: ThemeApp.primaryColor,
                                        ),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                XPicture(
                                  imageUrl: item.product!.image!,
                                  size: 50,
                                )
                              ],
                            ),
                          );
                        }),
                        title: Text(
                          item.product!.name!,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          item.product!.priceFormatted,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: IncDecWidget(
                          disabledInput: true,
                          onIncrement: () {
                            // item.qty = item.qty! + 1;
                            controller.incrementQty(item.id!.toString());
                          },
                          onDecrement: () {
                            // item.qty = item.qty! - 1;
                            controller.decrementQty(item.id!.toString());
                          },
                          initialValue: int.tryParse(item.qty!),
                          onChange: (value) {
                            item.qty = value;
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              onEmpty: EmptyStateView(
                label: "Keranjang Kosong",
                icon: Icons.shopping_cart_outlined,
              ),
              onLoading: Center(
                child: Utils.loadingWidget(
                  size: 30,
                ),
              ),
            ),
          ),
          RoundedContainer(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Obx(() {
              return Row(
                children: [
                  //checkbox select all
                  Checkbox.adaptive(
                    activeColor: ThemeApp.primaryColor,
                    fillColor: MaterialStateProperty.all(ThemeApp.primaryColor),
                    value: controller.selectAll.value,
                    onChanged: (value) {
                      // controller.selectAll.value = value!;
                      controller.selectAllCarts();
                    },
                    tristate: false,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                          // color: ThemeApp.primaryColor,
                          ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  const Text(
                    "Pilih Semua",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    Utils.formatCurrency(controller.total.value.toDouble(),
                        locale: "id"),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 10),
                  XButton(
                    width: 90,
                    height: 35,
                    padding: const EdgeInsets.all(0),
                    hasBorder: true,
                    sizeText: 14,
                    text: "Checkout",
                    onPressed: () {
                      Get.toNamed(
                        Routes.CHECKOUT,
                        arguments: controller.selectedCarts,
                      );
                    },
                  ),
                ],
              );
            }),
          )
        ],
      ),
    );
  }
}
