import 'package:get/get.dart';

class RegionProvider extends GetConnect {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<Response> methodName(parameters) async {
    return await get('url');
  }
}
