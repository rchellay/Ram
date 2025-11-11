import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spymatch/src/core/config/theme.dart';

class CreateMissionDefineMatchScreen extends StatelessWidget {
  const CreateMissionDefineMatchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Crear Misión', style: TextStyle(fontWeight: FontWeight.bold)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                 Expanded(
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
                 const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Define el Partido',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Selecciona los equipos, la fecha y la hora del encuentro.',
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
            ),
            const SizedBox(height: 24),
            _buildTeamTextField('Equipo Local', 'River Plate'),
            const SizedBox(height: 16),
            _buildTeamTextField('Equipo Visitante', 'Buscar equipo o liga'),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _buildDateTimePicker('Fecha', '24/08/2024', Icons.calendar_today)),
                const SizedBox(width: 16),
                Expanded(child: _buildDateTimePicker('Hora', '20:00', Icons.schedule)),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () => context.go('/create-mission/configure'),
          child: const Text('Siguiente'),
        ),
      ),
    );
  }

  Widget _buildTeamTextField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: const Icon(Icons.search),
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimePicker(String label, String value, IconData icon) {
     return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: value),
          decoration: InputDecoration(
            suffixIcon: Icon(icon),
          ),
        ),
      ],
    );
  }
}
