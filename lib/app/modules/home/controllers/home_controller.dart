import 'package:get/get.dart';
import 'package:ladangsantara/app/models/product_filter_model.dart';
import 'package:ladangsantara/app/models/product_model.dart';
import 'package:ladangsantara/app/providers/product_provider.dart';

class HomeController extends GetxController with StateMixin {
  //TODO: Implement HomeController
  RxList<ProductModel> vegetables = <ProductModel>[].obs;
  RxList<ProductModel> fruits = <ProductModel>[].obs;
  final productProvider = Get.find<ProductProvider>();
  // Rx<ProductFilter> filter = ProductFilter(
  //   perPage: "5",
  //   category: "Sayur",
  //   // storeId: null,
  // ).obs;
  Future<void> getVegetables() async {
    try {
      final response = await productProvider.getProducts(
        // filter: filter.value,
        filter: ProductFilter(
          perPage: "5",
          category: "Sayur",
          // storeId: null,
        ),
      );

      print("response products: ${response.body}");
      if (response.body['status'] == 'SUCCESS') {
        if (response.body['data'].isEmpty) {
          change(vegetables, status: RxStatus.empty());
          return;
        }
        vegetables.assignAll(response.body['data']);
        change(vegetables, status: RxStatus.success());
      } else {
        change(vegetables, status: RxStatus.error(response.body['message']));
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getFruits() async {
    try {
      final response = await productProvider.getProducts(
        filter: ProductFilter(
          perPage: "5",
          category: "Buah",
          // storeId: null,
        ),
      );
      print("response fruits: ${response.body}");
      if (response.body['status'] == 'SUCCESS') {
        if (response.body['data'].isEmpty) {
          change(fruits, status: RxStatus.empty());
          return;
        }
        fruits.assignAll(response.body['data']);
        change(fruits, status: RxStatus.success());
      } else {
        change(fruits, status: RxStatus.error(response.body['message']));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getVegetables();
    getFruits();
  }
}
