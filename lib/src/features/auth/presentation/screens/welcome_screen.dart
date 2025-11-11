import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF13EC92);
    const backgroundColor = Color(0xFF10221A);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuCGYR2eOnVgS88myBn1unLKqknifABjBZH5JZLRsMOb-RE3RyLz7otCUR-hDJ8pHhy7HCmqotc1nTWVlEgJAFvfzSF5fwWSpEVWRoqZIxUk76E9SogWiIae4em0d5FJY1E8cF9tmVuHPuTWXzXZHKwae95loZ22y6ao8fhNorF-zXS4nUYLoeuUYpOEX6nHyR-miybBECl2oRTKHLxsrVaUn7DflrcP_MN-r1mVcDuz-vAn0XE4gZiBlOtCKQASJXBEkAh4LsSgSg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    backgroundColor.withOpacity(0.5),
                    backgroundColor.withOpacity(0.8),
                    backgroundColor,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(flex: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.travel_explore,
                              color: primaryColor,
                              size: 40,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'SPYMATCH',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -1.5,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'El talento está ahí. Descúbrelo.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                height: 1.2,
                              ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'La plataforma que conecta a entrenadores y ojeadores con el futuro del fútbol.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFB0B0B0),
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(flex: 3),
                      ],
                    ),
                  ),
                  _buildRoleSelection(context, primaryColor),
                  const SizedBox(height: 32),
                  _buildSignInLink(context, primaryColor),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleSelection(BuildContext context, Color primaryColor) {
    return Column(
      children: [
        Text(
          '¿Cómo quieres empezar?',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white.withOpacity(0.9),
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 20),
        _RoleCard(
          icon: Icons.sports,
          title: 'Soy Entrenador',
          subtitle: 'Encuentra jugadores y gestiona tu equipo.',
          primaryColor: primaryColor,
        ),
        const SizedBox(height: 12),
        _RoleCard(
          icon: Icons.visibility,
          title: 'Soy Ojeador',
          subtitle: 'Descubre y sigue a las próximas estrellas.',
          primaryColor: primaryColor,
        ),
        const SizedBox(height: 12),
        _RoleCard(
          icon: Icons.layers,
          title: 'Soy Ambos',
          subtitle: 'Combina la gestión de equipo y el scouting.',
          primaryColor: primaryColor,
        ),
      ],
    );
  }

  Widget _buildSignInLink(BuildContext context, Color primaryColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿Ya tienes cuenta? ',
          style: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: () {
            // TODO: Navigate to Sign In Screen
          },
          child: Text(
            'Inicia sesión',
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.primaryColor,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Handle role selection
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Icon(icon, color: primaryColor, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
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
