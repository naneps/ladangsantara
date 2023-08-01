import 'package:get/get.dart';
import 'package:ladangsantara/app/models/banner_model.dart';
import 'package:ladangsantara/app/providers/banner_provider.dart';

class BannerController extends GetxController
    with StateMixin<List<BannerModel>> {
  final bannerProvider = Get.find<BannerProvider>();
  //TODO: Implement BannerController
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getBanners();
  }

  void getBanners() async {
    await bannerProvider.getUserBanners().then((res) {
      if (res.body['status'] == "SUCCESS") {
        if (res.body['data'].isEmpty) {
          change([], status: RxStatus.empty());
          return;
        }
        change(res.body['data'], status: RxStatus.success());
      } else {
        change([], status: RxStatus.empty());
      }
    });
  }
}
