import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:puu1/app/data/absen_provider.dart';
import 'package:puu1/app/data/user_provider.dart';
import 'package:puu1/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  XFile? imageFile;
  RxString imagePath = ''.obs;
  RxString imageUrl = ''.obs;
  RxString kelas = ''.obs;
  RxString nis = ''.obs;
  RxString jenisKelamin = ''.obs;
  RxString nama = ''.obs;
  RxString email = ''.obs;

  // Statistics
  RxInt hadir = 0.obs;
  RxInt sakit = 0.obs;
  RxInt izin = 0.obs;
  RxInt terlambat = 0.obs;

  Widget itemProfile(String title, String subtitle, Widget iconData) {
    return Container(
      width: 350,
      padding: const EdgeInsets.only(right: 10, left: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ListTile(
        title: Text(
          title,
          style: GoogleFonts.sora(fontWeight: FontWeight.w300),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.sora(fontWeight: FontWeight.w300),
        ),
        leading: iconData,
        tileColor: Colors.white,
      ),
    );
  }

  @override
  void onInit() {
    myData();
    getStats();
    super.onInit();
  }

  Future<void> myData() async {
    try {
      var response = await UserProvider().getUser();
      var responseBody = response.body;
      var data = responseBody['data'];
      nama.value = data['name'];
      imageUrl.value = data['image'];
      kelas.value = data['kelas'];
      nis.value = data['nis'];
      email.value = data['email'];
      jenisKelamin.value = data['jk'];
      print(data['email']);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat data absensi: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Widget statistik(String title, int jumlah, Color color) {
    return Column(children: [
      Text(
        "$jumlah",
        style: GoogleFonts.sora(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
      ),
      SizedBox(
        height: 6,
      ),
      Container(
        width: 70,
        height: 27,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadiusDirectional.circular(50),
        ),
        child: Center(
          child: Text(title, style: GoogleFonts.sora(fontSize: 12)),
        ),
      )
    ]);
  }

  Future<void> updateProfile(
    String name,
    String nis,
    String jk,
  ) async {
    EasyLoading.show(status: 'Mengirim...');

    try {
      var data = {
        'name': name,
        'nis': nis,
        'gender': jk,
      };
      print(data);
      final response = await UserProvider().updateUser(data);
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        Get.snackbar(
          'Success',
          'Data berhasil diubah',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.offAllNamed(
          Routes.MAIN_MENU,
          arguments: {'tabIndex': 3},
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengirim data: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      EasyLoading.dismiss();
      return;
    }
  }

  Future<void> imgPick(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
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

  Future<void> updateImg() async {
    EasyLoading.show(status: 'Mengirim...');

    try {
      File imageFile = File(imagePath.value);

      final response = await UserProvider().updateImg(imageFile);

      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        Get.snackbar(
          'Sukses',
          'Gambar berhasil diubah',
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
              'Terjadi kesalahan saat mengupdate gambar.',
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

  Future<void> getStats() async {
    try {
      var response = await AbsenProvider().getStats();
      var responseBody = response.body;
      var data = responseBody['data'];
      hadir.value = data['hadir'];
      sakit.value = data['sakit'];
      izin.value = data['izin'];
      terlambat.value = data['terlambat'];
      print(data);
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
