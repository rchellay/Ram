import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spymatch/src/core/config/theme.dart';

class CreateMissionSelectMatchScreen extends StatelessWidget {
  const CreateMissionSelectMatchScreen({super.key});

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
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selecciona el partido',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Busca el encuentro en nuestra base de datos para asegurar la precisión de la información.',
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
            ),
            const SizedBox(height: 24),
            const Text(
              'Competición / Liga',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                hintText: 'Ej: Liga Profesional Argentina',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 24),
            _buildSelectedMatchCard(),
            const SizedBox(height: 24),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  '¿No encuentras el partido? Créalo manualmente',
                  style: TextStyle(color: AppTheme.primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () => context.go('/create-mission/define-match'),
          child: const Text('Siguiente'),
        ),
      ),
    );
  }

  Widget _buildSelectedMatchCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppTheme.primaryColor.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Liga Profesional', style: TextStyle(color: Colors.white.withOpacity(0.7))),
              Text('Hoy, 20:00', style: TextStyle(color: Colors.white.withOpacity(0.7))),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTeam('River Plate', 'https://lh3.googleusercontent.com/aida-public/AB6AXuC_6dZ9bcqrZkeeB7BugOG0locIdT0BxW5wsXnyc9sJ9xm9tDdiha3FgagIzLX6H6ykqdbV6y50j4tNCyXKEL30a1ulH0x82BCGuQDPR8nsTKFrBmXcwP3SPCaHMcT0c1uoeRtTFvnSM_A70Ge7nQZ5IIaht4Nwum-omvf1RebIBxHzG2-nzg9RSsv90tPW2ZrvMHoS85e-lqpSaAzGd5uA3tnGzaOITCYdvs5xUnOLtmDpGQMg955sfzMWEkCj2cu0tQZoyfVhSw'),
              const Text('VS', style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold)),
              _buildTeam('Boca Juniors', 'https://lh3.googleusercontent.com/aida-public/AB6AXuC_6dZ9bcqrZkeeB7BugOG0locIdT0BxW5wsXnyc9sJ9xm9tDdiha3FgagIzLX6H6ykqdbV6y50j4tNCyXKEL30a1ulH0x82BCGuQDPR8nsTKFrBmXcwP3SPCaHMcT0c1uoeRtTFvnSM_A70Ge7nQZ5IIaht4Nwum-omvf1RebIBxHzG2-nzg9RSsv90tPW2ZrvMHoS85e-lqpSaAzGd5uA3tnGzaOITCYdvs5xUnOLtmDpGQMg955sfzMWEkCj2cu0tQZoyfVhSw', isRightAligned: true),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white.withOpacity(0.7), size: 16),
                  const SizedBox(width: 4),
                  Text('Estadio Monumental', style: TextStyle(color: Colors.white.withOpacity(0.7))),
                ],
              ),
              const Icon(Icons.check_circle, color: AppTheme.primaryColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeam(String name, String imageUrl, {bool isRightAligned = false}) {
    final children = [
      Image.network(imageUrl, height: 32, width: 32),
      const SizedBox(width: 8),
      Expanded(child: Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: isRightAligned ? TextAlign.right : TextAlign.left)),
    ];
    return Expanded(
      child: Row(
        mainAxisAlignment: isRightAligned ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: isRightAligned ? children.reversed.toList() : children,
      ),
    );
  }
}
