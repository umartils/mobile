import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:puu1/app/modules/onbording/views/Onbording.dart';
import 'package:sp_util/sp_util.dart';
import 'app/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('de_DE', null); // Set format lokal
  await SpUtil.getInstance(); // Inisialisasi shared preferences
  await Firebase.initializeApp(
      options:
          DefaultFirebaseOptions.currentPlatform); // Firebase initialization

  // Handle Firebase Messaging permissions and notifications
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
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

  // Menunggu hasil dari _getInitialRoute() sebelum menjalankan aplikasi
  String initialRoute = await _getInitialRoute(); // Menunggu hasilnya

  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: initialRoute, // Menggunakan hasil _getInitialRoute()
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

// Perbaiki logika _getInitialRoute menjadi async
Future<String> _getInitialRoute() async {
  bool isFirstInstall = SpUtil.getBool('isFirstInstall', defValue: true)!;

  if (isFirstInstall) {
    await SpUtil.putBool('isFirstInstall', false);
    return Routes.ONBOARDING;
  }

  // Jika sudah pernah install, cek status login
  bool isLoggedIn = SpUtil.getBool('isLogin', defValue: false)!;
  return isLoggedIn ? Routes.MAIN_MENU : Routes.LOGIN;
}
