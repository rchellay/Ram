import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:spymatch/src/core/config/theme.dart';

class ScoutDashboardScreen extends StatelessWidget {
  const ScoutDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SPYMATCH', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuCOHzdA-XSAm2vS0ZLAYK5rzEFXt-0jVVMAe4y_eLa4lqtaSmOHrCVnljeYNZTQsrfSioQd5V75ZRunZmjqJygm6YgWFgsE5gFy6Cq1Ls6JX6hRpOSo4YQdxPjx7taPPMtdbYd0NLGVPkJvKSxlSg4_VA8PllHfExlb89piRuClz6orCQhYguDsQuK6Xn_qXewR-yLIO2r0XjOUoHBb3jFAaWd6xXOMxGR51fRpiF7BO_zY1s1Kv6UULuxGSZiNJcva1OrOVPzeiw'),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          _buildHeader(context),
          _buildTabs(),
          _buildMap(),
          _buildMissionCards(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Hola, Ojeador',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.sync_alt, color: Colors.white70),
            label: const Text('Entrenador', style: TextStyle(color: Colors.white70)),
            style: TextButton.styleFrom(
              backgroundColor: AppTheme.cardDark,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return const DefaultTabController(
      length: 2,
      child: TabBar(
        tabs: [
          Tab(text: 'Mapa'),
          Tab(text: 'Lista'),
        ],
        indicatorColor: AppTheme.primaryColor,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
      ),
    );
  }

  Widget _buildMap() {
    return Container(
      height: 300,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: NetworkImage('https://lh3.googleusercontent.com/aida-public/AB6AXuAS0siWAnrdZPQ7So5hmLYiggIErVyQ9LEBNRfSLb1NZrErkcBpeNcTVIw3jJG5LqrTna2Efxnu9UMrOvBLHlyhTf4M94yxw9hEbdbtkGGz4byV44dgqXOjDkuotgnPIfVcSMGAfoxdkQFcF3Ruv7EJv-5FvtKxb7jW-FhTlI_fm7YtzvV-GkOHx3o2PLEelPf8icvmcdSrcyeNonyGQfNG7jcyIcdR6Yik9AoE5gD1-Bn6etppcpbIyoFhOBvzXrl1AR-42xpMMA'),
          fit: BoxFit.cover,
        ),
      ),
      child: const Center(child: Text('Map Placeholder', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildMissionCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _MissionCard(
            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBi2QQAqiyCdNKtqHhh7zZYl5VcY_4LHZco3u6EkFkj8Vgtdfjy7kbWfSZV4p8hKcJg9gCSdt6S7SEf4CpHby6f9cNpuPGmFpyqRCZIAgL-h2iov0NOz8Smpkj8SQVz32A3eWf6BOLlEQ_pGy94GrBOzrCpp_w1XU2IOinIZ902s0bLLKKd2sAx24BB3zIdEMcruLRY-5y-Cfu_Wu3HYcKEUun6JsHgacAcpZgkt9v5UqmrRr9ibFDF2WHQlB46vnWOmXpDhf1FMA',
            category: 'Goalkeeper Evaluation',
            title: 'Scout U19 Striker',
            details: 'Amateur FC vs. Local United',
            distanceAndReward: '2.5 km away - €50 Reward',
          ),
          const SizedBox(height: 16),
          _MissionCard(
            imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDZnS-KHH5N-V-jss3wtQynIMAM-cngcx4D-ntTH-ASPhLfzJqdYZxnk3VX6GSwTU-alrBuHHqvyvSQ6IHQVTTxok4IMkJTUoKRznt8rfHZsZdej2ZSKEcJD6NDVvHNpJ0MWmQTFg4qWPMPXHQugpLS5WnWoYC-vhDOiEavg1txY1OpKV_TGbInLRU98StI2B6rzrZdxti59GyMIfYLDcN3us70mNf8dEJN2NsZ3n1xmPv22VtXdBj2ifTNHzaDX_spGNZ9sMeEgg',
            category: 'Midfielder Analysis',
            title: 'Assess U17 Playmaker',
            details: 'City Rovers vs. Regional Talent',
            distanceAndReward: '5.1 km away - €75 Reward',
          ),
        ],
      ),
    );
  }
}

class _MissionCard extends StatelessWidget {
  const _MissionCard({
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.details,
    required this.distanceAndReward,
  });

  final String imageUrl;
  final String category;
  final String title;
  final String details;
  final String distanceAndReward;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.cardDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(imageUrl, height: 150, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(height: 4),
                Text(title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(details, style: const TextStyle(color: Colors.white70)),
                const SizedBox(height: 4),
                Text(distanceAndReward, style: const TextStyle(color: Colors.white70)),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () => context.go('/mission-details'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('View Details', style: TextStyle(color: Colors.black)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
