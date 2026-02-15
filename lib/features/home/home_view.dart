import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildMainActionCard(),
              const SizedBox(height: 16),
              _buildSecondaryActions(),
              const SizedBox(height: 24),
              const Text(
                "Statistik Hari Ini",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1E293B)),
              ),
              const SizedBox(height: 16),
              _buildStatisticsGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Isnin, 16 Februari 2026", style: TextStyle(color: Colors.grey, fontSize: 12)),
            const Text("Selamat datang, Siti!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("Klinik Kesihatan Bario", style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.w500)),
          ],
        ),
        Container(
          width: 48, // This is radius * 2
          height: 48,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFF2196F3), Color(0xFF00BCD4)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Icon(Icons.person, color: Colors.white), // Optional: Add an icon inside
        ),
      ],
    );
  }

  Widget _buildMainActionCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF2962FF), Color(0xFF00BFA5)]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.blue.withValues(alpha: 0.3), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: const Row(
        children: [
          CircleAvatar(backgroundColor: Colors.white24, child: Icon(Icons.add, color: Colors.white)),
          SizedBox(width: 16),
          Text("Kes Baru", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          Spacer(),
          Icon(Icons.arrow_forward, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildSecondaryActions() {
    return Row(
      children: [
        _buildSmallAction("Sejarah Kes", Icons.history, Colors.blue.shade50, Colors.blue),
        const SizedBox(width: 16),
        _buildSmallAction("Panduan Rawatan", Icons.menu_book, Colors.teal.shade50, Colors.teal),
      ],
    );
  }

  Widget _buildSmallAction(String title, IconData icon, Color bg, Color iconCol) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Icon(icon, color: iconCol, size: 30),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsGrid() {
    return Row(
      children: [
        _buildStatCard("3", "kes hari ini", Icons.description_outlined, Colors.black),
        const SizedBox(width: 12),
        _buildStatCard("2", "perlu susulan", Icons.access_time, Colors.orange),
        const SizedBox(width: 12),
        _buildStatCard("12", "rujukan bulan ini", Icons.trending_up, Colors.green),
      ],
    );
  }

  Widget _buildStatCard(String val, String label, IconData icon, Color iconCol) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Icon(icon, color: iconCol),
            const SizedBox(height: 8),
            Text(val, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class HomeView extends StatelessWidget {
//   const HomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Pembantu Klinikal", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D47A1))),
//             Text("Clinical Assistant", style: TextStyle(fontSize: 12, color: Colors.grey)),
//           ],
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Status Card
//             _buildStatusCard(),
//             const SizedBox(height: 24),
            
//             Text("Tindakan Pantas / Quick Actions", style: Theme.of(context).textTheme.titleMedium),
//             const SizedBox(height: 12),
            
//             // Quick Action Buttons
//             _buildActionCard(Icons.add_circle_outline, "Triage Baru", "New Triage", Colors.blue.shade50, Colors.blue),
//             _buildActionCard(Icons.camera_alt_outlined, "Imbasan Penglihatan", "Vision Scan", Colors.green.shade50, Colors.green),
//             _buildActionCard(Icons.mic_none, "Nota Suara", "Voice Notes", Colors.orange.shade50, Colors.orange),
            
//             const SizedBox(height: 24),
//             Text("Pesakit Keutamaan", style: Theme.of(context).textTheme.titleMedium),
//             const SizedBox(height: 12),
            
//             // Patient List Item
//             _buildPatientCard("Ahmad bin Abdullah", "Red", "45 tahun • Luka teruk pada kaki"),
//           ],
//         ),
//       ),
//     //   bottomNavigationBar: NavigationBar(
//     //     destinations: const [
//     //       NavigationDestination(icon: Icon(Icons.home), label: 'Utama'),
//     //       NavigationDestination(icon: Icon(Icons.camera_alt), label: 'Imbasan'),
//     //       NavigationDestination(icon: Icon(Icons.description), label: 'Laporan'),
//     //     ],
//     //   ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {}, // This would trigger your AI/Gemini assistant
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   Widget _buildStatusCard() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: const Color(0xFFE3F2FD),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: [
//           const Icon(Icons.cloud_done, color: Colors.green),
//           const SizedBox(width: 12),
//           const Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("Dalam Talian", style: TextStyle(fontWeight: FontWeight.bold)),
//                 Text("Online", style: TextStyle(fontSize: 12)),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//             decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(20)),
//             child: const Text("Connected", style: TextStyle(color: Colors.white, fontSize: 12)),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildActionCard(IconData icon, String title, String subtitle, Color bgColor, Color iconColor) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 12),
//       child: ListTile(
//         leading: Container(
//           padding: const EdgeInsets.all(8),
//           decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(8)),
//           child: Icon(icon, color: iconColor),
//         ),
//         title: Text(title),
//         subtitle: Text(subtitle),
//         trailing: const Icon(Icons.chevron_right),
//         onTap: () {}, // Navigate to feature here
//       ),
//     );
//   }

//   Widget _buildPatientCard(String name, String priority, String desc) {
//     return Card(
//       child: ListTile(
//         leading: Container(width: 4, color: Colors.red, height: 40),
//         title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text(desc),
//         trailing: const Icon(Icons.chevron_right),
//       ),
//     );
//   }
// }