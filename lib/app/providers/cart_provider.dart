import 'package:get/get.dart';
import 'package:ladangsantara/app/models/cart_item_model.dart';
import 'package:ladangsantara/app/services/api_service.dart';
import 'package:ladangsantara/app/services/local_storage_service.dart';

class CartProvider extends GetConnect {
  final ApiService apiService = Get.find<ApiService>();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    httpClient.baseUrl = apiService.baseUrl;
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Authorization'] =
          'Bearer ${LocalStorage.getUser()!['token']}';
      return request;
    });
    httpClient.addResponseModifier((request, response) {
      // Handle authorization errors or other common response modifications if needed
      return response;
    });
    httpClient.defaultDecoder = (responseBody) {
      final map = responseBody as Map<String, dynamic>;
      print("default decoder cart: $map");
      if (map['status'] == 'ERROR') {
        throw map['message'];
      }
      if (map['data'] is Map<String, dynamic>) {
        return {
          'status': 'SUCCESS',
          'message': map['message'],
          'data': CartItemModel.fromJson(map['data']),
        };
      } else if (map['data'] is List) {
        print("map['data'] carts is List");
        return {
          'status': 'SUCCESS',
          'message': map['message'],
          'data': map['data']
              .map<CartItemModel>((e) => CartItemModel.fromJson(e))
              .toList(),
        };
      }
      throw 'Invalid response format';
    };
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<Response> getCart() async {
    return await get('cart', query: {"product": "true"});
  }

  Future<Response> addToCart({
    required String productId,
    qty,
  }) async {
    return await post('cart', {
      "product_id": productId,
      "qty": qty,
    });
  }

  Future<Response> updateCart({
    required String cartId,
    required String qty,
  }) async {
    return await put('cart/$cartId', {
      "qty": qty,
    });
  }

  //addqty
  Future<Response> addQty({
    required String cartId,
    required String qty,
  }) async {
    return await put('cart/$cartId', {
      "qty": qty,
    });
  }

  //reduceqty
  Future<Response> reduceQty({
    required String cartId,
    required String qty,
  }) async {
    return await put('cart/$cartId', {
      "qty": qty,
    });
  }
}
