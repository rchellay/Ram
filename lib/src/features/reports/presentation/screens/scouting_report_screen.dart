import 'package:flutter/material.dart';
import 'package:spymatch/src/core/config/theme.dart';

class ScoutingReportScreen extends StatelessWidget {
  const ScoutingReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Informe de Scouting'),
        actions: [
          IconButton(
            icon: const Icon(Icons.ios_share),
            onPressed: () {},
          ),
        ],
      ),
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: _buildHeader(),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  const TabBar(
                    tabs: [
                      Tab(text: 'Resumen'),
                      Tab(text: 'Táctica'),
                      Tab(text: 'Jugadores'),
                      Tab(text: 'Media'),
                    ],
                    indicatorColor: AppTheme.primaryColor,
                    labelColor: AppTheme.primaryColor,
                    unselectedLabelColor: Colors.grey,
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              _buildSummaryTab(),
              const Center(child: Text("Táctica Tab")),
              const Center(child: Text("Jugadores Tab")),
              const Center(child: Text("Media Tab")),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuBgLSVoPk0TZGsEo2oSSxM3cTzpoh1t1QQBJJrDLzk6e8YQuCGADa89_bZjQ_HNQUGX5zgW3PGvyicbChwmVGTrmNht6SixS4JxjfCMVU1YjvdcW9v5FI6zg-4eq1ZJZjYRmLYTpx-IK7FQXcMhva0HRfwOeF-sgDTkufQpB_nPLVmZ2LDJN3RcXQ4B6A5Do2hIm2sbreHj-5zMytCQ-zZ_txanXIrCCgvV-b4Yufag8lICOnUOcz4JGgroM2Oo5ccK4o9vpMI41Q'),
            radius: 40,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Real Madrid C.F.', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 4),
              Text('Fecha: 15/08/2024', style: TextStyle(color: Colors.white.withOpacity(0.7))),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSummaryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Resumen Clave', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 16),
          _buildStrengthsCard(),
          const SizedBox(height: 16),
          _buildWeaknessesCard(),
          const SizedBox(height: 24),
           const Text('Sistema Táctico', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 16),
          _buildTacticsCard(),
           const SizedBox(height: 24),
           const Text('Jugadores a Vigilar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 16),
          _buildKeyPlayers(),
        ],
      ),
    );
  }

  Widget _buildStrengthsCard() {
    return _buildAnalysisCard(
      title: 'Puntos Fuertes Clave',
      icon: Icons.arrow_upward,
      iconColor: Colors.green,
      items: [
        'Transición defensa-ataque rápida',
        'Dominio en juego aéreo ofensivo',
        'Peligro a balón parado',
      ],
    );
  }

  Widget _buildWeaknessesCard() {
    return _buildAnalysisCard(
      title: 'Debilidades Explotables',
      icon: Icons.arrow_downward,
      iconColor: Colors.red,
      items: [
        'Vulnerables al contraataque',
        'Poca profundidad en el banquillo',
        'Errores no forzados en salida de balón',
      ],
    );
  }

  Widget _buildAnalysisCard({required String title, required IconData icon, required Color iconColor, required List<String> items}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
          const SizedBox(height: 8),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• ', style: TextStyle(color: iconColor, fontWeight: FontWeight.bold)),
                Expanded(child: Text(item, style: TextStyle(color: Colors.white.withOpacity(0.7)))),
              ],
            ),
          )),
        ],
      ),
    );
  }
   Widget _buildTacticsCard() {
    return Container(
       padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuBbyiXlbGe7CxuvKg-YBlAYh9OizzLXse0TFGpzUyLSbEykvc1UusFwqSBWUo8qy9YUgnWUjtKz1IdJkIgcPxyKgIs7JxD7uoUdFcdPXayGt9dWHMAeoOWS6CjjkQuJUCmAn3FUqyLQTRnRVRl-1ugtz6axHTkNNeN6XDZm8TvLkA2VVmJ5zEihQaJBncLcsk9KjGHd1QOajFLxjUqn6ZaButqzQE7qmnf4tRu3jMjwKboZkgHRO_-mMPNggBk_IisT900WlhIKGg"),
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Formación Principal: 4-3-3', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 8),
          Text(
            'Estilo de juego basado en presión alta tras pérdida y ataques rápidos por las bandas. Buscan la superioridad en el centro del campo para controlar el ritmo del partido.',
            style: TextStyle(color: Colors.white.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyPlayers() {
    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _PlayerCard(
            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAN1NFxkdYy4MiJ-xUxJB6sBdAJc3FX478Hqm37isbHXk9uimSOXyaWtytBPLjj_0N4DrwkxnyOHYm_0LKhwKtpVXLhFJ3zdm7wswoa2wc8lpiqhfDR3wbVqqTbUf67sQvwNxBejKWZcH3YmDH1wc2dAHUecJOBp-_DN9bXXj3VivoQU9OVC0-pWG7u1wN3DfK3JE5hyuoj6VSd8Eo_L7fJjWx5v1KFhs3AnYJnYCaZYcAHNJdlElI_Hmfjh2HtO46TzS8KnGycPw',
            name: 'Jude Bellingham',
            position: '#5 - Centrocampista',
            tag: 'Goleador',
          ),
          _PlayerCard(
            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCnv6Yz9qilk1IAsUVPuoIQ_0_U2JNPaHxZafQg3cF3XTbFDPcd7jWBiOMbqX3U605vNNGlxoFnsWE9sPjDCugUFIQSuahNPnfuUzF2f4ZTQoNkFKlVFiltefLOsD9YZ-ANmTWlR0wEMRzJ9WfcpMqUfuqZwfIE6wrYAJi9ACfHvt8aHsOIjVDRhZXWC7vJfznH6GlSjeHIKc7calhjmKrM9_op01PC1WuO30Obpi4yRzBrQQiyQ_vSojQmzRpE2CpAtdvEU0RGmA',
            name: 'Vinicius Jr.',
            position: '#7 - Delantero',
            tag: 'Desequilibrante',
          ),
           _PlayerCard(
            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCBaODip7kHaRCys6Ygvt4qRZR-_8WBMPuHMSJUGBz_D6WqTQxBgB6TahT4HPzHVQHoLqx0lwFNHqA948yGNVEMDKvsPccvatVDYextIafV4XuWxOS5detIBsxPMH9Eq4wWsSj6wCcB9NMP4JaM6wU1znb9pfsS--uMX0ufMg5scp8wzAKrSH3rdaxsyeqejAU7jGjTzx7_KUm_BYVMJrc9VYy7AHB-Hz1P4jJ4qG5iqEai2mI8AIA2IsUhBre3MnJk_9H4Qgrdmw',
            name: 'Toni Kroos',
            position: '#8 - Centrocampista',
            tag: 'Visión de Juego',
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppTheme.backgroundDark,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class _PlayerCard extends StatelessWidget {
  const _PlayerCard({
    required this.imageUrl,
    required this.name,
    required this.position,
    required this.tag,
  });

  final String imageUrl;
  final String name;
  final String position;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            radius: 30,
          ),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          Text(position, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12), textAlign: TextAlign.center),
          const SizedBox(height: 8),
           Container(
             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
             child: Text(tag, style: const TextStyle(color: AppTheme.primaryColor, fontSize: 10, fontWeight: FontWeight.bold)),
           ),
        ],
      ),
    );
  }
}
