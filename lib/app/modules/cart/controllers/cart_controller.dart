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
  RxInt total = 0.obs;
  RxInt totalSelected = 0.obs;

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

    ever(carts, (callback) {
      total.value = 0;
      for (var item in carts) {
        ever(item.selected!, (callback) {
          if (item.selected!.value) {
            total.value += (int.tryParse(item.product!.price!)! *
                int.tryParse(item.qty!.toString())!);
          } else {
            total.value -= (int.tryParse(item.product!.price!)! *
                int.tryParse(item.qty!.toString())!);
          }
        });
      }
    });
  }

  void incrementQty(String id) async {
    await cartProvider.addQty(id: id).then((value) => {
          if (value.body['status'] == 'SUCCESS')
            {
              // carts.firstWhere((element) => element.id == id).qty =
              //     value.body['data']['qty'],
              // carts.refresh(),
            }
        });
  }

  void decrementQty(String id) async {
    await cartProvider.reduceQty(id: id).then((value) {
      if (value.body['status'] == 'SUCCESS') {
        // carts.firstWhere((element) => element.id == id).qty =
        //     value.body['data']['qty'];
        // carts.refresh();
      }
    });
  }

  void selectItem(CartItemModel item) {
    item.selected!.value = !item.selected!.value;
    if (item.selected!.value) {
      selectedCarts.add(item);
      totalSelected.value += (int.tryParse(item.product!.price!)! *
          int.tryParse(item.qty!.toString())!);
    } else {
      selectedCarts.remove(item);
      totalSelected.value -= (int.tryParse(item.product!.price!)! *
          int.tryParse(item.qty!.toString())!);
    }
    if (selectedCarts.length == carts.length) {
      selectAll.value = true;
    } else {
      selectAll.value = false;
    }
  }

  void selectAllCarts() {
    selectAll.value = !selectAll.value;
    if (selectAll.value) {
      selectedCarts.assignAll(carts);
      totalSelected.value = total.value;
      for (var item in carts) {
        item.selected!.value = true;
      }
    } else {
      selectedCarts.clear();
      totalSelected.value = 0;
      for (var item in carts) {
        item.selected!.value = false;
      }
    }
  }
  //
}
