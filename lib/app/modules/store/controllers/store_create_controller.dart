import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/models/store_model.dart';
import 'package:ladangsantara/app/providers/store_provider.dart';
import 'package:ladangsantara/app/services/location_service.dart';
import 'package:location/location.dart';

class StoreCreateController extends GetxController {
  //TODO: Implement StoreCreateController
  final formKey = GlobalKey<FormState>();
  final Rx<StoreModel> store = StoreModel().obs;

  late LocationData location;
  Future<void> createStore() async {
    await Get.find<StoreProvider>().createStore(store: store.value).then((res) {
      print(res.body);
      if (res.status.hasError) {
        Get.snackbar(
          'Error',
          res.statusText.toString(),
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Success',
          res.body['message'],
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    });
  }

  Future<void> getLocation() async {
    Get.find<LocationService>().getLocation().then((value) {
      print(value);
    });
  }
}
