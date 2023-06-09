// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyDKz2A3yePazdDq_rFQUXwmNV4mydEruzg',
    appId: '1:40463740783:web:f8396c8149f07e38cc429a',
    messagingSenderId: '40463740783',
    projectId: 'football-team-list',
    authDomain: 'football-team-list.firebaseapp.com',
    storageBucket: 'football-team-list.appspot.com',
    measurementId: 'G-8CX0YBSGG6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAkelTwP8Cx7UmdOen9OsfAuuXSyzHip4A',
    appId: '1:40463740783:android:186c449c0965f3fccc429a',
    messagingSenderId: '40463740783',
    projectId: 'football-team-list',
    storageBucket: 'football-team-list.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDFwttDG9VXhTq7Lf_AnpSOo3Jp7L68LdY',
    appId: '1:40463740783:ios:2857d04afef41ca8cc429a',
    messagingSenderId: '40463740783',
    projectId: 'football-team-list',
    storageBucket: 'football-team-list.appspot.com',
    iosClientId: '40463740783-13b8eeuidtuv5encklgnim202mqaoip8.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterListTimes',
  );
}
