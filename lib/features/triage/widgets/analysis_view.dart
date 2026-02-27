// lib\features\triage\widgets\analysis_view.dart
// AI Processing Screen
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kitahack_app/features/triage/results/case_model.dart';
import 'package:kitahack_app/features/triage/results/result_page.dart';
import 'package:kitahack_app/features/triage/results/severity_enum.dart';
import 'package:kitahack_app/features/triage/triage_page.dart';
import '../results/triage_result_view.dart';

class AnalysisView extends StatefulWidget {
  final CaseDraft draft;

  const AnalysisView({super.key, required this.draft});

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
        builder: (_) => ResultPage(caseData: newCase, isReadOnly: false),
      ),
    );
  }
  // void _startAnalysis() {
  //   // Simulate a 4-second analysis process
  //   Timer.periodic(const Duration(milliseconds: 100), (timer) {
  //     setState(() {
  //       if (_progress < 1.0) {
  //         _progress += 0.025;
  //         _taskIndex = (_progress * _tasks.length).floor().clamp(
  //           0,
  //           _tasks.length - 1,
  //         );
  //       } else {
  //         timer.cancel();
  //         _navigateToResults();
  //       }
  //     });
  //   });
  // }

  // comment sekejap
  // void _navigateToResults() {
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => const TriageResultView(category: "SEDERAHANA"),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // REMOVED 'const' from the list below
            children: [
              // Central Icon with Gradient
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  // Added const here
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

              // Animated Task List (Dynamic - cannot be const)
              ...List.generate(_tasks.length, (index) => _buildTaskItem(index)),

              const SizedBox(height: 40),
              LinearProgressIndicator(
                value: _progress, // Dynamic value
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
    print("===== DRAFT DATA =====");
    print("Name: ${widget.draft.name}");
    print("Age: ${widget.draft.age}");
    print("Gender: ${widget.draft.gender}");
    print("Last Clinic Visit: ${widget.draft.lastClinicVisit}");

    print("Chronic Disease: ${widget.draft.penyakitKronik}");
    print("Chronic Other: ${widget.draft.penyakitKronikLain}");

    print("Symptoms:");
    widget.draft.symptoms.forEach((key, value) {
      print(" - $key : $value");
    });

    print("Vitals:");
    widget.draft.vitals.forEach((key, value) {
      print(" - $key : $value");
    });

    print("======================");
  }

  String _draftToString() {
    final buffer = StringBuffer();

    buffer.writeln("Name: ${widget.draft.name}");
    buffer.writeln("Age: ${widget.draft.age}");
    buffer.writeln("Gender: ${widget.draft.gender}");
    buffer.writeln("Last Visit: ${widget.draft.lastClinicVisit}");

    buffer.writeln("\nChronic Disease:");
    buffer.writeln(widget.draft.penyakitKronik);
    buffer.writeln("Other: ${widget.draft.penyakitKronikLain}");

    buffer.writeln("\nSymptoms:");
    widget.draft.symptoms.forEach((key, value) {
      buffer.writeln("$key → $value");
    });

    buffer.writeln("\nVitals:");
    widget.draft.vitals.forEach((key, value) {
      buffer.writeln("$key → $value");
    });

    return buffer.toString();
  }
}
