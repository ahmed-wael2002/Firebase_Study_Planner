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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB8nZW4A59WWjbJcb7Xe-yzOtNZAfl6L_k',
    appId: '1:894956326784:web:d46d99ce54ede55774bb65',
    messagingSenderId: '894956326784',
    projectId: 'lab-assessment-b65b9',
    authDomain: 'lab-assessment-b65b9.firebaseapp.com',
    storageBucket: 'lab-assessment-b65b9.firebasestorage.app',
    measurementId: 'G-C807SKPVPN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1IwZnDv-pus45p2WqnL4RgB5kYrsRQ14',
    appId: '1:894956326784:android:196382d29da43da974bb65',
    messagingSenderId: '894956326784',
    projectId: 'lab-assessment-b65b9',
    storageBucket: 'lab-assessment-b65b9.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBosaKfZHfTzZKfCQLBtiXAyYU6wXYbKkw',
    appId: '1:894956326784:ios:5e018aea7e1d2c4d74bb65',
    messagingSenderId: '894956326784',
    projectId: 'lab-assessment-b65b9',
    storageBucket: 'lab-assessment-b65b9.firebasestorage.app',
    iosBundleId: 'com.lab.labAssessment3',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB8nZW4A59WWjbJcb7Xe-yzOtNZAfl6L_k',
    appId: '1:894956326784:web:0b68ba866b6a862a74bb65',
    messagingSenderId: '894956326784',
    projectId: 'lab-assessment-b65b9',
    authDomain: 'lab-assessment-b65b9.firebaseapp.com',
    storageBucket: 'lab-assessment-b65b9.firebasestorage.app',
    measurementId: 'G-XYJXWGXTZ0',
  );
}