import 'package:ladangsantara/app/models/product_model.dart';

class CartItemModel {
  int? id;
  int? userId;
  int? productId;
  int? qty;
  ProductModel? product;
  String? createdAt;
  String? updatedAt;

  CartItemModel(
      {this.id,
      this.userId,
      this.productId,
      this.qty,
      this.product,
      this.createdAt,
      this.updatedAt});

  CartItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // userId = json['user_id'];
    productId = json['product_id'];
    qty = int.parse(json['qty']);
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['product_id'] = productId;
    data['qty'] = qty;
    data['product'] = product?.toJson();
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
