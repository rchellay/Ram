import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spymatch/src/core/config/theme.dart';
import 'package:spymatch/src/features/missions/presentation/providers/mission_provider.dart';

class CreateMissionReviewScreen extends StatelessWidget {
  const CreateMissionReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Revisa y Confirma', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('Detalles del Partido'),
          _buildMatchDetailsCard(),
          const SizedBox(height: 24),
          _buildSectionTitle('Detalles del Scouting'),
          _buildScoutingDetailsCard(),
          const SizedBox(height: 24),
          _buildSectionTitle('Presupuesto'),
          _buildBudgetCard(),
          const SizedBox(height: 24),
          _buildSectionTitle('Instrucciones Especiales'),
          _buildInstructionsCard(),
        ],
      ),
      bottomNavigationBar: _buildFooter(context),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  Widget _buildMatchDetailsCard() {
    return _InfoCard(
      children: [
        _InfoTile(icon: Icons.shield, text: 'Real Madrid Castilla vs FC Barcelona Atlètic'),
        _InfoTile(icon: Icons.calendar_today, text: '28 de octubre, 2024 - 15:00'),
        _InfoTile(icon: Icons.location_on, text: 'Estadio Alfredo Di Stéfano', subtitle: 'Av. de las Fuerzas Armadas, Madrid'),
      ],
    );
  }

  Widget _buildScoutingDetailsCard() {
    return _InfoCard(
      children: [
        _InfoTile(icon: Icons.assignment, text: 'Informe de Jugador Específico'),
        _InfoTile(icon: Icons.person_search, text: 'Lamine Yamal (Extremo Derecho)'),
      ],
    );
  }

  Widget _buildBudgetCard() {
    return _InfoCard(
      children: [
        _InfoTile(icon: Icons.payments, text: '150.00 €'),
        _InfoTile(icon: Icons.credit_card, text: 'Visa terminada en •••• 1234'),
      ],
    );
  }

  Widget _buildInstructionsCard() {
    return Container(
       padding: const EdgeInsets.all(16),
       decoration: BoxDecoration(
         color: AppTheme.cardDark.withOpacity(0.5),
         borderRadius: BorderRadius.circular(12),
       ),
      child: const Text(
        '"Por favor, centrarse en su capacidad de desbordamiento en el 1 contra 1, y su toma de decisiones en el último tercio del campo. Observar también su trabajo defensivo sin balón."',
        style: TextStyle(color: Colors.white70),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final missionProvider = Provider.of<MissionProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () async {
              try {
                await missionProvider.createMission({
                  'match': 'Real Madrid Castilla vs FC Barcelona Atlètic',
                  'date': '28 de octubre, 2024 - 15:00',
                  'location': 'Estadio Alfredo Di Stéfano',
                  'reportType': 'Informe de Jugador Específico',
                  'player': 'Lamine Yamal (Extremo Derecho)',
                  'budget': 150.00,
                  'paymentMethod': 'Visa terminada en •••• 1234',
                  'instructions': '"Por favor, centrarse en su capacidad de desbordamiento en el 1 contra 1, y su toma de decisiones en el último tercio del campo. Observar también su trabajo defensivo sin balón."',
                  'status': 'pending',
                });
                _showSuccessDialog(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
                );
              }
            },
            child: const Text('Confirmar y Publicar Misión'),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {},
            child: const Text('Volver y Editar'),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1E293B),
          shape: RoundedRectanglebor(borderRadius: BorderRadius.circular(16)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              const Icon(Icons.check_circle, color: AppTheme.primaryColor, size: 64),
              const SizedBox(height: 16),
              const Text('¡Misión publicada con éxito!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 8),
              const Text('Los ojeadores cercanos serán notificados.', style: TextStyle(color: Colors.white70), textAlign: TextAlign.center),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Ver Misiones Activas'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppTheme.cardDark.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: children,
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.icon, required this.text, this.subtitle});
  final IconData icon;
  final String text;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text, style: const TextStyle(color: Colors.white)),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(subtitle!, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ]
              ],
            ),
          )
        ],
      ),
    );
  }
}
