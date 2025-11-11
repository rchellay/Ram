import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spymatch/src/core/config/theme.dart';
import 'package:spymatch/src/features/reports/presentation/providers/report_provider.dart';

class CreateReportScreen extends StatefulWidget {
  const CreateReportScreen({super.key});

  @override
  State<CreateReportScreen> createState() => _CreateReportScreenState();
}

class _CreateReportScreenState extends State<CreateReportScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _mediaFile;
  final _nameController = TextEditingController();
  final _strengthsController = TextEditingController();
  final _weaknessesController = TextEditingController();
  final _notesController = TextEditingController();

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
            onPressed: _submitReport,
            child: const Text('Guardar', style: TextStyle(color: AppTheme.primaryColor)),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildSectionCard(
              child: Column(
                children: [
                  _buildDropdown('Plantilla de Informe', ['Informe de Jugador', 'Análisis de Equipo']),
                  const SizedBox(height: 16),
                  _buildTextField('Nombre del Jugador/Equipo', 'Ej: Lionel Messi / FC Barcelona', _nameController),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildTextField('Fecha del Partido', '', null, isDatePicker: true)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildTextField('Lugar', 'Estadio del Partido', null)),
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
                  _buildTextArea('Puntos Fuertes', 'Describe las fortalezas clave observadas...', _strengthsController),
                  const SizedBox(height: 16),
                  _buildTextArea('Puntos Débiles', 'Describe las debilidades o áreas de mejora...', _weaknessesController),
                   const SizedBox(height: 16),
                  _buildTextArea('Notas Técnicas', 'Comentarios generales y observaciones técnicas...', _notesController, maxLines: 3),
                ],
              ),
            ),
             const SizedBox(height: 24),
            _buildSectionCard(
              title: 'Multimedia',
              child: GestureDetector(
                onTap: _pickMedia,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white24, style: BorderStyle.dashed, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _mediaFile == null
                      ? const Column(
                          children: [
                            Icon(Icons.upload_file, size: 48, color: Colors.white54),
                            SizedBox(height: 8),
                            Text('Subir Vídeos', style: TextStyle(color: AppTheme.primaryColor, fontWeight: FontWeight.bold)),
                             SizedBox(height: 4),
                            Text('Sube clips cortos de jugadas destacadas', style: TextStyle(color: Colors.white54, fontSize: 12)),
                          ],
                        )
                      : Image.file(_mediaFile!, height: 150, width: double.infinity, fit: BoxFit.cover),
                ),
              ),
             )
          ],
        ),
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
                onPressed: _submitReport,
                child: const Text('Enviar Informe'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickMedia() async {
    final reportProvider = Provider.of<ReportProvider>(context, listen: false);
    final file = await reportProvider.pickImage();
    if (file != null) {
      setState(() {
        _mediaFile = file;
      });
    }
  }

  Future<void> _submitReport() async {
    if (_formKey.currentState!.validate()) {
      final reportProvider = Provider.of<ReportProvider>(context, listen: false);
      try {
        await reportProvider.createReport(
          {
            'name': _nameController.text,
            'strengths': _strengthsController.text,
            'weaknesses': _weaknessesController.text,
            'notes': _notesController.text,
          },
          _mediaFile,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Informe enviado con éxito')),
        );
        Navigator.of(context).pop();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
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

  Widget _buildTextField(String label, String hintText, TextEditingController? controller, {bool isDatePicker = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: isDatePicker ? const Icon(Icons.calendar_today) : null,
          ),
           validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildTextArea(String label, String hintText, TextEditingController controller, {int maxLines = 4}) {
     return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
          ),
          maxLines: maxLines,
           validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
        ),
      ],
    );
  }
}
