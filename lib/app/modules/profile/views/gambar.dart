import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:puu1/app/modules/profile/controllers/profile_controller.dart';
import 'package:puu1/global.dart';

Future<void> showUpdateGambar(
    BuildContext context, ProfileController controller) async {
  // Controller untuk field input
  final TextEditingController nameController =
      TextEditingController(text: controller.nama.value);
  final TextEditingController nisController =
      TextEditingController(text: controller.nis.value);
  final RxString selectedGender = controller.jenisKelamin;

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Update Gambar", style: TextStyle(fontSize: 20)),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => controller.imgPick(ImageSource.camera),
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        CupertinoIcons.photo_camera_solid,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => controller.imgPick(ImageSource.gallery),
                    child: Container(
                      width: 100,
                      height: 50,
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        CupertinoIcons.photo_fill,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
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
                    ],
                  );
                } else {
                  return const Text(
                    'Pilih foto terlebih dahulu.',
                    style: TextStyle(fontSize: 16),
                  );
                }
              }),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              controller.imagePath.value = '';
              Navigator.pop(context);
            },
            child: const Text("Cancel", style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.imagePath != '') {
                controller.updateImg();
              } else {
                Get.snackbar(
                  "Error",
                  "Pilih gambar terlebih dahulu",
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: primary),
            child: Text(
              "Submit",
              style: GoogleFonts.sora(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}
