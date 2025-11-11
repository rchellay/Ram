import 'package:flutter/material.dart';
import 'package:spymatch/src/core/config/theme.dart';

class CreateReportScreen extends StatelessWidget {
  const CreateReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Nuevo Informe'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Guardar', style: TextStyle(color: AppTheme.primaryColor)),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionCard(
            child: Column(
              children: [
                _buildDropdown('Plantilla de Informe', ['Informe de Jugador', 'Análisis de Equipo']),
                const SizedBox(height: 16),
                _buildTextField('Nombre del Jugador/Equipo', 'Ej: Lionel Messi / FC Barcelona'),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildTextField('Fecha del Partido', '', isDatePicker: true)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildTextField('Lugar', 'Estadio del Partido')),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionCard(
            title: 'Análisis Cualitativo',
            child: Column(
              children: [
                _buildTextArea('Puntos Fuertes', 'Describe las fortalezas clave observadas...'),
                const SizedBox(height: 16),
                _buildTextArea('Puntos Débiles', 'Describe las debilidades o áreas de mejora...'),
                 const SizedBox(height: 16),
                _buildTextArea('Notas Técnicas', 'Comentarios generales y observaciones técnicas...', maxLines: 3),
              ],
            ),
          ),
           const SizedBox(height: 24),
          _buildSectionCard(
            title: 'Análisis Táctico',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Sistema Táctico', style: TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: ['4-4-2', '4-3-3', '3-5-2', '4-2-3-1', '5-3-2', 'Otro']
                      .map((system) => Chip(
                            label: Text(system),
                            backgroundColor: system == '4-3-3' ? AppTheme.primaryColor.withOpacity(0.3) : AppTheme.cardDark,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: system == '4-3-3' ? AppTheme.primaryColor : Colors.white24),
                            ),
                          ))
                      .toList(),
                ),
                 const SizedBox(height: 16),
                 const Text('Jugadores Clave', style: TextStyle(color: Colors.white70)),
                 const SizedBox(height: 8),
                 Wrap(
                  spacing: 8.0,
                  children: [
                    Chip(
                      label: const Text('P. González (DEL)'),
                      onDeleted: (){},
                    ),
                     Chip(
                      label: const Text('A. Fernández (MC)'),
                      onDeleted: (){},
                    ),
                    ActionChip(
                      label: const Text('Añadir Jugador'),
                      avatar: const Icon(Icons.add),
                      onPressed: (){},
                    ),
                  ],
                 )
              ],
            ),
          ),
           const SizedBox(height: 24),
           _buildSectionCard(
            title: 'Multimedia',
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white24, style: BorderStyle.dashed, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  Icon(Icons.upload_file, size: 48, color: Colors.white54),
                  SizedBox(height: 8),
                  Text('Subir Vídeos', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
                   SizedBox(height: 4),
                  Text('Sube clips cortos de jugadas destacadas', style: TextStyle(color: Colors.white54, fontSize: 12)),
                ],
              ),
            ),
           )
        ],
      ),
       bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('Guardar Borrador'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Enviar Informe'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({String? title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppTheme.cardDark.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 16),
          ],
          child,
        ],
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: items.first,
          items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
          onChanged: (value) {},
          decoration: const InputDecoration(
            filled: true,
            fillColor: AppTheme.cardDark,
          ),
          dropdownColor: AppTheme.cardDark,
        ),
      ],
    );
  }

  Widget _buildTextField(String label, String hintText, {bool isDatePicker = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: isDatePicker ? const Icon(Icons.calendar_today) : null,
          ),
        ),
      ],
    );
  }

  Widget _buildTextArea(String label, String hintText, {int maxLines = 4}) {
     return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hintText,
          ),
          maxLines: maxLines,
        ),
      ],
    );
  }
}
