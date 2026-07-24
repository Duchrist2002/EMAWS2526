// GENERATED-STYLE PLACEHOLDER — replace with your real values.
//
// To connect your own Firebase project, install the FlutterFire CLI and run:
//
//     dart pub global activate flutterfire_cli
//     flutterfire configure
//
// That command overwrites this file with your project's real options.
// Until then, `DefaultFirebaseOptions.isConfigured` stays false and the app
// runs in a local "demo mode" (see AuthService) so it still works offline.
//
// Docs: https://firebase.google.com/docs/flutter/setup

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
class DefaultFirebaseOptions {
  /// Sentinel used in the placeholders below. Once you run
  /// `flutterfire configure`, real keys replace these and this becomes true.
  static bool get isConfigured => !web.apiKey.startsWith('REPLACE_');

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        return web;
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBBNeSkuI9w1whMOdjikMJUz3R-mn8mlDg',
    appId: '1:52016585420:web:4098c4aab678789e0b4069',
    messagingSenderId: '52016585420',
    projectId: 'unibudget-57295',
    authDomain: 'unibudget-57295.firebaseapp.com',
    storageBucket: 'unibudget-57295.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'REPLACE_WITH_YOUR_ANDROID_API_KEY',
    appId: 'REPLACE_WITH_YOUR_ANDROID_APP_ID',
    messagingSenderId: 'REPLACE_WITH_SENDER_ID',
    projectId: 'REPLACE_WITH_PROJECT_ID',
    storageBucket: 'REPLACE_WITH_PROJECT_ID.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'REPLACE_WITH_YOUR_IOS_API_KEY',
    appId: 'REPLACE_WITH_YOUR_IOS_APP_ID',
    messagingSenderId: 'REPLACE_WITH_SENDER_ID',
    projectId: 'REPLACE_WITH_PROJECT_ID',
    storageBucket: 'REPLACE_WITH_PROJECT_ID.appspot.com',
    iosBundleId: 'de.activeintelligence.unibudget',
  );
}
