import 'package:get/get.dart';
import 'package:ladangsantara/app/models/product_model.dart';
import 'package:ladangsantara/app/models/user_order_model.dart';

class CreateReviewController extends GetxController {
  //TODO: Implement CreateReviewController
  final UserOrderModel userOrderModel = Get.arguments as UserOrderModel;
  final List<ProductModel> products = <ProductModel>[];

  @override
  void onInit() {
    super.onInit();
    products.addAll(userOrderModel.orderItems!.map((e) => e.product!));
  }
}
