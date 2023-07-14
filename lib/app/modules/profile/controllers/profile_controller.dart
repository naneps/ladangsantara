import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/models/menu_model.dart';
import 'package:ladangsantara/app/routes/app_pages.dart';
import 'package:ladangsantara/app/services/local_storage_service.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  RxList<MenuModel> menus = <MenuModel>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    menus.addAll([
      MenuModel(
        title: "Pengaturan Akun",
        icon: Icons.person,
        route: "/profile",
        isActive: true,
      ),
      MenuModel(
        title: "Buka Toko",
        icon: MdiIcons.store,
        route: Routes.STRORE_CREATE,
        isActive: true,
      ),
      MenuModel(
        title: "Keluar",
        icon: Icons.logout,
        onTap: () {
          logout();
        },
        // route: Routes.AUTH
        isActive: true,
      ),
    ]);
  }

  void logout() {
    Get.offAllNamed(Routes.AUTH);
    LocalStorage.clear();
  }
}

//list menu
