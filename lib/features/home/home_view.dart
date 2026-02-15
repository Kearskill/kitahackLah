import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pembantu Klinikal", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D47A1))),
            Text("Clinical Assistant", style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            _buildStatusCard(),
            const SizedBox(height: 24),
            
            Text("Tindakan Pantas / Quick Actions", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            
            // Quick Action Buttons
            _buildActionCard(Icons.add_circle_outline, "Triage Baru", "New Triage", Colors.blue.shade50, Colors.blue),
            _buildActionCard(Icons.camera_alt_outlined, "Imbasan Penglihatan", "Vision Scan", Colors.green.shade50, Colors.green),
            _buildActionCard(Icons.mic_none, "Nota Suara", "Voice Notes", Colors.orange.shade50, Colors.orange),
            
            const SizedBox(height: 24),
            Text("Pesakit Keutamaan", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            
            // Patient List Item
            _buildPatientCard("Ahmad bin Abdullah", "Red", "45 tahun • Luka teruk pada kaki"),
          ],
        ),
      ),
    //   bottomNavigationBar: NavigationBar(
    //     destinations: const [
    //       NavigationDestination(icon: Icon(Icons.home), label: 'Utama'),
    //       NavigationDestination(icon: Icon(Icons.camera_alt), label: 'Imbasan'),
    //       NavigationDestination(icon: Icon(Icons.description), label: 'Laporan'),
    //     ],
    //   ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // This would trigger your AI/Gemini assistant
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.cloud_done, color: Colors.green),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Dalam Talian", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Online", style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
            child: const Text("Connected", style: TextStyle(color: Colors.white, fontSize: 12)),
          )
        ],
      ),
    );
  }

  Widget _buildActionCard(IconData icon, String title, String subtitle, Color bgColor, Color iconColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {}, // Navigate to feature here
      ),
    );
  }

  Widget _buildPatientCard(String name, String priority, String desc) {
    return Card(
      child: ListTile(
        leading: Container(width: 4, color: Colors.red, height: 40),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(desc),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}