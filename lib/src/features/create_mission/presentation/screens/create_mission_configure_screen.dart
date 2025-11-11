import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spymatch/src/core/config/theme.dart';

class CreateMissionConfigureScreen extends StatelessWidget {
  const CreateMissionConfigureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Configurar Misión', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepIndicator(context),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Elige el tipo de informe'),
            _buildReportTypeSelector(),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Define tu presupuesto'),
            _buildBudgetInput(),
            const SizedBox(height: 24),
            _buildSectionTitle(context, 'Instrucciones especiales'),
            _buildInstructionsInput(),
          ],
        ),
      ),
       bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () => context.go('/create-mission/review'),
          child: const Text('Revisar y Publicar'),
        ),
      ),
    );
  }

  Widget _buildStepIndicator(BuildContext context) {
    return Column(
      children: [
        Text('Paso 2 de 3', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDot(isActive: false),
            const SizedBox(width: 8),
            _buildDot(isActive: true),
            const SizedBox(width: 8),
            _buildDot(isActive: false),
          ],
        )
      ],
    );
  }

  Widget _buildDot({required bool isActive}) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: isActive ? AppTheme.primaryColor : const Color(0xFF326751),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
    );
  }

  Widget _buildReportTypeSelector() {
    return Column(
      children: [
        const SizedBox(height: 16),
        _ReportTypeCard(
          title: 'Básico',
          description: 'Análisis de rendimiento, fortalezas y debilidades.',
          isSelected: false,
        ),
        const SizedBox(height: 12),
        _ReportTypeCard(
          title: 'Con Vídeo',
          description: 'Incluye todo lo del Básico + clips de vídeo editados.',
          isSelected: false,
        ),
        const SizedBox(height: 12),
        _ReportTypeCard(
          title: 'Detallado',
          description: 'Incluye todo lo anterior + análisis táctico y métricas avanzadas.',
          isSelected: true,
        ),
      ],
    );
  }

  Widget _buildBudgetInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Presupuesto máximo para el ojeador',
            style: TextStyle(color: Colors.white.withOpacity(0.7)),
          ),
          const SizedBox(height: 8),
          const TextField(
            decoration: InputDecoration(
              hintText: '150',
              prefixText: '€ ',
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionsInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Ej: \'Enfócate en la capacidad defensiva del lateral izquierdo\' o \'Evalúa la actitud del jugador bajo presión\'.',
        ),
        maxLines: 4,
      ),
    );
  }
}

class _ReportTypeCard extends StatelessWidget {
  const _ReportTypeCard({
    required this.title,
    required this.description,
    this.isSelected = false,
  });

  final String title;
  final String description;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.primaryColor.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppTheme.primaryColor : const Color(0xFF326751),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(color: Colors.white.withOpacity(0.7)),
                ),
              ],
            ),
          ),
          Radio<bool>(
            value: true,
            groupValue: isSelected,
            onChanged: (value) {},
            activeColor: AppTheme.primaryColor,
          ),
        ],
      ),
    );
  }
}
