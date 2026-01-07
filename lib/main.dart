import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase core init
import 'package:flutter/foundation.dart'
    show kIsWeb; // To detect web at runtime

import 'core/theme.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/page_home.dart';

/// Firebase config for Web (from Firebase Console -> Web app </> firebaseConfig)
const FirebaseOptions webFirebaseOptions = FirebaseOptions(
  apiKey: 'AIzaSyBBNeSkuI9w1whMOdjikMJUz3R-mn8mlDg', // firebaseConfig.apiKey
  authDomain: 'unibudget-57295.firebaseapp.com', // firebaseConfig.authDomain
  projectId: 'unibudget-57295', // firebaseConfig.projectId
  storageBucket:
      'unibudget-57295.firebasestorage.app', // firebaseConfig.storageBucket
  messagingSenderId: '52016585420', // firebaseConfig.messagingSenderId
  appId: '1:52016585420:web:4098c4aab678789e0b4069', // firebaseConfig.appId
);

/// UniBudget Main App Entry Point
/// Mit Routing für Login, Sign-Up und später Dashboard
Future<void> main() async {
  // Flutter binding initialisieren, bevor Plugins wie Firebase verwendet werden
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    // Für Web müssen explizite FirebaseOptions übergeben werden,
    // die exakt dem firebaseConfig aus der Firebase Console entsprechen.
    await Firebase.initializeApp(options: webFirebaseOptions);
  } else {
    // Für Mobile/Desktop würden hier die nativen Config-Dateien gelesen.
    await Firebase.initializeApp();
  }

  runApp(const UniBudgetApp());
}

class UniBudgetApp extends StatelessWidget {
  const UniBudgetApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniBudget',
      debugShowCheckedModeBanner: false,

      // App Theme aus theme.dart
      theme: AppTheme.lightTheme,

      // Start mit Login Screen (aktuell zeigt '/' noch auf PageHome – kannst du später ändern)
      initialRoute: '/',

      // Routing Setup
      routes: {
        '/': (context) => const PageHome(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
      },

      // Temporärer Fallback für Dashboard (bis implementiert)
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            backgroundColor: AppTheme.peachBackground,
            appBar: AppBar(
              title: const Text('UniBudget'),
              backgroundColor: AppTheme.oliveGreen,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    size: 100,
                    color: AppTheme.oliveGreen,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkGreen,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Wird bald implementiert!',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppTheme.darkText,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/',
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.oliveGreen,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: const Text('Zurück zum Login'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
