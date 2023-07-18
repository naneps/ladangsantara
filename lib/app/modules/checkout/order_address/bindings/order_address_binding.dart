import 'package:get/get.dart';

import '../controllers/order_address_controller.dart';

class OrderAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderAddressController>(
      () => OrderAddressController(),
    );
  }
}
