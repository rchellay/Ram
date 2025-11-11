import 'package:flutter/material.dart';
import 'package:spymatch/src/core/config/theme.dart';

class SubscriptionsScreen extends StatefulWidget {
  const SubscriptionsScreen({super.key});

  @override
  State<SubscriptionsScreen> createState() => _SubscriptionsScreenState();
}

class _SubscriptionsScreenState extends State<SubscriptionsScreen> {
  bool isAnnual = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Planes de Suscripción'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Elige el Plan Perfecto para tu Scouting',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          const Text(
            'Accede a informes ilimitados y herramientas exclusivas para encontrar al próximo talento.',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 24),
          _buildBillingCycleToggle(),
          const SizedBox(height: 24),
          _buildPricingCard(
            title: 'Básico',
            subtitle: 'Ideal para empezar.',
            price: '€9.99',
            features: [
              '2 informes/mes',
              'Búsqueda básica',
            ],
          ),
          const SizedBox(height: 16),
          _buildPricingCard(
            title: 'Scout Pro',
            subtitle: 'El plan más elegido.',
            price: '€29.99',
            features: [
              'Informes ilimitados',
              'Filtros avanzados',
              'Comparador de jugadores',
            ],
            isPopular: true,
          ),
          const SizedBox(height: 16),
          _buildPricingCard(
            title: 'Élite',
            subtitle: 'Para clubes y agencias.',
            price: '€79.99',
            features: [
              'Todo lo del plan Pro',
              'Acceso multi-usuario',
              'Soporte prioritario',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBillingCycleToggle() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF193328),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          _buildToggleItem('Mensual', false),
          _buildToggleItem('Anual (Ahorra 20%)', true),
        ],
      ),
    );
  }

  Widget _buildToggleItem(String title, bool value) {
    final bool isSelected = isAnnual == value;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isAnnual = value;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.backgroundDark : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF92c9b2),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPricingCard({
    required String title,
    required String subtitle,
    required String price,
    required List<String> features,
    bool isPopular = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF193328),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPopular ? AppTheme.primaryColor : const Color(0xFF326751),
          width: isPopular ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPopular)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text('MÁS POPULAR', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 10)),
            ),
          if (isPopular) const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(subtitle, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(price, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
              const Text('/mes', style: TextStyle(color: Colors.white70)),
            ],
          ),
          const SizedBox(height: 16),
          ...features.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: AppTheme.primaryColor, size: 20),
                    const SizedBox(width: 8),
                    Text(feature, style: const TextStyle(color: Colors.white)),
                  ],
                ),
              )),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: isPopular ? AppTheme.primaryColor : AppTheme.primaryColor.withOpacity(0.2),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: Text(
              'Seleccionar Plan',
              style: TextStyle(color: isPopular ? Colors.black : AppTheme.primaryColor, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
