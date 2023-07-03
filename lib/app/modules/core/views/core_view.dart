import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/themes/theme.dart';

import '../controllers/core_controller.dart';

class CoreView extends GetView<CoreController> {
  const CoreView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(() {
        return CurvedNavigationBar(
          key: const ValueKey("bottom_navigation_bar"),
          items: controller.bottomNavItems.map((item) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              child: Icon(
                item.isActive.value ? item.icon : item.activeIcon,
                key: ValueKey<bool>(item.isActive.value),
                color: item.isActive.value
                    ? ThemeApp.lightColor
                    : ThemeApp.darkColor,
                size: 30,
              ),
            );
          }).toList(),
          backgroundColor: ThemeApp.primaryColor.withOpacity(0.5),
          color: ThemeApp.lightColor,
          buttonBackgroundColor: ThemeApp.primaryColor,
          height: 50,
          animationCurve: Curves.easeInOutBack,
          onTap: (value) {
            controller.currentIndex = value;
            controller.setActiveBottomNavItem(controller.bottomNavItems[value]);
          },
          // letIndexChange: (value) {
          //   controller.currentIndex = value;
          //   return true;
          // },
        );
      }),
      body: SafeArea(
        child: Obx(() {
          final currentItem =
              controller.bottomNavItems[controller.currentIndex];
          return currentItem.widget;
        }),
      ),
    );
  }
}
