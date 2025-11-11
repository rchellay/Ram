import 'package:flutter/material.dart';
import 'package:spymatch/src/core/config/theme.dart';

class PaymentSettingsScreen extends StatelessWidget {
  const PaymentSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Configuración de Pagos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Métodos Vinculados', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 16),
            _buildPaymentMethod(
              icon: Icons.account_balance,
              title: 'Cuenta Bancaria •••• 1234',
              subtitle: 'Principal',
              iconBackgroundColor: AppTheme.primaryColor.withOpacity(0.2),
              iconColor: AppTheme.primaryColor,
            ),
            const SizedBox(height: 12),
            _buildPaymentMethod(
              imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBYXdu_U_8hTXXs5K-s8xk37FSyvXVG0aylnJhlsJU2lts3P5ejeeo6KDBavtZzNQnb20Ys5DlxOcG6J5aPTYRH95rm8uU09O1IQCrtVPLndFGbgAdJkiZHkUNHey8L4FWkb7hTXnE4cOU7nsKK8LJGjMwEwfh3S8jG1KcMP_WOuZxmnpTMd9IrZb2Khio4EUSamjEZTYaD4KPkc9Bl30JI03d1gFFnetZjBvVNv7b-8Nnw01RFzrKvKd16R6uZEawe7Z9j9wu6yg',
              title: 'Cuenta de Stripe',
              iconBackgroundColor: const Color(0xFF635BFF),
            ),
             const SizedBox(height: 12),
            _buildPaymentMethod(
              imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAnxmo2cJuLApyxPQ1aVbluGPryPjIr1IBkRBTLKY5nUmHxxcR4KTmWS5qZfI-yTXFnlDrGRx_wJ9DC04bpb2XIMMOOVqYD_Vv2cjXUesW8hfGR3C5STBkJHlLy0YLtqdoKh3dljCnhhWI3KwvKEp4DmTmU7lhFSkU_0P4ks-p5VuyZdICZd8nC7x0TycxHs21eT3Nrejpk3p1TQtWUxHWEinqmNS5fprmg9-2PJiku5l26pW6-Rr19PQMTsE3mvxrft2lv-L_dFQ',
              title: 'Cuenta de Mercado Pago',
              iconBackgroundColor: const Color(0xFF009EE3),
            ),
            const SizedBox(height: 32),
            const Text('Preferencias de Cobro', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 16),
            _buildPayoutPreferences(),
             const Spacer(),
            _buildSecurityInfo(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add_circle),
          label: const Text('Añadir Método de Pago'),
        ),
      ),
    );
  }

  Widget _buildPaymentMethod({
    IconData? icon,
    String? imageUrl,
    required String title,
    String? subtitle,
    required Color iconBackgroundColor,
    Color? iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.cardDark.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: icon != null
                ? Icon(icon, color: iconColor)
                : imageUrl != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(imageUrl),
                      )
                    : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(color: AppTheme.primaryColor, fontSize: 12)),
                ]
              ],
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, color: Colors.white54)),
        ],
      ),
    );
  }

  Widget _buildPayoutPreferences() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardDark.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Recibir pagos automáticamente', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                SizedBox(height: 4),
                Text('Los pagos se enviarán a tu cuenta principal.', style: TextStyle(color: Colors.white60, fontSize: 12)),
              ],
            ),
          ),
          Switch(
            value: true,
            onChanged: (value) {},
            activeColor: AppTheme.primaryColor,
          ),
        ],
      ),
    );
  }

   Widget _buildSecurityInfo() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.lock, color: Colors.white60, size: 16),
        SizedBox(width: 8),
        Text('Tus datos están protegidos y encriptados.', style: TextStyle(color: Colors.white60, fontSize: 12)),
      ],
    );
  }
}
