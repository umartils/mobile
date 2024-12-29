import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:puu1/global.dart';
import '../controllers/tababsen_controller.dart';

class TababsenView extends StatefulWidget {
  const TababsenView({super.key});

  @override
  _TababsenViewState createState() => _TababsenViewState();
}

class _TababsenViewState extends State<TababsenView> {
  final TababsenController controller = Get.put(TababsenController());

  @override
  void dispose() {
    // Mengatur ulang imagePath saat halaman ditutup
    controller.imagePath = ''.obs;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 120,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [],
              ),
            ),
            Center(
              child: Text(
                "Upload bukti foto selfie",
                style: GoogleFonts.sora(
                  color: primary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 17),
            Container(
              width: 75,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: primary),
              child: IconButton(
                onPressed: () => controller.imgPick(),
                icon: const Icon(
                  CupertinoIcons.photo_camera_solid,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.imagePath.value != '') {
                return Column(
                  children: [
                    Image.file(
                      File(controller.imagePath.value),
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: controller.submitHadir,
                      style: ElevatedButton.styleFrom(backgroundColor: primary),
                      child: const Text(
                        "Submit",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                );
              } else {
                return Text(
                  "",
                  style: const TextStyle(fontSize: 16),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
