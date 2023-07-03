import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ladangsantara/app/common/buttons/x_button.dart';
import 'package:ladangsantara/app/common/buttons/x_outline_button.dart';
import 'package:ladangsantara/app/common/input/x_field.dart';
import 'package:ladangsantara/app/routes/app_pages.dart';
import 'package:ladangsantara/app/themes/theme.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 19),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    width: Get.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.asset(
                            "assets/icon/icon.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: "Selamat Datang Warga ",
                            style: TextStyle(
                              color: ThemeApp.darkColor,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(
                                text: "Ladang",
                                style: GoogleFonts.poppins(
                                  color: ThemeApp.primaryColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: " Santara",
                                style: GoogleFonts.poppins(
                                  color: ThemeApp.secondaryColor,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Text(
                    "Masuk ke akun anda",
                    style: TextStyle(
                      color: ThemeApp.darkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  XTextField(
                    labelText: "Nomor Telepon",
                    hintText: "+6281xxxx",
                    prefixIcon: MdiIcons.phoneOutline,
                    onSave: (val) {
                      // controller.phone.value = val!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Phone can't be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () {
                      return XTextField(
                        labelText: "Kata sandi",
                        hintText: "pass****123",
                        prefixIcon: MdiIcons.lockOutline,
                        onSave: (val) {
                          controller.password.value = val!;
                        },
                        suffixIcon: controller.isShowPass.value
                            ? MdiIcons.eyeOutline
                            : MdiIcons.eyeOffOutline,
                        obscureText: !controller.isShowPass.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "sandi harus di isi";
                          }
                          if (value.length < 8) {
                            return "minimal 8 karakter";
                          }
                          return null;
                        },
                        onPressSuffix: () {
                          controller.isShowPass.value =
                              !controller.isShowPass.value;
                        },
                      );
                    },
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: ThemeApp.darkColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  XButton(
                    text: "Masuk",
                    hasIcon: true,
                    icon: MdiIcons.login,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        // controller.login();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: ThemeApp.darkColor,
                          thickness: 1,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Or",
                        style: TextStyle(
                          color: ThemeApp.darkColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Divider(
                          color: ThemeApp.darkColor,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // register
                  XOutlineButton(
                    text: "Mendaftar",
                    hasIcon: true,
                    icon: MdiIcons.accountPlusOutline,
                    onPressed: () {
                      // controller.register();
                      Get.toNamed(Routes.REGISTER);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
