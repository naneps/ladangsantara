import 'package:get/get.dart';
import 'package:ladangsantara/app/common/input/xpicker_image.dart';
import 'package:ladangsantara/app/modules/cart/controllers/cart_controller.dart';
import 'package:ladangsantara/app/modules/product/controllers/product_create_controller.dart';
import 'package:ladangsantara/app/modules/product/controllers/product_detail_controller.dart';
import 'package:ladangsantara/app/modules/product/controllers/product_strore_controller.dart';
import 'package:ladangsantara/app/modules/product/controllers/product_update_controller.dart';
import 'package:ladangsantara/app/providers/cart_provider.dart';
import 'package:ladangsantara/app/providers/product_provider.dart';
import 'package:ladangsantara/app/services/api_service.dart';
import 'package:ladangsantara/app/services/imgae_picker_services.dart';

import '../controllers/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductDetailController>(
      () => ProductDetailController(),
    );
    Get.lazyPut<ProductUpdateController>(
      () => ProductUpdateController(),
    );
    Get.lazyPut<ProductStoreController>(
      () => ProductStoreController(),
    );
    Get.lazyPut<ProductCreateController>(
      () => ProductCreateController(),
    );
    Get.lazyPut<ProductController>(
      () => ProductController(),
    );
    Get.lazyPut<CartProvider>(() => CartProvider());
    Get.lazyPut<ApiService>(() => ApiService());
    Get.lazyPut<ProductProvider>(() => ProductProvider());
    Get.lazyPut<ImagePickerService>(() => ImagePickerService());
    Get.lazyPut<PickerController>(() => PickerController());
    Get.lazyPut<ProductDetailController>(() => ProductDetailController());
    Get.lazyPut<ProductProvider>(() => ProductProvider());
    Get.lazyPut<CartController>(() => CartController());
    // Get.lazyPut<LocalStorage>(() => LocalStorage());
  }
}
