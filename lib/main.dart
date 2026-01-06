import 'package:flutter/material.dart';
<<<<<<< testbranch
import 'core/theme.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart';

/// UniBudget Main App Entry Point
/// Mit Routing für Login, Sign-Up und später Dashboard
void main() => runApp(const UniBudgetApp());

class UniBudgetApp extends StatelessWidget {
  const UniBudgetApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniBudget',
      debugShowCheckedModeBanner: false,

      // App Theme aus theme.dart
      theme: AppTheme.lightTheme,

      // Start mit Login Screen
      initialRoute: '/',

      // Routing Setup
      routes: {
        '/': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        // TODO: Dashboard und weitere Screens hinzufügen
        '/dashboard': (context) => const DashboardScreen(),
        // '/add-expense': (context) => const AddExpenseScreen(),
        // '/history': (context) => const HistoryScreen(),
        // '/statistics': (context) => const StatisticsScreen(),
        // '/settings': (context) => const SettingsScreen(),
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
=======
import 'Screens/login_page.dart';
import 'Screens/page_home.dart';
import 'Screens/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // supprime le bandeau DEBUG
      initialRoute: '/', // page de démarrage
      routes: {
        '/': (context) => PageHome(),
        '/login': (context) => PageLogin(), // page d'accueil
        '/register': (context) => const PageRegister(),
>>>>>>> master
      },
    );
  }
}
