import 'package:ladangsantara/app/common/utils.dart';
import 'package:ladangsantara/app/models/cart_model.dart';

class OrderModel {
  List<CartModel>? carts = <CartModel>[];
  int? totalPrice;
  OrderModel({
    this.carts,
    this.totalPrice,
  });

  OrderModel.fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['carts'] = carts!.map((e) => e.toJson()).toList();
    data['total_price'] = totalPrice;
    return data;
  }

  String get total {
    return Utils.formatCurrency(totalPrice!.toDouble(), locale: "id");
  }
}
