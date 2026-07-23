import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/theme.dart';
import 'core/theme_controller.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/page_home.dart';
import 'screens/signup_screen.dart';
import 'services/auth_service.dart';

/// UniBudget — a student budget tracker.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Only initialise Firebase once you've run `flutterfire configure`.
  // Until then the app runs in local demo mode (see AuthService).
  if (DefaultFirebaseOptions.isConfigured) {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      debugPrint('Firebase init failed, falling back to demo mode: $e');
    }
  } else {
    debugPrint('⚠️  Firebase not configured — running in local demo mode. '
        'Run `flutterfire configure` to enable real authentication.');
  }

  runApp(const UniBudgetApp());
}

class UniBudgetApp extends StatelessWidget {
  const UniBudgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.instance.mode,
      builder: (context, mode, _) {
        return MaterialApp(
          title: 'UniBudget',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: mode,
          home: const AuthGate(),
          routes: {
            '/signup': (context) => const SignUpScreen(),
          },
        );
      },
    );
  }
}

/// Shows the dashboard when a user is signed in, otherwise the login screen.
/// Reacts to sign-in / sign-out automatically via [AuthService.authState].
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppUser?>(
      stream: AuthService.instance.authState(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData && snapshot.data != null) {
          return const PageHome();
        }
        return const LoginScreen();
      },
    );
  }
}
