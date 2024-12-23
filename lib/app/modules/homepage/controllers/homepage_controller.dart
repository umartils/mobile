import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:puu1/app/data/absen_provider.dart';
import 'package:puu1/app/data/user_provider.dart';
import 'package:sp_util/sp_util.dart';

class HomepageController extends GetxController {
  RxString imageUrl = ''.obs;
  RxString nama = ''.obs;
  RxString namaWaktu = ''.obs;
  RxString waktuMasuk = ''.obs;
  RxString waktuKeluar = ''.obs;
  var userImageUrl = '${SpUtil.getString("image")}'.obs;
  RxInt hadir = 0.obs;
  RxInt sakit = 0.obs;
  RxInt izin = 0.obs;
  RxInt terlambat = 0.obs;
  RxInt kehadiran = 0.obs;
  RxInt tidakHadir = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getTime();
    myData();
    getStats();
  }

  Future<void> myData() async {
    try {
      var response = await UserProvider().getUser();
      var responseBody = response.body;
      var data = responseBody['data'];
      nama.value = data['name'];
      imageUrl.value = data['image'];
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat data user: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> getTime() async {
    try {
      var response = await UserProvider().getTime();
      var responseBody = response.body;
      var time = responseBody['data'];
      namaWaktu.value = time['waktu'];
      waktuMasuk.value = time['masuk'];
      waktuKeluar.value = time['keluar'];
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat data waktu: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> getStats() async {
    try {
      var response = await AbsenProvider().getStats();
      var responseBody = response.body;
      var data = responseBody['data'];

      hadir.value = data['hadir'];
      sakit.value = data['sakit'];
      izin.value = data['izin'];
      terlambat.value = data['terlambat'];

      // Hitung jumlah kehadiran dan tidak hadir
      kehadiran.value = hadir.value + terlambat.value;
      tidakHadir.value = sakit.value + izin.value;

      print('Kehadiran: ${kehadiran.value}');
      print('Tidak Hadir: ${tidakHadir.value}');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat data statistik: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
