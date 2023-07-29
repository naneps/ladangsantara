import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/shape/rounded_container.dart';

class CarouselContent extends StatelessWidget {
  CarouselContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      width: Get.width,
      height: 150,
      hasBorder: true,
      // padding: const EdgeInsets.all(10.0),
      child: CarouselSlider.builder(
        itemCount: images.length,
        itemBuilder: (context, index, realIndex) {
          return Container(
            width: Get.width,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(
                  "assets/carousel/${images[index]}",
                ),
                fit: BoxFit.cover,
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
          // viewportFraction: 1.0,
          aspectRatio: 1.0,
          onPageChanged: (index, reason) {
            // controller.current = index;
          },
        ),
      ),
    );
  }

  List<String> images = [
    "banner_1.jpg",
    "banner_2.jpg",
    "banner_3.png",
  ];
}
