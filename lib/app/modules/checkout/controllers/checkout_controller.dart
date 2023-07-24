import 'package:get/get.dart';
import 'package:ladangsantara/app/models/order_modell.dart';
import 'package:ladangsantara/app/models/region_model.dart';
import 'package:ladangsantara/app/modules/checkout/controllers/order_address_controller.dart';

class CheckoutController extends GetxController {
  //TODO: Implement CheckoutControlle
  final OrderAddressController orderAddressController =
      Get.find<OrderAddressController>();
  Rx<OrderAddressModel?> currentAddress = Rx<OrderAddressModel?>(null);
  Rx<OrderModel> order = OrderModel().obs;

  @override
  void onInit() {
    super.onInit();
    orderAddressController.fetchAllAddresses();
    currentAddress.bindStream(orderAddressController.selectedAddress.stream);
    order.value = Get.arguments;
  }
}
