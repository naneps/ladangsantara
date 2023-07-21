import 'package:get/get.dart';
import 'package:ladangsantara/app/models/cart_item_model.dart';
import 'package:ladangsantara/app/models/store_model.dart';

class CartModel {
  StoreModel? store;
  RxBool? selected;
  List<CartItemModel> cartItems = <CartItemModel>[];
  CartModel({
    this.store,
    this.cartItems = const <CartItemModel>[],
    this.selected,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    store = StoreModel.fromJson(json['store']);
    cartItems = json['cart_items'] != null
        ? (json['cart_items'] as List)
            .map((e) => CartItemModel.fromJson(e).copyWith(
                  selected: false.obs,
                ))
            .toList()
        : <CartItemModel>[];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store'] = store!.toJson();
    data['cart_items'] = cartItems.map((e) => e.toJson()).toList();

    return data;
  }

  CartModel copyWith({
    StoreModel? store,
    RxBool? selected,
    List<CartItemModel>? cartItems,
  }) {
    return CartModel(
      store: store ?? this.store,
      selected: selected ?? this.selected,
      cartItems: cartItems ?? this.cartItems,
    );
  }
}
