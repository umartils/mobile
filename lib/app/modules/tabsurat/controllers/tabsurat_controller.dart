import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:puu1/app/data/absen_provider.dart';
import 'package:puu1/app/routes/app_pages.dart';
import 'package:sp_util/sp_util.dart';

class TabsuratController extends GetxController {
  XFile? imageFile;
  RxString imagePath = ''.obs;

  // Fungsi untuk memilih gambar dari kamera
  Future<void> imgPick() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        imageFile = pickedFile;
        imagePath.value = pickedFile.path;
      } else {
        Get.snackbar(
          'Peringatan',
          'Gambar tidak dipilih!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> submitHadir(String status) async {
    if (imagePath.value == '') {
      EasyLoading.dismiss();
      Get.snackbar(
        'Peringatan',
        'Pilih gambar terlebih dahulu!',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    EasyLoading.show(status: 'Mengirim...');

    try {
      File imageFile = File(imagePath.value);
      var fields = {
        'status': '${status}',
        'users_id': '${SpUtil.getInt('id')}',
      };

      final response = await AbsenProvider().storeAbsen(imageFile, fields);

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        Get.snackbar(
          'Sukses',
          'Absensi berhasil disimpan!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed(Routes.MAIN_MENU);
        imagePath.value = '';
      } else {
        EasyLoading.dismiss();
        Get.snackbar(
          'Gagal',
          response.body['message'] ??
              'Terjadi kesalahan saat menyimpan absensi.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      EasyLoading.dismiss();
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
