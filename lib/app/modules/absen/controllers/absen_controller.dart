import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:puu1/app/data/absen_provider.dart';

class AbsenController extends GetxController {
  @override
  void onInit() async {
    await getLokasi();
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
