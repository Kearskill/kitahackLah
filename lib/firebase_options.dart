// lib/firebase_options.dart

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJtXxVNNa_51rfHW6yx-zdnqbROewjgwQ',
    appId: '1:486655634814:android:8840191d098bd7addfd72f',
    messagingSenderId: '486655634814',
    projectId: 'doctelemy',
    storageBucket: 'doctelemy.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDJtXxVNNa_51rfHW6yx-zdnqbROewjgwQ',
    appId: '1:486655634814:ios:c0e7bcc2b1f01a9adfd72f',
    messagingSenderId: '486655634814',
    projectId: 'doctelemy',
    storageBucket: 'doctelemy.firebasestorage.app',
    iosBundleId: 'com.example.kitahackApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDJtXxVNNa_51rfHW6yx-zdnqbROewjgwQ',
    appId: '1:486655634814:ios:c0e7bcc2b1f01a9adfd72f',
    messagingSenderId: '486655634814',
    projectId: 'doctelemy',
    storageBucket: 'doctelemy.firebasestorage.app',
    iosBundleId: 'com.example.kitahackApp',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDJtXxVNNa_51rfHW6yx-zdnqbROewjgwQ',
    appId: '1:486655634814:web:eea9b218718bfadbdfd72f',
    messagingSenderId: '486655634814',
    projectId: 'doctelemy',
    storageBucket: 'doctelemy.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDJtXxVNNa_51rfHW6yx-zdnqbROewjgwQ',
    appId: '1:486655634814:web:ffab0e4721d4cf7fdfd72f',
    messagingSenderId: '486655634814',
    projectId: 'doctelemy',
    storageBucket: 'doctelemy.firebasestorage.app',
  );
}