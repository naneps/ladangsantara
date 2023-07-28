import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/buttons/x_Icon_button.dart';
import 'package:ladangsantara/app/common/buttons/x_button.dart';
import 'package:ladangsantara/app/common/input/x_field.dart';
import 'package:ladangsantara/app/common/shape/rounded_container.dart';
import 'package:ladangsantara/app/common/ui/xpicture.dart';
import 'package:ladangsantara/app/models/product_model.dart';
import 'package:ladangsantara/app/modules/review/controllers/create_review_controller.dart';
import 'package:ladangsantara/app/modules/review/controllers/form_review_controller.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CreateReviewView extends GetView<CreateReviewController> {
  const CreateReviewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Beri Ulasan',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
        ),
        persistentFooterButtons: [
          XButton(
            text: "Kirim",
            onPressed: () {
              Get.back();
            },
          )
        ],
        body: RoundedContainer(
          constraints: BoxConstraints(maxHeight: Get.height),
          child: ListView.separated(
            padding: const EdgeInsets.all(10),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: controller.products.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final product = controller.products[index];
              return FormReview(
                product: product,
                key: ValueKey(product.id),
              );
            },
          ),
        ));
  }
}

class FormReview extends GetView<FormReviewController> {
  final ProductModel product;
  const FormReview({
    super.key,
    required this.product,
  });
  @override
  // TODO: implement tag
  String? get tag => product.id.toString();
  @override
  // TODO: implement controller
  FormReviewController get controller =>
      Get.find<FormReviewController>(tag: tag!);
  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      padding: const EdgeInsets.all(10),
      hasBorder: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: XPicture(
              imageUrl: "",
              size: 40,
            ),
            title: Text(
              "Produk 1",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            " Komentar",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              const Expanded(
                child: XTextField(
                  hintText: "Tulis ulasanmu disini",
                  maxLines: 5,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              XIconButton(
                icon: MdiIcons.camera,
                onTap: () {},
                color: Theme.of(context).primaryColor,
                supportColor: Theme.of(context).primaryColor,
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            " Nilai",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          RatingBar.builder(
            allowHalfRating: true,
            itemCount: 5,
            initialRating: 4,
            // glow: false,
            glowColor: Colors.amber,
            itemBuilder: (context, index) => const Icon(
              MdiIcons.starBox,
              color: Colors.amber,
            ),
            onRatingUpdate: (val) {},
          )
        ],
      ),
    );
  }
}
