import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MainMenuController extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() async {
    final initialTabIndex = Get.arguments?['selectedIndex'] ?? 0;
    tabIndex.value = initialTabIndex;
    // getLokasi();
    super.onInit();
  }

  Future<Position> getLokasi() async {
    bool servicesEnabled = await Geolocator.isLocationServiceEnabled();
    if (!servicesEnabled) {
      return Future.error("Lokasi tidak ditemukan.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Permintaan lokasi dibatalkan.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error("Lokasi tidak diperbolehkan.");
    }

    return await Geolocator.getCurrentPosition();
  }
}
