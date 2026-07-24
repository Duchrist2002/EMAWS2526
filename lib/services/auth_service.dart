import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:firebase_core/firebase_core.dart';

// App user
class AppUser {
  final String uid;
  final String? email;
  final String? displayName;
  const AppUser({required this.uid, this.email, this.displayName});
}

// Auth exception
class AuthException implements Exception {
  final String message;
  AuthException(this.message);
  @override
  String toString() => message;
}

// Authentication boundary
abstract class AuthService {
  Stream<AppUser?> authState();
  AppUser? get currentUser;
  bool get isDemo;

  Future<void> signIn({required String email, required String password});
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  });
  Future<void> signOut();

  static final AuthService instance =
      Firebase.apps.isNotEmpty ? FirebaseAuthService() : DemoAuthService();
}

// Real Firebase Auth
class FirebaseAuthService implements AuthService {
  final fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;

  @override
  bool get isDemo => false;

  AppUser? _map(fb.User? u) => u == null
      ? null
      : AppUser(uid: u.uid, email: u.email, displayName: u.displayName);

  @override
  Stream<AppUser?> authState() => _auth.authStateChanges().map(_map);

  @override
  AppUser? get currentUser => _map(_auth.currentUser);

  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
    } on fb.FirebaseAuthException catch (e) {
      throw AuthException(_messageFor(e));
    }
  }

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email.trim(), password: password);
      await cred.user?.updateDisplayName(name.trim());
    } on fb.FirebaseAuthException catch (e) {
      throw AuthException(_messageFor(e));
    }
  }

  @override
  Future<void> signOut() => _auth.signOut();

  String _messageFor(fb.FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'That email address is not valid.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'user-not-found':
        return 'No account found for that email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'weak-password':
        return 'Password is too weak (use at least 6 characters).';
      case 'operation-not-allowed':
        return 'Email/password sign-in is disabled in your Firebase project.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return e.message ?? 'Authentication failed. Please try again.';
    }
  }
}

// Demo auth service
///   email: student@uni.de   password: 123456
/// It also supports sign-up and enforces basic errors, so the auth UI can be
/// demonstrated end-to-end without any backend. State resets on reload.
class DemoAuthService implements AuthService {
  final _controller = StreamController<AppUser?>.broadcast();
  final Map<String, String> _accounts = {'student@uni.de': '123456'};
  final Map<String, String> _names = {'student@uni.de': 'Demo Student'};
  AppUser? _current;

  @override
  bool get isDemo => true;

  @override
  AppUser? get currentUser => _current;

  @override
  Stream<AppUser?> authState() async* {
    yield _current;
    yield* _controller.stream;
  }

  void _emit(AppUser? user) {
    _current = user;
    _controller.add(user);
  }

  @override
  Future<void> signIn({required String email, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final key = email.trim().toLowerCase();
    if (!_accounts.containsKey(key)) {
      throw AuthException('No account found for that email. Create one first.');
    }
    if (_accounts[key] != password) {
      throw AuthException('Incorrect email or password.');
    }
    _emit(AppUser(uid: key, email: key, displayName: _names[key]));
  }

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final key = email.trim().toLowerCase();
    if (_accounts.containsKey(key)) {
      throw AuthException('An account already exists for that email.');
    }
    _accounts[key] = password;
    _names[key] = name.trim();
    _emit(AppUser(uid: key, email: key, displayName: name.trim()));
  }

  @override
  Future<void> signOut() async => _emit(null);
}
