// Step 2: Simptom Pesakit
import 'package:flutter/material.dart';

class SymptomsStep extends StatelessWidget {
  const SymptomsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Terangkan simptom pesakit",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const TextField(
            maxLines: 5,
            decoration: InputDecoration(
              hintText: "Terangkan simptom pesakit...",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          const Text("Atau gunakan:"),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildActionBox(
                "Cakap Sekarang",
                Icons.mic,
                Colors.blue.shade50,
                Colors.blue,
              ),
              const SizedBox(width: 16),
              _buildActionBox(
                "Pilih Simptom",
                Icons.list_alt,
                Colors.teal.shade50,
                Colors.teal,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text("Gambar (Pilihan)"),
          const SizedBox(height: 12),
          Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.camera_alt_outlined, color: Colors.grey),
                Text(
                  "Ambil atau muat naik gambar",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBox(String label, IconData icon, Color bg, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
