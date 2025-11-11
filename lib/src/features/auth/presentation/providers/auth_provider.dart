import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spymatch/src/features/auth/data/repositories/firebase_auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuthRepository _authRepository;
  final FirebaseFirestore _firestore;

  AuthProvider({required FirebaseAuthRepository authRepository, FirebaseFirestore? firestore})
      : _authRepository = authRepository,
        _firestore = firestore ?? FirebaseFirestore.instance;

  User? _user;
  User? get user => _user;

  Stream<User?> get authStateChanges => _authRepository.authStateChanges;

  Future<void> signUpWithRole(String email, String password, String role) async {
    UserCredential userCredential = await _authRepository.signUp(email, password);
    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'email': email,
      'role': role,
    });
  }

  Future<void> signIn(String email, String password) async {
    await _authRepository.signIn(email, password);
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }
}
