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
    apiKey: 'AIzaSyAWZJkJeB0vDuLKbK0VCzwHl-7HG4DVsSw',
    appId: '1:546326206533:web:ba7b6c43c5a231e929ab2c',
    messagingSenderId: '546326206533',
    projectId: 'joel-db-test',
    authDomain: 'joel-db-test.firebaseapp.com',
    databaseURL: 'https://joel-db-test-default-rtdb.firebaseio.com',
    storageBucket: 'joel-db-test.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB3UbCLr2on7rW98SuarFIsmwByoZRozm8',
    appId: '1:546326206533:android:bcf27a1aa71eab1d29ab2c',
    messagingSenderId: '546326206533',
    projectId: 'joel-db-test',
    databaseURL: 'https://joel-db-test-default-rtdb.firebaseio.com',
    storageBucket: 'joel-db-test.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD92IptOtTanCbmOSQKhrUQuq5p4abPQK4',
    appId: '1:546326206533:ios:cbf04c3ae0db7bd429ab2c',
    messagingSenderId: '546326206533',
    projectId: 'joel-db-test',
    databaseURL: 'https://joel-db-test-default-rtdb.firebaseio.com',
    storageBucket: 'joel-db-test.appspot.com',
    iosBundleId: 'com.example.appCrud04',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD92IptOtTanCbmOSQKhrUQuq5p4abPQK4',
    appId: '1:546326206533:ios:cbf04c3ae0db7bd429ab2c',
    messagingSenderId: '546326206533',
    projectId: 'joel-db-test',
    databaseURL: 'https://joel-db-test-default-rtdb.firebaseio.com',
    storageBucket: 'joel-db-test.appspot.com',
    iosBundleId: 'com.example.appCrud04',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBjQvFQPZ1T9dASmdxRy_qYsNuinXtnGQ0',
    appId: '1:546326206533:web:5ba58355c12ef55029ab2c',
    messagingSenderId: '546326206533',
    projectId: 'joel-db-test',
    authDomain: 'joel-db-test.firebaseapp.com',
    databaseURL: 'https://joel-db-test-default-rtdb.firebaseio.com',
    storageBucket: 'joel-db-test.appspot.com',
  );
}
