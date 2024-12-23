import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sp_util/sp_util.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'package:geolocator/geolocator.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
// Future<Position> _getCurrentLocation() async {
//   bool servicesEnabled = await Geolocator.isLocationServiceEnabled();
//   if (!servicesEnabled) {
//     return Future.error("Lokasi tidak ditemukan.");
//   }

//   LocationPermission permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       return Future.error("Permintaan lokasi dibatalkan.");
//     }
//   }

//   if (permission == LocationPermission.deniedForever) {
//     return Future.error("Lokasi tidak diperbolehkan.");
//   }

//   return await Geolocator.getCurrentPosition();
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('de_DE', null);
  await SpUtil.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      RemoteNotification notification = message.notification!;
      Get.defaultDialog(
        title: notification.title!,
        content: Text(notification.body!),
        textConfirm: "OK",
        contentPadding: const EdgeInsets.all(10),
        titlePadding: const EdgeInsets.all(10),
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.back();
        },
      );
    }
  });

  print('User granted permission: ${settings.authorizationStatus}');
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: (SpUtil.getBool('isLogin', defValue: false)!
          ? Routes.MAIN_MENU
          : Routes.HOME),
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
