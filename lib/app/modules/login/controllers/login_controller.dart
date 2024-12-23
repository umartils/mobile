import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:puu1/app/data/login_provider.dart';
import 'package:puu1/app/routes/app_pages.dart';
import 'package:sp_util/sp_util.dart';

class LoginController extends GetxController {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  RxBool hidePass = false.obs;

  Future<void> auth() async {
    String fcm_token = "";
    await FirebaseMessaging.instance.getToken().then((value) {
      fcm_token = value!;
    });
    String email = txtEmail.text;
    String password = txtPassword.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email atau Password tidak boleh kosong",
          backgroundColor: Colors.red, colorText: Colors.white);
    } else {
      EasyLoading.show();
      var data = {
        "email": email,
        "password": password,
        "fcm_token": fcm_token,
      };
      LoginProvider().postUser(data).then((value) {
        if (value.statusCode == 200) {
          var responseBody = value.body;
          var data = responseBody['data'];
          SpUtil.putInt('id', data['id']);
          // SpUtil.putString('name', data['name']);
          // SpUtil.putString('email', data['email']);
          // SpUtil.putString('image', data['image']);
          SpUtil.putBool('isLogin', true);
          SpUtil.putString('token', responseBody['token']);
          Get.snackbar("Success", "Login Berhasil",
              backgroundColor: Colors.green, colorText: Colors.white);
          print("Response Body: ${data}\n");
          print("Token: ${responseBody['token']}");

          Future.delayed(const Duration(seconds: 2), () {
            Get.offAllNamed(Routes.MAIN_MENU);
          });
        } else if (value.statusCode == 401) {
          Get.snackbar("Error", "Email atau Password Salah",
              backgroundColor: Colors.red, colorText: Colors.white);
        } else {
          Get.snackbar("Error", "Login Gagal",
              backgroundColor: Colors.red, colorText: Colors.white);
        }
        EasyLoading.dismiss();
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    showPass();
    hidePass.value = true;
  }

  void showPass() {
    hidePass.value = !hidePass.value;
    print("hidePass: ${hidePass.value}");
  }
}
