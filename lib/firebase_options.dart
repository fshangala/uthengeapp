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
        return macos;
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
    apiKey: 'AIzaSyBoDC630CN_kojjU6jj0_ANmuPNtjUaM9w',
    appId: '1:1053050806046:web:6e04b1d44bfc9db8a3330f',
    messagingSenderId: '1053050806046',
    projectId: 'exsae-technologies',
    authDomain: 'exsae-technologies.firebaseapp.com',
    databaseURL: 'https://exsae-technologies.firebaseio.com',
    storageBucket: 'exsae-technologies.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDKeklSid6oYSuksCnBgicqLA3bdMIrgPQ',
    appId: '1:1053050806046:android:1a3efaa7d6f628fca3330f',
    messagingSenderId: '1053050806046',
    projectId: 'exsae-technologies',
    databaseURL: 'https://exsae-technologies.firebaseio.com',
    storageBucket: 'exsae-technologies.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyByDELmdc42pzCmX6nU8HHjlh0xZIKd_LI',
    appId: '1:1053050806046:ios:d451fbdf9cd0c48ca3330f',
    messagingSenderId: '1053050806046',
    projectId: 'exsae-technologies',
    databaseURL: 'https://exsae-technologies.firebaseio.com',
    storageBucket: 'exsae-technologies.appspot.com',
    iosClientId: '1053050806046-724ui0aoubgpfvrsu0undkr874m7ofc5.apps.googleusercontent.com',
    iosBundleId: 'com.exsae.tech.uthengeapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyByDELmdc42pzCmX6nU8HHjlh0xZIKd_LI',
    appId: '1:1053050806046:ios:f0f1c55176ea8591a3330f',
    messagingSenderId: '1053050806046',
    projectId: 'exsae-technologies',
    databaseURL: 'https://exsae-technologies.firebaseio.com',
    storageBucket: 'exsae-technologies.appspot.com',
    iosClientId: '1053050806046-5uo6fbnpv4o40aibciqnlj4th1afajsh.apps.googleusercontent.com',
    iosBundleId: 'com.exsae.tech.uthengeapp.RunnerTests',
  );
}
