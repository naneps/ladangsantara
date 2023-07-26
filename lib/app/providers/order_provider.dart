import 'package:get/get.dart';
import 'package:ladangsantara/app/models/order_modell.dart';
import 'package:ladangsantara/app/services/api_service.dart';
import 'package:ladangsantara/app/services/local_storage_service.dart';

class OrderProvider extends GetConnect {
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
  }

//create order
  Future<Response> createOrder({OrderModel? order}) async {
    return await post(
      'order',
      order!.forCreate(),
    );
  }

  Future<Response> updateOrder(Map<String, dynamic> data, String id) async {
    return await put('/orders/$id', data);
  }

  //get order
  Future<Response> getOrder(String id) async {
    return await get('/orders/$id');
  }
}
