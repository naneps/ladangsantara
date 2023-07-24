import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/buttons/x_button.dart';
import 'package:ladangsantara/app/common/shape/rounded_container.dart';
import 'package:ladangsantara/app/models/region_model.dart';
import 'package:ladangsantara/app/modules/checkout/widgets/cart_summary_tile.dart';
import 'package:ladangsantara/app/modules/checkout/widgets/tile_address.dart';
import 'package:ladangsantara/app/themes/theme.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ringkasan Pesanan',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      persistentFooterButtons: [
        RoundedContainer(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const Text(
                "Total Pembayaran",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                controller.order.value.total,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              XButton(
                width: 120,
                height: 40,
                radius: 6,
                sizeText: 14,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                text: "Buat Pesanan",
                onPressed: () {
                  // controller.checkout();
                },
              ),
            ],
          ),
        ),
      ],
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Obx(() {
            return TileAddress(
              address: controller.currentAddress.value ?? OrderAddressModel(),
            );
          }),
          const SizedBox(height: 10),
          RoundedContainer(
            color: ThemeApp.lightColor,
            constraints: const BoxConstraints(
              maxHeight: 500,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
              itemCount: controller.order.value.carts!.length,
              itemBuilder: (context, index) {
                final cart = controller.order.value.carts![index];
                return CartSummaryTile(cart: cart);
              },
            ),
          ),
        ],
      ),
    );
  }
}
