import 'package:flutter/material.dart';
import 'package:kitahack_app/features/triage/results/case_model.dart';
import 'package:kitahack_app/features/triage/results/result_page.dart';
import 'package:kitahack_app/features/triage/results/severity_enum.dart';

class CaseHistoryPage extends StatefulWidget {
  const CaseHistoryPage({super.key});

  @override
  State<CaseHistoryPage> createState() => _CaseHistoryPageState();
}

class _CaseHistoryPageState extends State<CaseHistoryPage> {
    final List<CaseModel> dummyCases = [
    CaseModel(
      name: "Ahmad bin Hassan",
      age: 45,
      gender: "Lelaki",
      severity: Severity.ringan,
      primaryDiagnosis: "URTI",
      createdAt: DateTime.now(),
    ),
    CaseModel(
      name: "Siti binti Rahman",
      age: 32,
      gender: "Perempuan",
      severity: Severity.sederhana,
      primaryDiagnosis: "Pneumonia (suspek)",
      createdAt: DateTime.now(),
    ),
    CaseModel(
      name: "Ali bin Ibrahim",
      age: 58,
      gender: "Lelaki",
      severity: Severity.teruk,
      primaryDiagnosis: "Dengue Hemorrhagic Fever",
      createdAt: DateTime.now(),
    ),
  ];
  String selectedFilter = "Semua";
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sejarah Kes"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildFilterButtons(),
            const SizedBox(height: 16),
            ...dummyCases.map((c) => _buildCaseCard(c)).toList(),
          ],
        ),
      ),
    );
  }

    Widget _buildSearchBar() {
    return TextField(
      onChanged: (value) {
        setState(() {
          searchQuery = value.toLowerCase();
        });
      },
      decoration: InputDecoration(
        hintText: "Cari kes...",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildFilterButtons() {
    final filters = ["Semua", "Hari Ini", "Minggu Ini", "Rujukan"];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedFilter == filter;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedFilter = filter;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.blue
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                filter,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCaseCard(CaseModel caseData) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ResultPage(
              caseData: caseData,
              isReadOnly: true,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 5,
              height: 90,
              decoration: BoxDecoration(
                color: _getSeverityColor(caseData.severity),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          caseData.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      _buildSeverityBadge(caseData.severity),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text("${caseData.age} tahun • ${caseData.gender}"),
                  const SizedBox(height: 6),
                  Text(caseData.primaryDiagnosis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getSeverityColor(Severity severity) {
    switch (severity) {
      case Severity.ringan:
        return Colors.green;
      case Severity.sederhana:
        return Colors.orange;
      case Severity.teruk:
        return Colors.red;
    }
  }

  Widget _buildSeverityBadge(Severity severity) {
    String text;
    Color color;

    switch (severity) {
      case Severity.ringan:
        text = "RINGAN";
        color = Colors.green;
        break;
      case Severity.sederhana:
        text = "SEDERHANA";
        color = Colors.orange;
        break;
      case Severity.teruk:
        text = "TERUK";
        color = Colors.red;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }  
}