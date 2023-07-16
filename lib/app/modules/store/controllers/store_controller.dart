import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/models/menu_model.dart';
import 'package:ladangsantara/app/models/store_model.dart';
import 'package:ladangsantara/app/modules/product/bindings/product_binding.dart';
import 'package:ladangsantara/app/modules/product/views/product_store_view.dart';
import 'package:ladangsantara/app/providers/store_provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class StoreController extends GetxController with StateMixin {
  //TODO: Implement StoreController
  final storeService = Get.find<StoreProvider>();
  RxList<MenuModel> featureStore = <MenuModel>[].obs;
  Rx<StoreModel> store = StoreModel().obs;
  @override
  void onInit() {
    super.onInit();
    getStores();
    assignFeatures();
  }

  Future<void> getStores() async {
    try {
      final response = await storeService.getUserStore();
      if (response.body['status'] == "SUCCESS") {
        print("store json${response.body['data']}");
        store.value = response.body['data'];
        change(store, status: RxStatus.success());
      } else {
        store.value = StoreModel();
      }
    } catch (e) {
      print("error get store: $e");
    }
  }

  void assignFeatures() {
    featureStore.assignAll([
      MenuModel(
        title: "Pengaturan Toko",
        icon: MdiIcons.storeCogOutline,
        route: "/store/manage",
        isActive: true,
      ),
      MenuModel(
        title: "Kelola Produk",
        icon: MdiIcons.packageVariantClosed,
        onTap: () {
          Get.to(
            () => const ProductStoreView(),
            binding: ProductBinding(),
            arguments: store.value.id,
          );
        },
        isActive: true,
      ),
      MenuModel(
        title: "Kelola Pesanan",
        icon: MdiIcons.cartArrowDown,
        route: "/store/manage",
        isActive: true,
      ),
      MenuModel(
        title: "Laporan",
        icon: MdiIcons.fileChartOutline,
        route: "/store/manage",
        isActive: true,
      ),
    ]);
  }
}

class FeatureStoreModel {
  final String title;
  final IconData icon;
  String? route;
  final bool isActive;
  final bool? hasBadge;
  final Function? onTap;
  FeatureStoreModel({
    required this.title,
    required this.icon,
    this.route,
    required this.isActive,
    this.hasBadge,
    this.onTap,
  });
}
