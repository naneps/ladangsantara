import 'package:get/get.dart';
import 'package:ladangsantara/app/modules/cart/bindings/cart_binding.dart';
import 'package:ladangsantara/app/modules/cart/controllers/cart_controller.dart';
import 'package:ladangsantara/app/modules/home/controllers/home_controller.dart';
import 'package:ladangsantara/app/modules/profile/controllers/profile_controller.dart';
import 'package:ladangsantara/app/providers/cart_provider.dart';
import 'package:ladangsantara/app/providers/product_provider.dart';
import 'package:ladangsantara/app/providers/region_provider.dart';
import 'package:ladangsantara/app/providers/store_provider.dart';
import 'package:ladangsantara/app/services/api_service.dart';
import 'package:ladangsantara/app/services/location_service.dart';

import '../controllers/core_controller.dart';

class CoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoreController>(
      () => CoreController(),
    );
    Get.lazyPut<HomeController>(() => HomeController());
    // Get.lazyPut<ProfileBinding>(() => ProfileBinding());
    Get.lazyPut<CartBinding>(() => CartBinding());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<LocationService>(() => LocationService());
    Get.lazyPut<StoreProvider>(() => StoreProvider());
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<ProductProvider>(() => ProductProvider());
    Get.lazyPut<CartProvider>(() => CartProvider());
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<RegionProvider>(() => RegionProvider());
  }
}
