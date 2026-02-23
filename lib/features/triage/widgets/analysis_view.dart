// AI Processing Screen
import 'dart:async';
import 'package:flutter/material.dart';
import '../results/triage_result_view.dart';

class AnalysisView extends StatefulWidget {
  const AnalysisView({super.key});

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
    _startAnalysis();
  }

  void _startAnalysis() {
    // Simulate a 4-second analysis process
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        if (_progress < 1.0) {
          _progress += 0.025;
          _taskIndex = (_progress * _tasks.length).floor().clamp(
            0,
            _tasks.length - 1,
          );
        } else {
          timer.cancel();
          _navigateToResults();
        }
      });
    });
  }

  void _navigateToResults() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const TriageResultView(category: "SEDERAHANA"),
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
}
