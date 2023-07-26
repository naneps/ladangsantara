import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/input/search_field.dart';
import 'package:ladangsantara/app/common/shape/rounded_container.dart';
import 'package:ladangsantara/app/common/utils.dart';
import 'package:ladangsantara/app/modules/store/controllers/store_index_controller.dart';
import 'package:ladangsantara/app/modules/store/widgets/card_store.dart';
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
            child: SearchField(
              hintText: 'Cari toko',
              onChanged: (value) {
                controller.search.value = value;
              },
            ),
          ),
          Expanded(
            child: RoundedContainer(
              // hasBorder: true,
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              color: Colors.transparent,
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
                      return CardStore(store: store).animate().scaleXY(
                            duration: Duration(
                              milliseconds: ((index + 1) * 300).clamp(100, 500),
                            ),
                          );
                    },
                  );
                },
                onEmpty: const Center(
                  child: Text(
                    'Tidak ada toko yang ditemukan',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
