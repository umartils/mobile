import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:puu1/app/data/register_provider.dart';
import 'package:puu1/app/routes/app_pages.dart';

class RegisterController extends GetxController {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  Future<void> register() async {
    String name = txtName.text;
    String email = txtEmail.text;
    String password = txtPassword.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email atau Password tidak boleh kosong",
          backgroundColor: Colors.red, colorText: Colors.white);
    } else {
      EasyLoading.show();
      var data = {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": password,
      };
      RegisterProvider().addUser(data).then((value) {
        if (value.statusCode == 200) {
          Get.snackbar("Success", "Sign Up Berhasil",
              backgroundColor: Colors.green, colorText: Colors.white);
          Future.delayed(const Duration(seconds: 2), () {
            Get.offAllNamed(Routes.LOGIN);
          });
        } else {
          Get.snackbar("Error", "Sign Up Gagal",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
        EasyLoading.dismiss();
      });
    }
  }
}
