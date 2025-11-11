import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spymatch/src/core/config/theme.dart';

class MissionDetailsScreen extends StatelessWidget {
  const MissionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Detalles de la Misión'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildMatchHeader(),
            const SizedBox(height: 24),
            _buildInfoCard(
              title: 'Información del Partido',
              children: [
                _InfoTile(icon: Icons.calendar_today, text: '24 Nov, 2024'),
                _InfoTile(icon: Icons.schedule, text: '18:00'),
                _InfoTile(icon: Icons.location_on, text: 'Estadio Castalia', actionText: 'Ver en mapa'),
              ],
            ),
            const SizedBox(height: 24),
            _buildBudgetCard(),
            const SizedBox(height: 24),
            _buildInfoCard(
              title: 'Requisitos del Informe',
              children: [
                _RequirementTile(text: 'Análisis de 2 jugadores específicos'),
                _RequirementTile(text: 'Informe táctico del equipo local'),
                _RequirementTile(text: 'Evaluación de 3 promesas sub-21'),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Aceptar Misión'),
            ),
            TextButton(
              onPressed: () => context.go('/scouting-report'),
              child: const Text('View Report'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _TeamDisplay(
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuC2YFg_TW88WrsE6xXhbosdfbKwLW9GbFvaBT5Z4maO9G0QQFn51lGWw9RQZrMIaraQo_-0jrwWZagZrCExyATdxgxEDUlAJGcjc-vKLHNrtQocOgEjnAP9dP92ryiPk4MCEQgL0lMYsewEhNf8fZzKEtBzO7o1-LXLPzarear-Wf1BMmahk309-19Kn9d6IdScdxLhIBgJkj-aHhuiepV4DCA0OGfOwkYRKP3qAXpxio1HAtYx49EpXHRZ_X4t2GkX_vOw8nFKYg',
          name: 'CD Castellón',
        ),
        const Text('VS', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white54)),
        _TeamDisplay(
          imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDHHDkjCxIODU7jq7MYETQch2O41_7lTjkwCNmeEFZIwaPSefcZxZ5yH_dC8pl8PrWMT776pkoAcrb6DFH4rCAi0mEoVca0xx8SpXKwUJtnT7eXnBYD47vI-cSblquZDm9iwJlzcO0As6gjQNxjK5JehHem3u7nC4i55aRQatgQuaFT8edCOej2jNRLyIpPZU95Ov5y9jQoIHiRMyGWc3dGUA19mkTm7LFcOv33dYCl7z4KN-PGu4CfnBM6OAgsY6-zmhbAA3CrjQ',
          name: 'Intercity CF',
        ),
      ],
    );
  }

  Widget _buildInfoCard({required String title, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardDark.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildBudgetCard() {
    return Container(
       padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardDark.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           const Text('Presupuesto', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
           const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.payments, color: AppTheme.primaryColor),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('150,00 €', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold, fontSize: 20)),
                  Text('Incluye entrada y transporte', style: TextStyle(color: Colors.white.withOpacity(0.7))),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _TeamDisplay extends StatelessWidget {
  const _TeamDisplay({required this.imageUrl, required this.name});
  final String imageUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(imageUrl, height: 64, width: 64),
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.icon, required this.text, this.actionText});
  final IconData icon;
  final String text;
  final String? actionText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70),
          const SizedBox(width: 16),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.white))),
          if (actionText != null)
            TextButton(
              onPressed: () {},
              child: Text(actionText!, style: const TextStyle(color: AppTheme.primaryColor)),
            )
        ],
      ),
    );
  }
}

class _RequirementTile extends StatelessWidget {
  const _RequirementTile({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: AppTheme.primaryColor),
          const SizedBox(width: 16),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.white))),
        ],
      ),
    );
  }
}
