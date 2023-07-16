import 'dart:io';

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
    httpClient.defaultDecoder = (responseBody) {
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
        return {
          'status': 'SUCCESS',
          'message': map['message'],
          'data': map['data']
              .map<StoreModel>((item) => StoreModel.fromJson(item))
              .toList(),
        };
      }
      throw 'Invalid response format';
    };
  }

  Future<Response> getStores() async {
    return await get('store', query: {});
  }

  Future<Response> createStore({
    required StoreModel store,
    File? image,
  }) async {
    if (image != null) {
      //form data
      final formData = FormData({
        'name': store.name,
        'description': store.description,
        'address': store.address,
        'lat': store.lat ?? '-',
        'long': store.long ?? '-',
        'image': MultipartFile(image, filename: image.path.split('/').last),
      });
      return await post(
        'store',
        formData,
      );
    }
    return await post(
      'store',
      store.toSaveJson(),
    );
  }

  Future<Response> getStore({int? storeId, bool? userStore}) async {
    return await get(
      'store/',
      query: {
        'user': userStore.toString(),
      },
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

  Future<Response> getUserStore() async {
    return await post('user/check/store', {});
  }

  Future<bool> isRegisStore() async {
    final response = await post('user/check/store', {});
    // final body = json.decode(response.body);

    // print("isRegisStore: $body");

    if (response.body['status'] == 'SUCCESS') {
      return true;
    } else {
      return false;
    }
  }
}
