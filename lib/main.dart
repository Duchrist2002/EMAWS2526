import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'core/theme.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/page_home.dart';
import 'screens/dashboard_screen.dart';
import 'screens/Add_Expense.dart';

const FirebaseOptions webFirebaseOptions = FirebaseOptions(
  apiKey: 'AIzaSyBBNeSkuI9w1whMOdjikMJUz3R-mn8mlDg',
  authDomain: 'unibudget-57295.firebaseapp.com',
  projectId: 'unibudget-57295',
  storageBucket: 'unibudget-57295.firebasestorage.app',
  messagingSenderId: '52016585420',
  appId: '1:52016585420:web:4098c4aab678789e0b4069',
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(options: webFirebaseOptions);
  } else {
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
      theme: AppTheme.lightTheme,
      initialRoute: '/login',
      routes: {
        '/': (context) => const PageHome(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/add_expense': (context) => const AddExpenseScreen(),
      },
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
                    'Page non trouvée',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkGreen,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'La route "${settings.name}" n\'existe pas.',
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
                        '/login',
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
                    child: const Text('Retour au Login'),
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
