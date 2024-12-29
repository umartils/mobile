import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:puu1/app/data/absen_provider.dart';

class HistoryController extends GetxController {
  RxList listData = <dynamic>[].obs;
  RxString imagePath = ''.obs;
  RxList searchData = <dynamic>[].obs;

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

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    await getAbsen();
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  @override
  void onInit() async {
    await getAbsen();
    searchData.value = listData;
    super.onInit();
  }

  Future<void> getAbsen() async {
    try {
      var response = await AbsenProvider().getData();
      var responseBody = response.body;

      if (responseBody != null && responseBody['data'] != null) {
        var data = responseBody['data'];
      listData.value = data.map((element) {
        return {
          'id': element['id'],
          'tanggal': element['tanggal'],
          'waktu': element['waktu'],
          'status': element['status'],
        };
      }).toList();
        print("Data berhasil dimuat: $listData");
      } else {
        throw Exception("Data tidak ditemukan dalam respons.");
      }
    } catch (e) {
      // Get.snackbar(
      //   'Error',
      //   'Gagal memuat data absensi: $e',
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
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
        // Get.snackbar(
        //   'Error',
        //   'Gambar tidak ditemukan untuk ID $id.',
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Colors.red,
        //   colorText: Colors.white,
        // );
      }
    } catch (e) {
      imagePath.value = ''; // Pastikan tidak menampilkan data lama
      // Get.snackbar(
      //   'Error',
      //   'Gagal memuat gambar: $e',
      //   snackPosition: SnackPosition.BOTTOM,
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      // );
    }
  }

  void runFilter(String keyword) {
    RxList results = <dynamic>[].obs;
    if (keyword.isEmpty) {
      results.value = listData;
    } else {
      results.value = listData.where((element) {
        return element['tanggal'].toString().contains(keyword.toLowerCase()) ||
            element['waktu'].toString().contains(keyword.toLowerCase()) ||
            element['status'].toString().contains(keyword.toLowerCase());
      }).toList();
    }
    searchData.value = results;
  }
}
