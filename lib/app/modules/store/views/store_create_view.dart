import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/buttons/x_button.dart';
import 'package:ladangsantara/app/common/input/x_field.dart';
import 'package:ladangsantara/app/common/input/xpicker_image.dart';
import 'package:ladangsantara/app/common/shape/rounded_container.dart';
import 'package:ladangsantara/app/common/ui/x_appbar.dart';
import 'package:ladangsantara/app/modules/store/controllers/store_create_controller.dart';

class StoreCreateView extends GetView<StoreCreateController> {
  const StoreCreateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            XAppBar(
              title: "Buat Toko",
              rightIcon: Icons.close,
              onTapRightIcon: () {
                Get.back();
              },
              hasRightIcon: true,
            ),
            Expanded(
              child: RoundedContainer(
                hasBorder: true,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: Form(
                  key: controller.formKey,
                  child: ListView(
                    children: [
                      RoundedContainer(
                        hasBorder: true,
                        child: XPickerImage(
                          onImagePicked: (p0) {},
                          size: 100,
                        ),
                      ),
                      const SizedBox(height: 10),
                      XTextField(
                        labelText: "Nama Toko",
                        hintText: "Masukkan nama toko",
                        onSave: (val) {
                          controller.store.value.name = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Nama toko tidak boleh kosong";
                          }
                          if (value.length < 3) {
                            return "Nama toko minimal 3 karakter";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      XTextField(
                        labelText: "Deskripsi Toko",
                        hintText: "Masukkan deskripsi toko",
                        onSave: (val) {
                          controller.store.value.description = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Deskripsi toko tidak boleh kosong";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      XTextField(
                        labelText: "Alamat Toko",
                        hintText: "Masukkan alamat toko",
                        onSave: (val) {
                          controller.store.value.address = val;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Alamat toko tidak boleh kosong";
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 10),
                      // XButton(
                      //   text: "Pilih Lokasi",
                      //   hasIcon: true,
                      //   icon: Icons.location_on,
                      //   onPressed: () async {
                      //     await controller.getLocation();
                      //   },
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            RoundedContainer(
              padding: const EdgeInsets.all(10),
              child: XButton(
                text: "Simpan",
                onPressed: () async {
                  if (controller.formKey.currentState!.validate()) {
                    controller.formKey.currentState!.save();
                    await controller.createStore();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
