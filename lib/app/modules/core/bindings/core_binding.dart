import 'package:get/get.dart';
import 'package:ladangsantara/app/modules/cart/bindings/cart_binding.dart';
import 'package:ladangsantara/app/modules/home/controllers/home_controller.dart';
import 'package:ladangsantara/app/modules/profile/controllers/profile_controller.dart';

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
  }
}
