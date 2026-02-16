// Step 3 : Tanda Vital
// lib/features/triage/widgets/vitals_step.dart
import 'package:flutter/material.dart';

class VitalsStep extends StatelessWidget {
  const VitalsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Suhu Badan",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          _buildVitalField("36.5", "°C", "Normal: 36.5-37.5"),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildVitalItem(
                  "Kadar Nadi",
                  "80",
                  "/min",
                  "Normal: 60-100",
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildVitalItem(
                  "Kadar Pernafasan",
                  "16",
                  "/min",
                  "Normal: 12-20",
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            "Tekanan Darah",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Expanded(child: _buildVitalField("120", "", "")),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text("/"),
              ),
              Expanded(child: _buildVitalField("80", "mmHg", "Normal: 120/80")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVitalField(String value, String unit, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
            suffixText: unit,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        if (hint.isNotEmpty)
          Text(hint, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildVitalItem(String label, String value, String unit, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        _buildVitalField(value, unit, hint),
      ],
    );
  }
}
