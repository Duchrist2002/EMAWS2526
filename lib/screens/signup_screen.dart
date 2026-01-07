import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth errors
import '../core/theme.dart';
import '../widgets/custom_input_field.dart';
import '../services/auth_service.dart'; // Our AuthService

/// Sign Up Screen - Ähnlicher Stil wie Login Screen
/// Firebase Auth Registration ist hier eingebunden
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false; // zeigt Ladezustand während der Registrierung an

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Firebase Auth Registration über AuthService
  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwörter stimmen nicht überein'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 1) User in Firebase Authentication anlegen
      final user = await AuthService.instance.signUpWithEmail(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // 2) Optional: Display Name setzen
      if (user != null && _nameController.text.isNotEmpty) {
        await AuthService.instance.updateDisplayName(_nameController.text);
      }

      // 3) TODO: Benutzer in Firestore speichern (z.B. Profil-Dokument anlegen)

      // 4) Navigation zum Dashboard/Home nach erfolgreichem Sign-Up
      if (!mounted) return;
      // Du hast aktuell kein '/dashboard'-Route; deshalb besser '/home' verwenden
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      // Spezifische Fehlermeldungen für typische FirebaseAuth-Fehler
      String message = 'Registrierung fehlgeschlagen';

      if (e.code == 'email-already-in-use') {
        message = 'Diese E-Mail wird bereits verwendet';
      } else if (e.code == 'weak-password') {
        message = 'Das Passwort ist zu schwach';
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
          content: Text('Unerwarteter Fehler bei der Registrierung'),
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

                  // "Create Account" - Große Headline
                  Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: AppTheme.darkGreen,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                  ),

                  const SizedBox(height: 16),

                  // Subtitle
                  Text(
                    'Create an account to get started',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppTheme.darkText,
                          fontSize: 18,
                        ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 48),

                  // Name Input Field
                  CustomInputField(
                    controller: _nameController,
                    hintText: 'Full Name',
                    prefixIcon: Icons.person_outline,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bitte Namen eingeben';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  // Email Input Field
                  CustomInputField(
                    controller: _emailController,
                    hintText: 'Email',
                    prefixIcon: Icons.email_outlined,
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

                  const SizedBox(height: 20),

                  // Confirm Password Input Field
                  CustomInputField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Bitte Passwort bestätigen';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 32),

                  // "Sign up" Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleSignUp,
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
                              'Sign up',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // "Already have an account?" Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: AppTheme.darkText,
                          fontSize: 14,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            color: AppTheme.oliveGreen,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
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
