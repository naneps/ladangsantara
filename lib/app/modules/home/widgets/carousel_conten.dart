import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/shape/rounded_container.dart';
import 'package:ladangsantara/app/common/utils.dart';
import 'package:ladangsantara/app/modules/home/controllers/carousel_controller_controller.dart';
import 'package:ladangsantara/app/modules/store/bindings/store_binding.dart';
import 'package:ladangsantara/app/modules/store/views/store_detail_view.dart';

class CarouselContent extends GetView<CarouselControllerController> {
  const CarouselContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      width: Get.width,
      height: 150,
      hasBorder: true,
      // padding: const EdgeInsets.all(10.0),
      child: controller.obx(
        (banners) {
          if (banners!.isEmpty) {
            return const Center(
              child: Text("No banners available"),
            );
          }

          if (banners.length < 3) {
            // If there are less than 3 banners, duplicate the banners to make it at least 3
            final duplicatedBanners = List.generate(
              3,
              (index) => banners[index % banners.length],
            );

            return CarouselSlider.builder(
              itemCount: 3,
              itemBuilder: (context, index, realIndex) {
                return InkWell(
                  onTap: () {
                    Get.to(
                      const StoreDetailView(),
                      binding: StoreBinding(),
                      arguments: banners[index].user!.store!,
                    );
                  },
                  child: Container(
                    width: Get.width,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image:
                            NetworkImage(duplicatedBanners[index].imagePath!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                padEnds: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 2000),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                aspectRatio: 1.0,
                onPageChanged: (index, reason) {
                  // controller.current = index;
                },
              ),
            );
          }

          return CarouselSlider.builder(
            itemCount: banners.length,
            itemBuilder: (context, index, realIndex) {
              return InkWell(
                onTap: () {
                  Get.to(
                    const StoreDetailView(),
                    binding: StoreBinding(),
                    arguments: banners[index].user!.store!,
                  );
                },
                child: Container(
                  width: Get.width,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(banners[index].imagePath!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              padEnds: true,
              autoPlayAnimationDuration: const Duration(milliseconds: 2000),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              aspectRatio: 1.0,
              onPageChanged: (index, reason) {
                // controller.current = index;
              },
            ),
          );
        },
        onEmpty: const Center(
          child: Text("No banners available"),
        ),
        onError: (error) => Center(
          child: Text("Error: $error"),
        ),
        onLoading: Center(
          child: Utils.loadingWidget(size: 30),
        ),
      ),
    );
  }
}
