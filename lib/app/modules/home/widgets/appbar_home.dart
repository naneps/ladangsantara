import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/shape/rounded_container.dart';
import 'package:ladangsantara/app/common/ui/xpicture.dart';
import 'package:ladangsantara/app/common/utils.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AppbarHome extends StatelessWidget {
  const AppbarHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      hasBorder: true,
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: Get.width * 0.6,
            child: const Row(
              children: [
                Icon(
                  MdiIcons.mapMarkerOutline,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Lokasi Anda",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          RoundedContainer(
            child: const XPicture(
              imageUrl: "https://picsum.photos/200",
              size: 40,
              radiusType: RadiusType.circle,
            ),
          )
        ],
      ),
    );
  }
}
