// lib/features/triage/triage_page.dart
import 'package:flutter/material.dart';
import 'widgets/patient_info_step.dart';
import 'widgets/symptoms_step.dart';
import 'widgets/vitals_step.dart';
import 'widgets/analysis_view.dart';
import 'widgets/step_indicator.dart';
import 'package:kitahack_app/core/services/ai_diagnosis_service.dart';


class CaseDraft {
  String name = "";
  int age = 0;
  String gender = "";
  String drugAllergy = "";
  String currentMeedication = "";

  Map<String, Map<String, dynamic>> symptoms = {};
  Map<String, dynamic> vitals = {};

  List<String> penyakitKronik = [];
  String penyakitKronikLain = ""; 

  DateTime? lastClinicVisit;
  String pastVisitReason = "";
  bool isFollowUp = false;

  String additionalNotes = "";

  // ADD THIS: Store AI result
  DiagnosisResult? aiResult;
  
  /// Convert symptoms map to readable string for AI
  String getSymptomsText() {
    if (symptoms.isEmpty && additionalNotes.isEmpty) {
      return "Tiada simptom dilaporkan";
    }
    
    List<String> symptomList = [];
    
    symptoms.forEach((symptom, details) {
      String entry = symptom;
      if (details['type'] != null) {
        entry += " (${details['type']})";
      }
      if (details['extra'] != null) {
        entry += " sejak ${details['extra']} hari";
      }
      symptomList.add(entry);
    });
    
    String result = symptomList.join(", ");
    
    if (additionalNotes.isNotEmpty) {
      result += ". Catatan tambahan: $additionalNotes";
    }
    
    return result;
  }
  
  /// Get duration string from symptoms
  String? getDurationText() {
    int? maxDays;
    symptoms.forEach((_, details) {
      if (details['extra'] != null && details['extra'] is int) {
        int days = details['extra'] as int;
        if (maxDays == null || days > maxDays!) {
          maxDays = days;
        }
      }
    });
    return maxDays != null ? "$maxDays hari" : null;
  }

}

class TriagePage extends StatefulWidget {
  const TriagePage({super.key});

  @override
  State<TriagePage> createState() => _TriagePageState();
}

class _TriagePageState extends State<TriagePage> {
  final PageController _pageController = PageController();
  int _currentStep = 0;
  late CaseDraft draft;

  @override
  void initState() {
    super.initState();
    draft = CaseDraft();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AnalysisView(draft: draft),),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _handleBackPress,
      child: Scaffold(
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
          children: [
            PatientInfoStep(draft: draft), 
            SymptomsStep(draft: draft), 
            VitalsStep(draft: draft)],
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
      ), 
    );
  }

  Future<bool> _handleBackPress() async {
    if (_currentStep > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentStep--;
      });

      return false; // prevent exiting page
    }
    return true; // allow exiting if on first step
  }
}
