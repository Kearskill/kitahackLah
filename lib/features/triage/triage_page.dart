// lib/features/triage/triage_page.dart
import 'package:flutter/material.dart';
import 'widgets/patient_info_step.dart';
import 'widgets/symptoms_step.dart';
import 'widgets/vitals_step.dart';
import 'widgets/analysis_view.dart';
import 'widgets/step_indicator.dart';

class TriagePage extends StatefulWidget {
  const TriagePage({super.key});

  @override
  State<TriagePage> createState() => _TriagePageState();
}

class _TriagePageState extends State<TriagePage> {
  final PageController _pageController = PageController();
  int _currentStep = 0;

  void _nextStep() {
    if (_currentStep < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AnalysisView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Dynamic title based on current step
        title: Text(
          _currentStep == 0
              ? "Maklumat Pesakit"
              : (_currentStep == 1 ? "Simptom" : "Tanda Vital"),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: StepIndicator(
            currentStep: _currentStep,
          ), // Using the new widget
        ),
      ),
      body: PageView(
        controller: _pageController,
        physics:
            const NeverScrollableScrollPhysics(), // Disables swiping to ensure step completion
        onPageChanged: (index) => setState(() => _currentStep = index),
        children: const [PatientInfoStep(), SymptomsStep(), VitalsStep()],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _nextStep,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(60),
            backgroundColor: const Color(0xFF2962FF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            _currentStep == 2 ? "Analisis Sekarang" : "Seterusnya →",
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
