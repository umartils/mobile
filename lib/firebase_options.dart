// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCImp2Svi8Ulu0zObrR0vo8P2O7l7HwT_4',
    appId: '1:101551552206:web:a14f2f4c1bc816cdea029f',
    messagingSenderId: '101551552206',
    projectId: 'puumobile-7d5b1',
    authDomain: 'puumobile-7d5b1.firebaseapp.com',
    storageBucket: 'puumobile-7d5b1.firebasestorage.app',
    measurementId: 'G-KP9F8RP2NZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAOLKqM0SUjibFeCWbW54UQ5oM3t4NTcwo',
    appId: '1:101551552206:android:98adb3773fb944bdea029f',
    messagingSenderId: '101551552206',
    projectId: 'puumobile-7d5b1',
    storageBucket: 'puumobile-7d5b1.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC5JjAn9b1rCTuI2aEsvQGyK6R1cTP1rG8',
    appId: '1:101551552206:ios:72fb8c6bb45500d1ea029f',
    messagingSenderId: '101551552206',
    projectId: 'puumobile-7d5b1',
    storageBucket: 'puumobile-7d5b1.firebasestorage.app',
    iosBundleId: 'com.example.puu1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC5JjAn9b1rCTuI2aEsvQGyK6R1cTP1rG8',
    appId: '1:101551552206:ios:72fb8c6bb45500d1ea029f',
    messagingSenderId: '101551552206',
    projectId: 'puumobile-7d5b1',
    storageBucket: 'puumobile-7d5b1.firebasestorage.app',
    iosBundleId: 'com.example.puu1',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCImp2Svi8Ulu0zObrR0vo8P2O7l7HwT_4',
    appId: '1:101551552206:web:9ca0921821788a64ea029f',
    messagingSenderId: '101551552206',
    projectId: 'puumobile-7d5b1',
    authDomain: 'puumobile-7d5b1.firebaseapp.com',
    storageBucket: 'puumobile-7d5b1.firebasestorage.app',
    measurementId: 'G-CMJPKEDPTK',
  );
}