import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Für Firebase Auth Fehler
import '../core/theme.dart';
import '../widgets/custom_input_field.dart';
import '../services/auth_service.dart'; // Dein AuthService

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false; // Zeigt Ladezustand während Login an

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Firebase Auth Login über AuthService
  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // 1) Nutzer per E-Mail/Passwort anmelden
      final user = await AuthService.instance.signInWithEmail(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login fehlgeschlagen. Bitte erneut versuchen.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // 2) Navigation nach erfolgreichem Login
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      // Typische FirebaseAuth Fehler abfangen
      String message = 'Login fehlgeschlagen';

      if (e.code == 'user-not-found') {
        message = 'Kein Benutzer mit dieser E-Mail gefunden';
      } else if (e.code == 'wrong-password') {
        message = 'Falsches Passwort';
      } else if (e.code == 'invalid-email') {
        message = 'Ungültige E-Mail-Adresse';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    } catch (_) {
      // Generischer Fehler-Fallback
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unerwarteter Fehler beim Login'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.peachBackground,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),

                  // "Login here" - Große Headline
                  Text(
                    'Login here',
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: AppTheme.darkGreen,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    "Welcome back! You've been missed!",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppTheme.darkText,
                          fontSize: 18,
                        ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 48),

                  // Email Input Field
                  CustomInputField(
                    controller: _emailController,
                    hintText: 'Email',
                    prefixIcon: Icons.person_outline,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bitte E-Mail eingeben';
                      }
                      if (!value.contains('@')) {
                        return 'Ungültige E-Mail';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Password Input Field
                  CustomInputField(
                    controller: _passwordController,
                    hintText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bitte Passwort eingeben';
                      }
                      if (value.length < 6) {
                        return 'Passwort muss mindestens 6 Zeichen lang sein';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Passwort-Zurücksetzen wird später implementiert'),
                          ),
                        );
                      },
                      child: Text(
                        'Forgot your password?',
                        style: TextStyle(
                          color: AppTheme.darkText,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // "Sign in" Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.oliveGreen,
                        foregroundColor: AppTheme.whiteInput,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 3,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // "New here?" Text
                  Text(
                    'New here?',
                    style: TextStyle(
                      color: AppTheme.darkText,
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // "Create new account" Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.oliveGreen,
                        foregroundColor: AppTheme.whiteInput,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 3,
                      ),
                      child: const Text(
                        'Create new account',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
