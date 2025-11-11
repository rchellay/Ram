import 'package:flutter/material.dart';
import 'package:spymatch/src/core/config/theme.dart';

class CoachDashboardScreen extends StatelessWidget {
  const CoachDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuD0UlawodlBXDtIPyCUVBsM1lLqE4eijvb63PJsFjH0mkW_TtIdq_RTEdDy2YJtgk0pOfPKCujNXfIdLtIsUuck96F_fPG19ip8cc4MSzDj8mTYPOxa6-3CGyyoxycJgSfGSF5oKussXuFCLA1QhXDXzwglyRttQq66rtJwvrx-nSnIvWZXHatIWgwQkfkDhlYMIfS088TqY33_VX1rMkzDbNqZknjhuGuJlzTfYJ4MIso2e55Nzy3lQgmvQt0fzTXYR0TOqnWuHg'),
          ),
        ),
        title: const Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildHeader(context),
          const SizedBox(height: 16),
          _buildTeamSelector(),
          const SizedBox(height: 24),
          _buildUpcomingOpponents(context),
          const SizedBox(height: 24),
          _buildSummary(),
          const SizedBox(height: 24),
          _buildActiveMissions(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Hola, Entrenador',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.swap_horiz, color: AppTheme.primaryColor),
          label: const Text('Modo Ojeador', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: AppTheme.primaryColor),
            backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
        )
      ],
    );
  }

  Widget _buildTeamSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.cardDark.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: 'club-atletico-sol',
          isExpanded: true,
          icon: const Icon(Icons.expand_more, color: Colors.white70),
          dropdownColor: AppTheme.cardDark,
          items: const [
            DropdownMenuItem(value: 'club-atletico-sol', child: Text('Club Atlético del Sol', style: TextStyle(color: Colors.white))),
            DropdownMenuItem(value: 'deportivo-la-luna', child: Text('Deportivo La Luna', style: TextStyle(color: Colors.white))),
            DropdownMenuItem(value: 'union-estelar-fc', child: Text('Unión Estelar FC', style: TextStyle(color: Colors.white))),
          ],
          onChanged: (value) {},
        ),
      ),
    );
  }

  Widget _buildUpcomingOpponents(BuildContext context) {
    return _buildSectionCard(
      title: 'Próximos Rivales',
      actionText: 'Ver calendario',
      onActionPressed: () {},
      child: Column(
        children: [
          _OpponentTile(
            initials: 'RC',
            name: 'Rayo Carmesí',
            time: 'En 3 días',
            color: Colors.red,
          ),
          _OpponentTile(
            initials: 'CA',
            name: 'CF Atlántida',
            time: 'En 10 días',
            color: Colors.blue,
          ),
          _OpponentTile(
            initials: 'UE',
            name: 'Unión Eterna',
            time: 'En 17 días',
            color: Colors.yellow,
          ),
        ],
      ),
    );
  }

  Widget _buildSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tu Resumen',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _SummaryCard(title: 'Misiones Activas', value: '5'),
            const SizedBox(width: 16),
            _SummaryCard(title: 'Informes Hoy', value: '12'),
            const SizedBox(width: 16),
            _SummaryCard(title: 'Scouts', value: '8'),
          ],
        ),
      ],
    );
  }

  Widget _buildActiveMissions(BuildContext context) {
    return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Misiones Activas',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
            ),
             TextButton(
              onPressed: (){},
              child: const Text('Ver todas', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
            )
          ],
        ),
        const SizedBox(height: 16),
        _MissionTile(
          title: 'Delantero Centro Sub-21',
          location: 'Cádiz, España',
          status: 'Activa',
          statusColor: Colors.green,
          reportCount: 15,
          deadline: '30 Nov',
        ),
        const SizedBox(height: 12),
        _MissionTile(
          title: 'Lateral Izquierdo Rápido',
          location: 'Lisboa, Portugal',
          status: 'Recibiendo',
          statusColor: Colors.blue,
          reportCount: 8,
          deadline: '15 Dic',
        ),
      ],
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String actionText,
    required VoidCallback onActionPressed,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              TextButton(
                onPressed: onActionPressed,
                child: Text(actionText, style: const TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _OpponentTile extends StatelessWidget {
  const _OpponentTile({
    required this.initials,
    required this.name,
    required this.time,
    required this.color,
  });

  final String initials;
  final String name;
  final String time;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Text(initials, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text(time, style: const TextStyle(color: Colors.white60, fontSize: 12)),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: AppTheme.primaryColor),
            style: IconButton.styleFrom(
              backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.cardDark.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold, fontSize: 28)),
          ],
        ),
      ),
    );
  }
}

class _MissionTile extends StatelessWidget {
  const _MissionTile({
    required this.title,
    required this.location,
    required this.status,
    required this.statusColor,
    required this.reportCount,
    required this.deadline,
  });

  final String title;
  final String location;
  final String status;
  final Color statusColor;
  final int reportCount;
  final String deadline;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardDark.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
         border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(location, style: const TextStyle(color: Colors.white70)),
                ],
              ),
              Container(
                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                 decoration: BoxDecoration(
                   color: statusColor.withOpacity(0.2),
                   borderRadius: BorderRadius.circular(20),
                 ),
                child: Row(
                  children: [
                     Icon(Icons.circle, color: statusColor, size: 8),
                     const SizedBox(width: 4),
                     Text(status, style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.description, color: Colors.white70, size: 16),
                  const SizedBox(width: 4),
                  Text('$reportCount Informes', style: const TextStyle(color: Colors.white70)),
                ],
              ),
              Text('Cierra: $deadline', style: const TextStyle(color: Colors.white70)),
            ],
          )
        ],
      ),
    );
  }
}
