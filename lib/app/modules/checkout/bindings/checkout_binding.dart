import 'package:get/get.dart';
import 'package:ladangsantara/app/modules/checkout/controllers/create_address_controller.dart';
import 'package:ladangsantara/app/modules/checkout/controllers/order_address_controller.dart';

import '../controllers/checkout_controller.dart';

class CheckoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateAddressController>(
      () => CreateAddressController(),
    );
    Get.lazyPut<CheckoutController>(
      () => CheckoutController(),
    );
    Get.lazyPut<OrderAddressController>(() => OrderAddressController());
  }
}
