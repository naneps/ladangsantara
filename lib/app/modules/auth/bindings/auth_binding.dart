import 'package:get/get.dart';
import 'package:ladangsantara/app/providers/auth_provider.dart';
import 'package:ladangsantara/app/services/api_service.dart';

import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(
      () => AuthController(),
      fenix: true,
    );
    Get.lazyPut<AuthProvider>(() => AuthProvider());
    Get.lazyPut<ApiService>(() => ApiService());
  }
}
