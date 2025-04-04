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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAQK0RrmtgBKO2bNDZQA_E5w80T0mFnLAg',
    appId: '1:895023689590:web:c64336ce5306e09c5ed457',
    messagingSenderId: '895023689590',
    projectId: 'thietbididong-a8c56',
    authDomain: 'thietbididong-a8c56.firebaseapp.com',
    storageBucket: 'thietbididong-a8c56.firebasestorage.app',
    measurementId: 'G-TDQ5TK35B9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAEaqG1ex5zSrEH2oI393JfN-Ft3Vs9QfE',
    appId: '1:895023689590:android:6c30397b1073bb7a5ed457',
    messagingSenderId: '895023689590',
    projectId: 'thietbididong-a8c56',
    storageBucket: 'thietbididong-a8c56.firebasestorage.app',
  );
}
