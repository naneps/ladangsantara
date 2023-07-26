import 'package:get/get.dart';
import 'package:ladangsantara/app/models/address_model.dart';
import 'package:ladangsantara/app/models/order_modell.dart';
import 'package:ladangsantara/app/modules/checkout/controllers/order_address_controller.dart';

class CheckoutController extends GetxController {
  //TODO: Implement CheckoutControlle
  final OrderAddressController orderAddressController =
      Get.find<OrderAddressController>();
  Rx<AddressModel?> currentAddress = Rx<AddressModel?>(null);
  Rx<OrderModel> order = OrderModel().obs;

  @override
  void onInit() {
    super.onInit();
    orderAddressController.getAddress();
    currentAddress.value = orderAddressController.selectedAddress.value;
    ever(orderAddressController.selectedAddress, (callback) {
      currentAddress.value = callback;
    });
    order.value = Get.arguments;
  }
}
