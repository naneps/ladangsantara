import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/shape/rounded_container.dart';
import 'package:ladangsantara/app/common/ui/x_dividerdotted.dart';
import 'package:ladangsantara/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PaymentCodeView extends GetView {
  const PaymentCodeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kode Pembayaran',
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
      body: ListView(
        children: [
          RoundedContainer(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      WidgetSpan(
                        child: Icon(
                          MdiIcons.clockOutline,
                          size: 16,
                        ),
                      ),
                      TextSpan(
                        text: ' Menunggu Pembayaran',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Total Pembayaran : Rp 100.000',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10),
                //batas waktu countdown
                Text(
                  'Batas Waktu Pembayaran : 00:00:00',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          RoundedContainer(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Nomor Virtual Account",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                RoundedContainer(
                  hasBorder: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: ThemeApp.primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "1234567890",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const XDividerDotted(
                        margin: EdgeInsets.symmetric(vertical: 10),
                      ),
                      InkWell(
                        onTap: () {
                          FlutterClipboard.copy(
                            //copy to clipboard
                            "1234567890",
                          ).then(
                            (value) => Get.snackbar(
                              "Berhasil",
                              "Nomor Virtual Account berhasil disalin",
                              shouldIconPulse: true,
                              backgroundColor: Colors.white,
                              colorText: ThemeApp.darkColor,
                              snackPosition: SnackPosition.BOTTOM,
                              duration: const Duration(seconds: 2),
                              icon: Icon(
                                MdiIcons.checkCircleOutline,
                                color: ThemeApp.successColor,
                              ),
                            ),
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //icon
                            Icon(
                              MdiIcons.contentCopy,
                              color: Colors.white,
                              size: 16,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Salin",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
    );
  }
}
