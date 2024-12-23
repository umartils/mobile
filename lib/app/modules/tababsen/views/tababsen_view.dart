import 'dart:io';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          top: 30,
        ),
        child: Column(
          children: [
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: controller.imgPick,
              style: ElevatedButton.styleFrom(backgroundColor: primary),
              child: Text(
                "Ambil Foto Selfie",
                style: GoogleFonts.sora(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
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
                  "Ambil foto terlebih dahulu. ${controller.namaWaktu.value}",
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
