// AI Processing Screen
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kitahack_app/features/triage/results/case_model.dart';
import 'package:kitahack_app/features/triage/results/result_page.dart';
import 'package:kitahack_app/features/triage/results/severity_enum.dart';
import 'package:kitahack_app/features/triage/triage_page.dart';

class AnalysisView extends StatefulWidget {
  final CaseDraft draft;

  const AnalysisView({
    super.key,
    required this.draft,
  });

  @override
  State<AnalysisView> createState() => _AnalysisViewState();
}

class _AnalysisViewState extends State<AnalysisView> {
  double _progress = 0.0;
  int _taskIndex = 0;

  final List<String> _tasks = [
    "Memeriksa tanda bahaya...",
    "Membanding dengan kes serupa...",
    "Menghasilkan cadangan...",
    "Menyediakan laporan...",
  ];

  @override
  void initState() {
    super.initState();

    _debugPrintDraft();
    _startAnalysis();
  }


  Future<void> _startAnalysis() async {
    await Future.delayed(const Duration(seconds: 2));

    final newCase = CaseModel(
      name: widget.draft.name,
      age: widget.draft.age,
      gender: widget.draft.gender,
      severity: Severity.sederhana,
      primaryDiagnosis: "Pneumonia (suspek)",
      createdAt: DateTime.now(),
    );

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ResultPage(
          caseData: newCase,
          isReadOnly: false,
        ),
      ),
    );
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Central Icon with Gradient
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Icons.analytics_outlined,
                  size: 64,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                "Menganalisis...",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 48),

              // Animated Task List
              ...List.generate(_tasks.length, (index) => _buildTaskItem(index)),

              const SizedBox(height: 40),
              LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
                minHeight: 10,
              ),
              const SizedBox(height: 8),
              Text(
                "${(_progress * 100).toInt()}% selesai",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTaskItem(int index) {
    bool isDone = index < _taskIndex;
    bool isCurrent = index == _taskIndex;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            isDone
                ? Icons.check_circle
                : (isCurrent ? Icons.sync : Icons.circle_outlined),
            color: isDone
                ? Colors.green
                : (isCurrent ? Colors.blue : Colors.grey),
          ),
          const SizedBox(width: 12),
          Text(
            _tasks[index],
            style: TextStyle(
              color: isDone || isCurrent ? Colors.black : Colors.grey,
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _debugPrintDraft() {
    print("========== DRAFT DATA ==========");

    print("PATIENT INFO: ");
    print("Name: ${widget.draft.name}");
    print("Age: ${widget.draft.age}");
    print("Gender: ${widget.draft.gender}");
    print("Last Clinic Visit: ${widget.draft.lastClinicVisit}");

    print("\nCHRONIC DISEASE: ");
    print("Selected: ${widget.draft.penyakitKronik}");
    print("Other: ${widget.draft.penyakitKronikLain}");

    print("\nSYMPTOMS: ");
    if (widget.draft.symptoms.isEmpty) {
      print("No symptoms selected");
    } else {
      widget.draft.symptoms.forEach((key, value) {
        print("Symptom: $key");

        print("   selected: ${value["selected"]}");
        print("   type: ${value["type"]}");
        print("   duration(extra): ${value["extra"]}");
            });
    }

    print("\nVITALS: ");
    if (widget.draft.vitals.isEmpty) {
      print("No vitals recorded");
    } else {
      widget.draft.vitals.forEach((key, value) {
        print(" - $key : $value");
      });
    }

    print("\nIMAGES: ");
    if (widget.draft.imageFiles.isEmpty) {
      print("No images uploaded");
    } else {
      for (int i = 0; i < widget.draft.imageFiles.length; i++) {
        print("Image $i path: ${widget.draft.imageFiles[i]?.path}");
      }
    }

    print("=================================");
  }

  String _draftToString() {
    final buffer = StringBuffer();

    buffer.writeln("===== PATIENT INFO =====");
    buffer.writeln("Name: ${widget.draft.name}");
    buffer.writeln("Age: ${widget.draft.age}");
    buffer.writeln("Gender: ${widget.draft.gender}");
    buffer.writeln("Last Visit: ${widget.draft.lastClinicVisit}");

    buffer.writeln("\n===== CHRONIC DISEASE =====");
    buffer.writeln("Selected: ${widget.draft.penyakitKronik}");
    buffer.writeln("Other: ${widget.draft.penyakitKronikLain}");

    buffer.writeln("\n===== SYMPTOMS =====");
    if (widget.draft.symptoms.isEmpty) {
      buffer.writeln("No symptoms selected");
    } else {
      widget.draft.symptoms.forEach((key, value) {
        buffer.writeln("$key:");
        buffer.writeln("   type: ${value["type"]}");
        buffer.writeln("   duration: ${value["extra"]}");
      });
    }

    buffer.writeln("\n===== VITALS =====");
    if (widget.draft.vitals.isEmpty) {
      buffer.writeln("No vitals recorded");
    } else {
      widget.draft.vitals.forEach((key, value) {
        buffer.writeln("$key → $value");
      });
    }

    buffer.writeln("\n===== IMAGES =====");
    if (widget.draft.imageFiles.isEmpty) {
      buffer.writeln("No images uploaded");
    } else {
      for (int i = 0; i < widget.draft.imageFiles.length; i++) {
        buffer.writeln("Image $i: ${widget.draft.imageFiles[i]?.path}");
      }
    }

    return buffer.toString();
  }
}
