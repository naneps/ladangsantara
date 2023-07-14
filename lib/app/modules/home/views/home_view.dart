import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/buttons/x_Icon_button.dart';
import 'package:ladangsantara/app/common/shape/rounded_container.dart';
import 'package:ladangsantara/app/common/ui/heading_text.dart';
import 'package:ladangsantara/app/common/ui/xpicture.dart';
import 'package:ladangsantara/app/modules/home/controllers/home_controller.dart';
import 'package:ladangsantara/app/modules/home/widgets/appbar_home.dart';
import 'package:ladangsantara/app/modules/home/widgets/carousel_conten.dart';
import 'package:ladangsantara/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const AppbarHome(),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView(
                  children: [
                    const CarouselContent(),
                    const SizedBox(
                      height: 10,
                    ),
                    RoundedContainer(
                      padding: const EdgeInsets.all(10.0),
                      height: 120,
                      width: Get.width,
                      hasBorder: true,
                      child: Column(
                        children: [
                          HeadingText(
                            leftText: "kategori",
                            rightText: "Lihat Semua",
                            fontSize: 14,
                            onPressRightText: () {},
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return RoundedContainer(
                                  width: 80,
                                  height: 80,
                                  hasBorder: true,
                                  margin: const EdgeInsets.only(right: 10),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.ac_unit,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Kategori",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RoundedContainer(
                      width: Get.width,
                      hasBorder: true,
                      height: 240,
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          HeadingText(
                            leftText: "Buah Buahan",
                            rightText: "Lihat Semua",
                            onPressRightText: () {},
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: 10,
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 2 / 1.6,
                              ),
                              itemBuilder: (context, index) {
                                return RoundedContainer(
                                  hasBorder: true,
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      XPicture(
                                        imageUrl: "https://picsum.photos/200/",
                                        sizeWidth: Get.width,
                                        radius: 0,
                                      ),
                                      RoundedContainer(
                                        width: Get.width,
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Buah Buahan",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Rp. 100.000",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            XIconButton(
                                              size: 20,
                                              supportColor: ThemeApp
                                                  .primaryColor
                                                  .withOpacity(0.5),
                                              icon: MdiIcons.cartOutline,
                                              color: Colors.white,
                                              onTap: () {},
                                              backgroundColor:
                                                  ThemeApp.primaryColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
