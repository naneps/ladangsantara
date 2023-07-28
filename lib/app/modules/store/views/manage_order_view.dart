import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/shape/rounded_container.dart';
import 'package:ladangsantara/app/common/ui/xpicture.dart';
import 'package:ladangsantara/app/models/order_modell.dart';
import 'package:ladangsantara/app/modules/store/controllers/manage_order_controller.dart';
import 'package:ladangsantara/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ManageOrderView extends GetView<ManageOrderController> {
  const ManageOrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kelola Pesanan',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(MdiIcons.magnify),
          ),
        ],
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: Column(
        children: [
          RoundedContainer(
            height: 60,
            child: TabBar(
              labelColor: ThemeApp.darkColor,
              physics: const BouncingScrollPhysics(),
              isScrollable: true,
              indicatorColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              controller: controller.tabController,
              splashBorderRadius: BorderRadius.circular(10),
              tabs: const [
                TabWithIcon(
                  icon: MdiIcons.formatListBulleted,
                  text: 'Semua',
                ),
                TabWithIcon(
                  icon: MdiIcons.clockOutline,
                  text: 'Belum Bayar',
                ),
                TabWithIcon(
                  icon: MdiIcons.packageVariant,
                  text: 'Dikemas',
                ),
                TabWithIcon(
                  icon: MdiIcons.truckDeliveryOutline,
                  text: 'Dikirim',
                ),
                TabWithIcon(
                  icon: MdiIcons.check,
                  text: 'Selesai',
                ),
              ],
              automaticIndicatorColorAdjustment: true,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: const [
                ListOrder(),
                ListOrder(status: OrderStatus.pending),
                ListOrder(status: OrderStatus.packing),
                ListOrder(status: OrderStatus.shipping),
                ListOrder(
                  status: OrderStatus.completed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TabWithIcon extends StatelessWidget {
  final IconData icon;
  final String text;

  const TabWithIcon({Key? key, required this.icon, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}

class ListOrder extends StatelessWidget {
  final OrderStatus? status;

  const ListOrder({Key? key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: Get.height,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        itemCount: 10,
        itemBuilder: (context, index) {
          return OrderItemWidget(
            status: status,
          );
        },
      ),
    );
  }
}

class OrderItemWidget extends StatelessWidget {
  OrderModel? order;
  OrderStatus? status;
  OrderItemWidget({Key? key, this.order, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(10),
      hasBorder: true,
      child: Column(
        children: [
          Row(
            children: [
              const XPicture(
                imageUrl: "",
                size: 30,
              ),
              const SizedBox(width: 10),
              const Text(
                "Nama Pembeli",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              RoundedContainer(
                radius: 5,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                color: ThemeApp.lightColor,
                child: Text(
                  "Status",
                  style: TextStyle(
                    color: ThemeApp.darkColor,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          RoundedContainer(
            constraints: const BoxConstraints(
              maxHeight: 400,
            ),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(0),
              itemCount: 3,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const ListTile(
                  leading: XPicture(
                    imageUrl: "",
                    size: 40,
                  ),
                  title: Text(
                    "Nama Produk",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("Jumlah", style: TextStyle(fontSize: 12)),
                  trailing: Text(
                    "Harga",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 5),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "1 Item , Total : Rp. 100.000",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
