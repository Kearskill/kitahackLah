import 'package:flutter/material.dart';

class LaporanView extends StatelessWidget {
  const LaporanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ringkasan Laporan")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildReportSection("Hasil Imbasan / Vision Results", [
            _reportTile("Wound Assessment", "Luka Teruk (Stage 2)", Icons.remove_red_eye),
            _reportTile("Diabetic Retinopathy", "Normal (Screening Complete)", Icons.health_and_safety),
          ]),
          const SizedBox(height: 20),
          _buildReportSection("Cadangan AI (Gemini)", [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Sila rujuk pakar dalam tempoh 24 jam. Cuci luka menggunakan saline solution.",
                style: TextStyle(fontStyle: FontStyle.italic, color: Colors.blueGrey),
              ),
            ),
          ]),
          const SizedBox(height: 20),
          _buildReportSection("Koordinasi Rujukan", [
            _reportTile("District Hospital", "Pending Sync", Icons.sync_problem),
            _reportTile("Specialist Meet", "Scheduled: 2 PM", Icons.video_call),
          ]),
        ],
      ),
    );
  }

  Widget _buildReportSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        Card(
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _reportTile(String title, String status, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      trailing: Text(status, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }
}