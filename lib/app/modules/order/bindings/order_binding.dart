import 'package:get/get.dart';
import 'package:ladangsantara/app/modules/checkout/controllers/create_address_controller.dart';
import 'package:ladangsantara/app/modules/checkout/controllers/order_address_controller.dart';
import 'package:ladangsantara/app/providers/region_provider.dart';
import 'package:ladangsantara/app/services/sql_lite_service.dart';

import '../controllers/order_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(
      () => OrderController(),
    );
    Get.lazyPut<OrderAddressController>(() => OrderAddressController());
    Get.lazyPut<SqlLiteService>(() => SqlLiteService());
    Get.lazyPut<RegionProvider>(() => RegionProvider());
    Get.lazyPut<CreateAddressController>(() => CreateAddressController());
  }
}
