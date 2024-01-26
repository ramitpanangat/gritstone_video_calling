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
    apiKey: 'AIzaSyAiVu_ul05oD3_mjPvzc8Mk0EkgV8bGWXY',
    appId: '1:887591657149:web:f323fae3eb5597d22b21d4',
    messagingSenderId: '887591657149',
    projectId: 'gritstone-e7e9d',
    authDomain: 'gritstone-e7e9d.firebaseapp.com',
    storageBucket: 'gritstone-e7e9d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAN_NgVzR3qSgWVDKvb99DM-b3MK3iDg4g',
    appId: '1:887591657149:android:5d5704450e10eb992b21d4',
    messagingSenderId: '887591657149',
    projectId: 'gritstone-e7e9d',
    storageBucket: 'gritstone-e7e9d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAU1JqWrLhNChEsef6NRoO9l0dkPJYhBNw',
    appId: '1:887591657149:ios:e57e0b2a0db00d342b21d4',
    messagingSenderId: '887591657149',
    projectId: 'gritstone-e7e9d',
    storageBucket: 'gritstone-e7e9d.appspot.com',
    androidClientId: '887591657149-mm386bngcqma3pj4j1kfqu17bug60b09.apps.googleusercontent.com',
    iosClientId: '887591657149-lt3i03eri33odejbmlk3h6e54jvoe9s2.apps.googleusercontent.com',
    iosBundleId: 'com.example.gritstoneVideoCall',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAU1JqWrLhNChEsef6NRoO9l0dkPJYhBNw',
    appId: '1:887591657149:ios:22175d1cdb91cd242b21d4',
    messagingSenderId: '887591657149',
    projectId: 'gritstone-e7e9d',
    storageBucket: 'gritstone-e7e9d.appspot.com',
    androidClientId: '887591657149-mm386bngcqma3pj4j1kfqu17bug60b09.apps.googleusercontent.com',
    iosClientId: '887591657149-d5h4helk48tu0rekrt9j5gfvgl5gfl5u.apps.googleusercontent.com',
    iosBundleId: 'com.example.gritstoneVideoCall.RunnerTests',
  );
}