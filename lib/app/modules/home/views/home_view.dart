import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:puu1/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
              padding: const EdgeInsets.only(left: 35, right: 35, top: 30),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    'asset/images/home.png',
                    width: 200,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Aplikasi Absensi",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                      "Efisiensi Absensi Anda Dimana Saja Kapan Saja\n Dengan Pencatatan Secara Real Time",
                      style: TextStyle(
                          color: Colors.black54, fontFamily: 'Roboto'),
                      textAlign: TextAlign.center),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () => controller.onTapLogin(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF144795),
                        fixedSize: Size(Get.width - 100, 40)),
                    child: Text(
                      "L O G I N",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () => controller.onTapRegister(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        fixedSize: Size(Get.width - 100, 40),
                        side: const BorderSide(
                            width: 2, color: Color(0xFF144795))),
                    child: Text(
                      "S I G N  U P",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
