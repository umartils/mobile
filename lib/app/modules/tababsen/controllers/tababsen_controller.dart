import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:puu1/app/data/absen_provider.dart';
import 'package:puu1/app/data/user_provider.dart';
import 'package:puu1/app/routes/app_pages.dart';
import 'package:sp_util/sp_util.dart';

class TababsenController extends GetxController {
  RxString namaWaktu = ''.obs;
  RxString waktuMasuk = ''.obs;
  RxString waktuKeluar = ''.obs;
  XFile? imageFile;
  RxString imagePath = ''.obs;
  RxBool telat = false.obs;
  RxBool cekLokasi = false.obs;
  RxBool isLocated = false.obs;

  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;

  RxString userLokasi = ''.obs;
  RxString userLatitude = ''.obs;
  RxString userLongitude = ''.obs;

  @override
  void onInit() async {
    await getTime();
    await compareTimeWithCurrent();
    await checkAndRequestLocationPermission();
    await getCurrentLocation();
    await getLocation();
    await compareLokasi();
    super.onInit();
  }
// @override
//   // void dispose() {
//   //   super.dispose();
//   // }
  Future<void> imgPick() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
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

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude.value = position.latitude;
      longitude.value = position.longitude;
      print("Latitude: $latitude, Longitude: $longitude");
    } catch (e) {
      print('Failed to get location: $e');
    }
  }

  Future<void> checkAndRequestLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permission denied");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permission permanently denied");
      return;
    }

    isLocated.value = true;
  }

  Future<void> submitHadir() async {
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
    if (cekLokasi.value == false) {
      EasyLoading.dismiss();
      Get.snackbar(
        'Peringatan',
        'Lokasi tidak sesuai, silahkan absen di lokasi yang sesuai',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    } else if (cekLokasi.value == true) {
      EasyLoading.show(status: 'Mengirim...');

      try {
        File imageFile = File(imagePath.value);
        var fields = {
          'status': telat.value ? 'Terlambat' : 'Hadir',
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

  Future<void> getTime() async {
    try {
      var response = await UserProvider().getTime();
      var responseBody = response.body;
      var time = responseBody['data'];
      namaWaktu.value = time['waktu'];
      waktuMasuk.value = time['masuk'];
      waktuKeluar.value = time['keluar'];
      print('Waktu masuknya : ${waktuMasuk.value}');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat data absensi: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> compareTimeWithCurrent() async {
    try {
      print('waktuMasuk : ${waktuMasuk.value}');
      String waktuMasukString = waktuMasuk.value;
      print(waktuMasukString);

      if (waktuMasukString.isEmpty) {
        throw FormatException('waktuMasuk kosong');
      }
      if (!RegExp(r'^\d{2}:\d{2}$').hasMatch(waktuMasukString)) {
        throw FormatException(
            'Format waktuMasuk tidak valid: $waktuMasukString');
      }
      DateTime sekarang = DateTime.now();

      List<String> splitTime = waktuMasukString.split(':');
      int jam = int.parse(splitTime[0]);
      int menit = int.parse(splitTime[1]);

      DateTime waktuMasukDateTime = DateTime(
        sekarang.year,
        sekarang.month,
        sekarang.day,
        jam,
        menit,
      );

      if (waktuMasukDateTime.isBefore(sekarang)) {
        telat.value = true;
      } else if (waktuMasukDateTime.isAfter(sekarang)) {
        telat.value = false;
      } else {
        telat.value = false;
      }
    } catch (e) {
      print('Error saat membandingkan waktu: $e');
    }
  }

  Future<void> compareLokasi() async {
    if (userLatitude.isNotEmpty) {
      double latUser = double.parse(userLatitude.value);
      double longUser = double.parse(userLongitude.value);
      const double toleransi = 0.0015; // Toleransi dalam derajat

      if ((latUser - latitude.value).abs() <= toleransi &&
          (longUser - longitude.value).abs() <= toleransi) {
        cekLokasi.value = true;
        print('Lokasi user sama dengan lokasi absensi (dengan toleransi).');
      } else {
        cekLokasi.value = false;
        print('Lokasi user berbeda dengan lokasi absensi.');
      }
    }
  }

  Future<void> getLocation() async {
    try {
      var response = await UserProvider().getLocation();
      var responseBody = response.body;
      var time = responseBody['data'];
      userLokasi.value = time['lokasi'];
      userLatitude.value = time['lat'];
      userLongitude.value = time['long'];
      print('Lokasi user : ${userLokasi.value}');
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat data lokasi: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
