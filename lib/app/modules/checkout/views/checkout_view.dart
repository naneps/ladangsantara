import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/shape/rounded_container.dart';
import 'package:ladangsantara/app/common/ui/x_dividerdotted.dart';
import 'package:ladangsantara/app/common/ui/xpicture.dart';
import 'package:ladangsantara/app/common/utils.dart';
import 'package:ladangsantara/app/modules/checkout/order_address/views/order_address_view.dart';
import 'package:ladangsantara/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Summary',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          RoundedContainer(
            padding: const EdgeInsets.all(10),
            color: ThemeApp.lightColor,
            hasBorder: true,
            child: ListTile(
              horizontalTitleGap: 0,
              contentPadding: const EdgeInsets.all(0),
              leading: const Icon(
                MdiIcons.mapMarker,
                size: 20,
              ),
              title: const Text.rich(
                TextSpan(
                  text: 'Alamat Pengiriman',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: ' (082313132)',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              subtitle: const Text(
                'Jl. Raya Cipadung No. 1, Cibiru, Bandung, Jawa Barat, 40614',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
              trailing: InkWell(
                onTap: () {
                  Get.to(() => const OrderAddressView());
                },
                child: const Icon(
                  MdiIcons.chevronRight,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          RoundedContainer(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      XPicture(
                        imageUrl: "",
                        size: 30,
                        radiusType: RadiusType.circle,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Toko Ira',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const XDividerDotted(
                  margin: EdgeInsets.symmetric(vertical: 5),
                ),
                RoundedContainer(
                  constraints: const BoxConstraints(
                    minHeight: 100,
                    maxHeight: 400,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: 2,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return const TileItemCart();
                    },
                  ),
                ),
                const XDividerDotted(
                  margin: EdgeInsets.symmetric(vertical: 5),
                ),
              ],
            ),
          ),
          RoundedContainer(
            padding: const EdgeInsets.all(10),
            color: ThemeApp.lightColor,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Standar Pengiriman",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      MdiIcons.truckDeliveryOutline,
                      size: 15,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Dari Desa Lohbeer",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TileItemCart extends StatelessWidget {
  const TileItemCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      child: const Row(
        children: [
          XPicture(
            imageUrl: "",
            size: 60,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Beras Merah',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Rp 100.000',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          // SizedBox(height: 5),
          Text(
            '1 x 1 Kg',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
