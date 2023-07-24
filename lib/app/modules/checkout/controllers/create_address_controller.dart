import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/utils.dart';
import 'package:ladangsantara/app/models/region_model.dart';
import 'package:ladangsantara/app/modules/checkout/controllers/order_address_controller.dart';
import 'package:ladangsantara/app/providers/region_provider.dart';
import 'package:ladangsantara/app/services/sql_lite_service.dart';

class CreateAddressController extends GetxController {
  final regionProvider = Get.find<RegionProvider>();
  final SqlLiteService sqlLiteService = Get.find<SqlLiteService>();
  final formKey = GlobalKey<FormState>();
  RxList<Province> provinces = <Province>[].obs;
  RxList<Regency> regencies = <Regency>[].obs;
  RxList<District> districts = <District>[].obs;
  RxList<Village> villages = <Village>[].obs;
  Rx<Province> province = Province().obs;
  Rx<Regency> regency = Regency().obs;
  Rx<District> district = District().obs;
  Rx<Village> village = Village().obs;
  Rx<OrderAddressModel> address = OrderAddressModel(
    isDefault: 0.obs,
  ).obs;
  RxList<OrderAddressModel> listAddress = <OrderAddressModel>[].obs;
  Future<void> getProvinces() async {
    try {
      final res = await regionProvider.getProvince();
      if (res.statusCode == 200) {
        provinces.assignAll(res.body);
      } else {
        throw Exception('Failed to fetch provinces');
      }
    } catch (e) {
      throw Exception('Failed to fetch provinces');
    }
  }

  Future<void> getRegency(int id) async {
    try {
      final res = await regionProvider.getRegency(id.toString());
      if (res.statusCode == 200) {
        regencies.assignAll(res.body);
        districts.clear(); // Clear districts when changing regency
        villages.clear(); // Clear villages when changing regency
      } else {
        throw Exception('Failed to fetch regencies');
      }
    } catch (e) {
      throw Exception('Failed to fetch regencies');
    }
  }

  Future<void> getDistrict(int id) async {
    try {
      final res = await regionProvider.getDistrict(id.toString());
      if (res.statusCode == 200) {
        districts.assignAll(res.body);
        villages.clear(); // Clear villages when changing district
      } else {
        throw Exception('Failed to fetch districts');
      }
    } catch (e) {
      throw Exception('Failed to fetch districts');
    }
  }

  Future<void> getVillage(int id) async {
    try {
      final res = await regionProvider.getVillage(id.toString());
      if (res.statusCode == 200) {
        villages.assignAll(res.body);
      } else {
        throw Exception('Failed to fetch villages');
      }
    } catch (e) {
      throw Exception('Failed to fetch villages');
    }
  }

  @override
  void onInit() {
    super.onInit();
    sqlLiteService.initDatabase();
    getProvinces();
  }

  void mappingAddress() {
    address.update((val) {
      val!.address = address.value.address;
      val.phone = address.value.phone;
      val.province = province.value.name;
      val.regency = regency.value.name;
      val.district = district.value.name;
      val.village = village.value.name;
      val.postalCode = address.value.postalCode;
      val.isDefault = address.value.isDefault;
    });
  }

  Future<void> saveAddress() async {
    mappingAddress();
    print(address.value.toJson());

    // Get the instance of the OrderAddressController
    OrderAddressController orderAddressController =
        Get.find<OrderAddressController>();

    // Check if there is an existing default address
    if (orderAddressController.listAddress.isNotEmpty) {
      OrderAddressModel? existingDefaultAddress =
          orderAddressController.listAddress.firstWhere(
        (address) => address.isDefault!.value == 1,
        orElse: () => null!,
      );

      // If there is an existing default address, set it as not default (isDefault = false)
      existingDefaultAddress.isDefault!.value = 0;
      await sqlLiteService.update(
        'regions',
        existingDefaultAddress.toJson(),
      );
    }
    // Insert the new address with isDefault = true
    try {
      await sqlLiteService.insert(
        'regions',
        address.value
            .copyWith(
              id: null,
              createdAt: DateTime.now().toString(),
              updatedAt: DateTime.now().toString(),
              isDefault: 1.obs,
            )
            .toJson(),
      );

      Get.back();
      Utils.snackMessage(
        title: "Berhasil",
        messages: "Alamat berhasil disimpan",
        type: "success",
      );

      // Fetch all addresses again in the OrderAddressController
      orderAddressController.fetchAllAddresses();
    } catch (e) {
      throw Exception('Failed to save address');
    }
  }
}
