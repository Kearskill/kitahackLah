// Step 1: Maklumakt Pesakit
import 'package:flutter/material.dart';

class PatientInfoStep extends StatefulWidget {
  const PatientInfoStep({super.key});

  @override
  State<PatientInfoStep> createState() => _PatientInfoStepState();
}

class _PatientInfoStepState extends State<PatientInfoStep> {
  String gender = 'Lelaki';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Nama Pesakit",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const TextField(
            decoration: InputDecoration(
              hintText: "Masukkan nama penuh",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          const Text("Umur", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const TextField(
            decoration: InputDecoration(
              hintText: "0",
              suffixText: "tahun",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          const Text("Jantina", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            children: [
              _genderButton("Lelaki", Icons.male),
              const SizedBox(width: 16),
              _genderButton("Perempuan", Icons.female),
            ],
          ),
        ],
      ),
    );
  }

  Widget _genderButton(String val, IconData icon) {
    bool isSelected = gender == val;
    return Expanded(
      child: OutlinedButton.icon(
        onPressed: () => setState(() => gender = val),
        icon: Icon(icon),
        label: Text(val),
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected ? Colors.blue.shade50 : Colors.white,
          side: BorderSide(
            color: isSelected ? Colors.blue : Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}
