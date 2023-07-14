import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/shape/rounded_container.dart';
import 'package:ladangsantara/app/common/ui/xpicture.dart';
import 'package:ladangsantara/app/common/utils.dart';
import 'package:ladangsantara/app/themes/theme.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              RoundedContainer(
                // height: 50,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                hasBorder: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ahmad",
                      style: TextStyle(
                        fontSize: 18,
                        color: ThemeApp.darkColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const XPicture(
                      imageUrl: "",
                      size: 50,
                      radiusType: RadiusType.circle,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (context, index) {
                    return RoundedContainer(
                      hasBorder: true,
                      child: ListTile(
                        tileColor: Colors.white,
                        onTap: () {
                          if (controller.menus[index].route != null) {
                            Get.toNamed(controller.menus[index].route!);
                          } else {
                            controller.menus[index].onTap!();
                          }
                          // Utils.toNamed(controller.menus[index].route);
                        },
                        leading: Icon(
                          controller.menus[index].icon,
                          color: ThemeApp.darkColor.withOpacity(0.5),
                        ),
                        title: Text(
                          controller.menus[index].title,
                          style: TextStyle(
                            fontSize: 16,
                            color: ThemeApp.darkColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: ThemeApp.darkColor.withOpacity(0.5),
                        ),
                      ),
                    );
                  },
                  itemCount: controller.menus.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
