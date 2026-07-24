// Firebase options placeholder

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

// Default FirebaseOptions
class DefaultFirebaseOptions {
  // Configured flag
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
    apiKey: 'AIzaSyDjPe7Bhmz35zIYpCveGKJ0zx8hbYHEQeQ',
    appId: '1:52016585420:android:61366323e8dd4be30b4069',
    messagingSenderId: '52016585420',
    projectId: 'unibudget-57295',
    storageBucket: 'unibudget-57295.firebasestorage.app',
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
