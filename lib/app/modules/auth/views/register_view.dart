import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ladangsantara/app/common/buttons/x_button.dart';
import 'package:ladangsantara/app/common/input/x_field.dart';
import 'package:ladangsantara/app/modules/auth/controllers/auth_controller.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // MAKE COPY WRITER FOR REGISTER
                const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                XTextField(
                  labelText: "Nama",
                  hintText: "Ahmad",
                  prefixIcon: MdiIcons.accountOutline,
                  keyboardType: TextInputType.emailAddress,
                  onSave: (value) {
                    controller.user.value.name = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                XTextField(
                  labelText: "Email",
                  hintText: "ahmad@mail.com",
                  prefixIcon: MdiIcons.accountOutline,
                  keyboardType: TextInputType.emailAddress,
                  onSave: (value) {
                    controller.user.value.email = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                XTextField(
                  labelText: "Password",
                  hintText: "Masukkan Password",
                  prefixIcon: MdiIcons.lockOutline,
                  keyboardType: TextInputType.visiblePassword,
                  onSave: (value) {
                    // print(value);
                    controller.user.value.password = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                XTextField(
                  labelText: "Konfirmasi Password",
                  prefixIcon: MdiIcons.lockOutline,
                  keyboardType: TextInputType.visiblePassword,
                  onSave: (value) {
                    controller.user.value.retypedPassword = value;
                  },
                  validator: (value) {
                    // print(value);
                    print(controller.user.value.password);
                    if (value!.isEmpty) {
                      return "Confirm Password is required";
                    } else if (value != controller.user.value.password) {
                      return "Confirm Password is not match";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                XButton(
                  onPressed: () async {
                    print(controller.user.value.toJson());
                    controller.formKey.currentState!.save();
                    if (controller.formKey.currentState!.validate()) {
                      await controller.register();
                    }
                  },
                  text: "Register Sekarang",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
