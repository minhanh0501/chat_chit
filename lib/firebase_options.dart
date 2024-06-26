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
    apiKey: 'AIzaSyCAHs9RnOs0JdMKAz2ka-t8nA6-80VvSMs',
    appId: '1:1039011953504:web:5fe62c02f44ce5f8b53c05',
    messagingSenderId: '1039011953504',
    projectId: 'chatchit-73bd9',
    authDomain: 'chatchit-73bd9.firebaseapp.com',
    storageBucket: 'chatchit-73bd9.appspot.com',
    measurementId: 'G-EWW42SX0V9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA5UMmT-8KJUtn4vyOvJ5gwlOugRFA-cOk',
    appId: '1:1039011953504:android:d95fa63adba5ead9b53c05',
    messagingSenderId: '1039011953504',
    projectId: 'chatchit-73bd9',
    storageBucket: 'chatchit-73bd9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCJN6rXOio40qwtqOv4EKlSiw1mqzzzSzM',
    appId: '1:1039011953504:ios:39fb7f745aa443a7b53c05',
    messagingSenderId: '1039011953504',
    projectId: 'chatchit-73bd9',
    storageBucket: 'chatchit-73bd9.appspot.com',
    iosBundleId: 'com.example.chatChit',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCJN6rXOio40qwtqOv4EKlSiw1mqzzzSzM',
    appId: '1:1039011953504:ios:39fb7f745aa443a7b53c05',
    messagingSenderId: '1039011953504',
    projectId: 'chatchit-73bd9',
    storageBucket: 'chatchit-73bd9.appspot.com',
    iosBundleId: 'com.example.chatChit',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCAHs9RnOs0JdMKAz2ka-t8nA6-80VvSMs',
    appId: '1:1039011953504:web:b904427330237ad2b53c05',
    messagingSenderId: '1039011953504',
    projectId: 'chatchit-73bd9',
    authDomain: 'chatchit-73bd9.firebaseapp.com',
    storageBucket: 'chatchit-73bd9.appspot.com',
    measurementId: 'G-K1S5EW6W2Q',
  );
}
