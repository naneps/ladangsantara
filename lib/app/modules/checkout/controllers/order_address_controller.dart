import 'package:get/get.dart';
import 'package:ladangsantara/app/models/region_model.dart';
import 'package:ladangsantara/app/services/sql_lite_service.dart';

class OrderAddressController extends GetxController
    with StateMixin<List<OrderAddressModel>> {
  final sqfliteService = Get.find<SqlLiteService>();
  Rx<OrderAddressModel?> selectedAddress = Rx<OrderAddressModel?>(null);
  RxList<OrderAddressModel> listAddress = <OrderAddressModel>[].obs;

// Fetch all addresses from SQLite
  void fetchAllAddresses() async {
    try {
      // Start loading state
      change([], status: RxStatus.loading());

      // Get all addresses from the database
      List<Map<String, dynamic>> data = await sqfliteService.query('regions');

      // Map the data to a list of OrderAddressModel
      List<OrderAddressModel> addresses = data
          .map((e) => OrderAddressModel.fromJson(e))
          .toList()
          .cast<OrderAddressModel>();

      // Find the default address

      if (addresses.isEmpty) {
        // If there are no addresses, update the state with an empty list
        change([], status: RxStatus.empty());
      } else {
        // Update the state with the fetched addresses
        OrderAddressModel? defaultAddress = addresses.firstWhere(
          (address) => address.isDefault!.value == 1,
          orElse: () => null!,
        );

        // Set the default address as the selected address
        selectedAddress.value = defaultAddress;
        listAddress.assignAll(addresses);
        change(addresses, status: RxStatus.success());
      }
    } catch (e) {
      // If there's an error, update the state with the error
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllAddresses();
  }

  void deleteAddress(int id) async {
    try {
      // Start loading state
      change([], status: RxStatus.loading());

      // Delete the address from the database
      await sqfliteService.delete('regions', id);
      Get.back();
      // Fetch all addresses again
      fetchAllAddresses();
    } catch (e) {
      // If there's an error, update the state with the error
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  void selectAddress(OrderAddressModel address) {
    selectedAddress.value = address;
  }
}
