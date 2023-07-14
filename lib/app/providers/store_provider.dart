import 'package:get/get.dart';
import 'package:ladangsantara/app/models/store_model.dart';
import 'package:ladangsantara/app/services/api_service.dart';
import 'package:ladangsantara/app/services/local_storage_service.dart';

class StoreProvider extends GetConnect {
  final ApiService apiService = Get.find<ApiService>();

  @override
  void onInit() {
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
    defaultDecoder = (responseBody) {
      final map = responseBody as Map<String, dynamic>;
      if (map['status'] == 'ERROR') {
        throw map['message'];
      }
      if (map['data'] is Map<String, dynamic>) {
        return {
          'status': 'SUCCESS',
          'message': map['message'],
          'data': StoreModel.fromJson(map['data']),
        };
      } else if (map['data'] is List) {
        return map['data']
            .map<StoreModel>((body) => StoreModel.fromJson(body))
            .toList();
      }
      throw 'Invalid response format';
    };
  }

  Future<Response> getStores() async {
    return await get('store');
  }

  Future<Response> createStore({required StoreModel store}) async {
    return await post(
      'store',
      store.toSaveJson(),
    );
  }

  Future<Response> getStore(String? storeId) async {
    return await get(
      'store/$storeId',
    );
  }

  Future<Response> updateStore({required StoreModel store}) async {
    return await put(
      'store/${store.id}',
      store.toSaveJson(),
      // headers: {
      //   'Content-Type': 'application/json',
      //   'Authorization': 'Bearer ${LocalStorage.getUser()!['token']}'
      // },
    );
  }

  Future<Response> deleteStore(String? storeId) async {
    return await delete(
      'store/$storeId',
    );
  }
}
