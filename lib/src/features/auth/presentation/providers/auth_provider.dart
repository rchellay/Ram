import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spymatch/src/features/auth/data/repositories/firebase_auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuthRepository _authRepository;

  AuthProvider({required FirebaseAuthRepository authRepository})
      : _authRepository = authRepository;

  User? _user;
  User? get user => _user;

  Stream<User?> get authStateChanges => _authRepository.authStateChanges;

  Future<void> signUp(String email, String password) async {
    await _authRepository.signUp(email, password);
  }

  Future<void> signIn(String email, String password) async {
    await _authRepository.signIn(email, password);
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }
}
