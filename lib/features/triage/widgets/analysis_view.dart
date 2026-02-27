import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kitahack_app/core/services/ai_diagnosis_service.dart';
import 'package:kitahack_app/features/triage/triage_page.dart';
import 'package:kitahack_app/features/triage/results/ai_result_page.dart';

class AnalysisView extends StatefulWidget {
  final CaseDraft draft;

  const AnalysisView({super.key, required this.draft});

  @override
  State<AnalysisView> createState() => _AnalysisViewState();
}

class _AnalysisViewState extends State<AnalysisView> {
  double _progress = 0.0;
  int _taskIndex = 0;
  String? _errorMessage;
  bool _isAnalyzing = true;

  final List<String> _tasks = [
    "Memeriksa tanda bahaya...",
    "Menghantar data ke AI...",
    "Menganalisis simptom...",
    "Menyediakan cadangan...",
  ];

  @override
  void initState() {
    super.initState();
    _startAnalysis();
  }

  Future<void> _startAnalysis() async {
    // Task 1: Red flag check
    await _updateProgress(0, 0.25);
    
    // Task 2: Sending to AI
    await _updateProgress(1, 0.5);
    
    try {
      // Task 3: Analyzing
      await _updateProgress(2, 0.75);
      
      // Call the actual AI API
      final vitalsText = widget.draft.getVitalsText();
      final result = await AIDiagnosisService.getDiagnosis(
        symptoms: widget.draft.getSymptomsText(),
        patientAge: widget.draft.age > 0 ? widget.draft.age : null,
        patientGender: widget.draft.gender.isNotEmpty ? widget.draft.gender : null,
        duration: widget.draft.getDurationText(),
        vitalsText: vitalsText.isNotEmpty ? vitalsText : null,
      );
      
      // Store result in draft
      widget.draft.aiResult = result;
      
      // Task 4: Complete
      await _updateProgress(3, 1.0);
      
      // Small delay to show completion
      await Future.delayed(const Duration(milliseconds: 500));
      
      if (!mounted) return;
      
      // Navigate to AI result page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => AIResultPage(
            draft: widget.draft,
            result: result,
          ),
        ),
      );
      
    } catch (e) {
      if (!mounted) return;
      
      setState(() {
        _isAnalyzing = false;
        _errorMessage = e is AIDiagnosisException 
            ? e.message 
            : "Ralat rangkaian. Sila cuba lagi.";
      });
    }
  }

  Future<void> _updateProgress(int taskIndex, double progress) async {
    if (!mounted) return;
    setState(() {
      _taskIndex = taskIndex;
      _progress = progress;
    });
    await Future.delayed(const Duration(milliseconds: 400));
  }

  void _retry() {
    setState(() {
      _isAnalyzing = true;
      _errorMessage = null;
      _progress = 0.0;
      _taskIndex = 0;
    });
    _startAnalysis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _errorMessage != null 
              ? _buildErrorView() 
              : _buildAnalyzingView(),
        ),
      ),
    );
  }

  Widget _buildAnalyzingView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
          "Menganalisis dengan AI...",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          "Gemini 2.0 Flash",
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
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
    );
  }

  Widget _buildErrorView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red.shade400,
          ),
        ),
        const SizedBox(height: 32),
        const Text(
          "Analisis Gagal",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          _errorMessage!,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 32),
        ElevatedButton.icon(
          onPressed: _retry,
          icon: const Icon(Icons.refresh),
          label: const Text("Cuba Lagi"),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Kembali"),
        ),
      ],
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