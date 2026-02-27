import 'package:flutter/material.dart';
import 'package:kitahack_app/core/services/ai_diagnosis_service.dart';
import 'package:kitahack_app/features/triage/triage_page.dart';

class AIResultPage extends StatelessWidget {
  final CaseDraft draft;
  final DiagnosisResult result;

  const AIResultPage({
    super.key,
    required this.draft,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: _getHeaderColor(),
        toolbarHeight: 120,
        automaticallyImplyLeading: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _getAccentColor().withOpacity(0.4),
                width: 5,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 72, bottom: 20),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (result.isEmergency)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "⚠️ KECEMASAN",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  Text(
                    "Penilaian: ${result.severity}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: _getAccentColor(),
                    ),
                  ),
                  const Text(
                    "Keputusan AI Gemini",
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Emergency message
            if (result.isEmergency && result.emergencyMessage != null)
              _buildEmergencyCard(),
            
            // Patient info summary
            _buildPatientSummary(),
            
            // Possible conditions
            if (result.possibleConditions.isNotEmpty)
              _buildConditionsCard(),
            
            // Recommended action
            _buildActionCard(),
            
            // Red flags to watch
            if (result.redFlags.isNotEmpty)
              _buildRedFlagsCard(),
            
            // Referral info
            if (result.referralNeeded)
              _buildReferralCard(),
            
            // Disclaimer
            _buildDisclaimerCard(),
          ],
        ),
      ),
    );
  }

  Color _getHeaderColor() {
    if (result.isEmergency || result.severity == "Teruk") {
      return Colors.red.shade100;
    } else if (result.severity == "Sederhana") {
      return Colors.orange.shade100;
    }
    return Colors.green.shade100;
  }

  Color _getAccentColor() {
    if (result.isEmergency || result.severity == "Teruk") {
      return Colors.red.shade900;
    } else if (result.severity == "Sederhana") {
      return Colors.orange.shade900;
    }
    return Colors.green.shade900;
  }

  Widget _buildEmergencyCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.shade300, width: 2),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.red.shade700, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              result.emergencyMessage!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientSummary() {
    return _buildCard(
      title: "Maklumat Pesakit",
      icon: Icons.person_outline,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nama: ${draft.name.isNotEmpty ? draft.name : 'Tidak dinyatakan'}"),
          Text("Umur: ${draft.age > 0 ? '${draft.age} tahun' : 'Tidak dinyatakan'}"),
          Text("Jantina: ${draft.gender.isNotEmpty ? draft.gender : 'Tidak dinyatakan'}"),
        ],
      ),
    );
  }

  Widget _buildConditionsCard() {
    return _buildCard(
      title: "Kemungkinan Keadaan",
      icon: Icons.medical_information_outlined,
      child: Column(
        children: result.possibleConditions.map((condition) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        condition.condition,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getConfidenceColor(condition.confidence),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        condition.confidence,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  condition.explanation,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Color _getConfidenceColor(String confidence) {
    switch (confidence) {
      case "Tinggi":
        return Colors.green;
      case "Sederhana":
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Widget _buildActionCard() {
    return _buildCard(
      title: "Cadangan Tindakan",
      icon: Icons.medical_services_outlined,
      accentColor: _getAccentColor(),
      child: Text(
        result.recommendedAction,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildRedFlagsCard() {
    return _buildCard(
      title: "Tanda Bahaya untuk Dipantau",
      icon: Icons.warning_amber_rounded,
      accentColor: Colors.orange,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: result.redFlags.map((flag) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.circle, size: 8, color: Colors.orange.shade700),
                const SizedBox(width: 8),
                Expanded(child: Text(flag)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildReferralCard() {
    Color urgencyColor = result.referralUrgency == "Segera" 
        ? Colors.red 
        : (result.referralUrgency == "Dalam 24 jam" ? Colors.orange : Colors.blue);
    
    return _buildCard(
      title: "Rujukan Diperlukan",
      icon: Icons.local_hospital,
      accentColor: urgencyColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text("Urgency: ", style: TextStyle(fontWeight: FontWeight.w500)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: urgencyColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  result.referralUrgency,
                  style: TextStyle(
                    color: urgencyColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDisclaimerCard() {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 16, color: Colors.grey.shade600),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              result.disclaimer,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required IconData icon,
    required Widget child,
    Color? accentColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: accentColor ?? Colors.black),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // TODO: Save case to database
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Kes disimpan!")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2962FF),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                "Simpan Kes",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                // Navigate back to home
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text("Selesai"),
            ),
          ),
        ],
      ),
    );
  }
}