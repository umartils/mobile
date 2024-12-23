import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:puu1/app/data/absen_provider.dart';

class HistoryController extends GetxController {
  RxList listData = <dynamic>[].obs;
  RxString imagePath = ''.obs;

  Color getStatusColor(String status) {
    switch (status) {
      case 'Hadir':
        return const Color(0xFF8FF3AD);
      case 'Terlambat':
        return const Color(0xFFFECA3E);
      case 'Sakit':
        return const Color(0xFFF14642);
      case 'Izin':
        return const Color(0xFF83C7FF);
      default:
        return const Color(0xFF8FF3AD); // Default Hadir
    }
  }

  @override
  void onInit() {
    getAbsen();
    super.onInit();
  }

  Future<void> getAbsen() async {
    try {
      var response = await AbsenProvider().getData();
      var responseBody = response.body;
      var data = responseBody['data'];

      listData.value = data.map((element) {
        return {
          'id': element['id'],
          'tanggal': element['tanggal'],
          'waktu': element['waktu'],
          'status': element['status'],
        };
      }).toList();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat data absensi: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // Fungsi ini bisa dipanggil setelah submit absen
  void addAbsen(Map<String, dynamic> absen) {
    listData.insert(0, absen);
  }

  Future<void> getImg(int id) async {
    try {
      var response = await AbsenProvider().getImg(id);
      var responseBody = response.body;

      // Validasi data respons
      if (responseBody != null && responseBody['data'] != null) {
        imagePath.value = responseBody['data']['image'];
        print(responseBody);
      } else {
        imagePath.value = ''; // Kosongkan jika tidak ada data
        Get.snackbar(
          'Error',
          'Gambar tidak ditemukan untuk ID $id.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      imagePath.value = ''; // Pastikan tidak menampilkan data lama
      Get.snackbar(
        'Error',
        'Gagal memuat gambar: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
