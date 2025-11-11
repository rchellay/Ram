import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:spymatch/src/core/config/theme.dart';
import 'package:spymatch/src/features/auth/presentation/providers/auth_provider.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context, user),
              const Spacer(),
              _buildTitle(context, user),
              const SizedBox(height: 32),
              _RoleCard(
                icon: Icons.draw,
                title: 'Modo Entrenador',
                subtitle: 'Publica necesidades de tu equipo, gestiona candidatos y contacta ojeadores.',
                iconBackgroundColor: const Color(0xFF28A745),
                onTap: () => _updateRoleAndNavigate(context, 'coach'),
              ),
              const SizedBox(height: 16),
              _RoleCard(
                icon: Icons.eyeglasses,
                title: 'Modo Ojeador',
                subtitle: 'Descubre nuevos talentos, analiza perfiles de jugadores y responde a ofertas.',
                iconBackgroundColor: const Color(0xFF007BFF),
                onTap: () => _updateRoleAndNavigate(context, 'scout'),
              ),
              const Spacer(flex: 2),
              _buildLogoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateRoleAndNavigate(BuildContext context, String role) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.user;

    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'email': user.email,
        'role': role,
      }, SetOptions(merge: true));
    }

    context.go('/home');
  }

  Widget _buildHeader(BuildContext context, User? user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.sports_soccer, color: AppTheme.primaryColor, size: 24),
            const SizedBox(width: 8),
            Text(
              'SPYMATCH',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.account_circle, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildTitle(BuildContext context, User? user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hola, ${user?.email ?? ''}',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(
          '¿Cómo quieres empezar hoy?',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    return TextButton.icon(
      onPressed: () async {
        await authProvider.signOut();
        context.go('/');
      },
      icon: const Icon(Icons.logout, color: Colors.white60),
      label: const Text(
        'Cerrar sesión',
        style: TextStyle(color: Colors.white60, fontWeight: FontWeight.bold),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconBackgroundColor,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconBackgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF193328),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF92c9b2),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
