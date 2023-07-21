import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/input/search_field.dart';
import 'package:ladangsantara/app/common/shape/rounded_container.dart';
import 'package:ladangsantara/app/common/ui/xpicture.dart';
import 'package:ladangsantara/app/common/utils.dart';
import 'package:ladangsantara/app/modules/store/bindings/store_binding.dart';
import 'package:ladangsantara/app/modules/store/controllers/store_index_controller.dart';
import 'package:ladangsantara/app/modules/store/views/store_detail_view.dart';
import 'package:ladangsantara/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class StoreView extends GetView<StoreIndexController> {
  const StoreView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ladang Santara',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        actions: [
          //filter variant
          IconButton(
            onPressed: () {},
            icon: const Icon(
              MdiIcons.filterVariant,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          RoundedContainer(
            hasBorder: true,
            margin: const EdgeInsets.all(10),
            child: SearchField(),
          ),
          Expanded(
            child: RoundedContainer(
              hasBorder: true,
              // borderColor: ThemeApp.primaryColor,\

              margin: const EdgeInsets.all(10),
              child: controller.obx(
                (stores) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: controller.stores.length,
                    itemBuilder: (context, index) {
                      final store = controller.stores[index];
                      return InkWell(
                        onTap: () {
                          Get.to(
                            () => const StoreDetailView(),
                            arguments: store,
                            binding: StoreBinding(),
                          );
                        },
                        child: RoundedContainer(
                          margin: const EdgeInsets.all(5),
                          // padding: const EdgeInsets.all(5),
                          hasBorder: true,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              XPicture(
                                imageUrl: store.logo!,
                                sizeWidth: Get.width,
                                sizeHeight: 100,
                                radiusType: RadiusType.none,
                              ),
                              RoundedContainer(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: Get.width,
                                      child: Text(
                                        store.name!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    SizedBox(
                                      width: Get.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            MdiIcons.mapMarker,
                                            size: 15,
                                            color: ThemeApp.dangerColor,
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            child: Text(
                                              store.address!,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    FutureBuilder(
                                      future: controller.getDistance(
                                          endLatitude: double.parse(store.lat!),
                                          endLongitude:
                                              double.parse(store.long!)),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                MdiIcons.mapMarkerDistance,
                                                size: 20,
                                                color: ThemeApp.primaryColor,
                                              ),
                                              const SizedBox(width: 5),
                                              Text(
                                                controller.locationService
                                                    .formatDistance(snapshot
                                                        .data as double),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return const SizedBox();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                onEmpty: const Center(
                  child: Text('Tidak ada toko'),
                ),
                onLoading: Center(
                  child: Utils.loadingWidget(size: 40),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
