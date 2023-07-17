import 'package:get/get.dart';
import 'package:ladangsantara/app/models/cart_item_model.dart';
import 'package:ladangsantara/app/providers/cart_provider.dart';

class CartController extends GetxController
    with StateMixin<List<CartItemModel>> {
  //TODO: Implement CartController
  final cartProvider = Get.find<CartProvider>();
  RxBool selectAll = false.obs;
  RxList<CartItemModel> carts = <CartItemModel>[].obs;
  RxList<CartItemModel> selectedCarts = <CartItemModel>[].obs;

  Future<void> getCarts() async {
    try {
      final response = await cartProvider.getCart();
      print("response carts: ${response.body}");
      if (response.body['status'] == 'SUCCESS') {
        if (response.body['data'].isEmpty) {
          change(carts, status: RxStatus.empty());
          return;
        }
        change(carts, status: RxStatus.success());
        carts.assignAll(response.body['data']);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCarts();
  }
}
