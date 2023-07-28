import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ladangsantara/app/common/input/xpicker_image.dart';

class FormReviewController extends GetxController {
  //TODO: Implement FormReviewController
  final PickerController picker = Get.find<PickerController>();
  RxString comment = ''.obs;
  RxDouble rating = 0.0.obs;
  RxList<XFile> images = <XFile>[].obs;
}
