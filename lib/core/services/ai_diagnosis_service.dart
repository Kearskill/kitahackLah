import 'dart:convert';
import 'package:http/http.dart' as http;

class AIDiagnosisService {
  static const String _baseUrl = 'https://asia-southeast1-doctelemy-73257.cloudfunctions.net';

  /// Call the AI diagnosis endpoint
  static Future<DiagnosisResult> getDiagnosis({
    required String symptoms,
    int? patientAge,
    String? patientGender,
    String? duration,
    String? imageBase64,
    String? vitalsText,
  }) async {
    final uri = Uri.parse('$_baseUrl/getDiagnosis');

    final body = <String, dynamic>{
      'symptoms': symptoms,
      if (patientAge != null) 'patient_age': patientAge,
      if (patientGender != null) 'patient_gender': patientGender,
      if (duration != null) 'duration': duration,
      if (imageBase64 != null) 'image_base64': imageBase64,
      if (vitalsText != null && vitalsText.isNotEmpty) 'vitals_text': vitalsText,
    };

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return DiagnosisResult.fromJson(json);
      } else {
        throw AIDiagnosisException(
          'Server error: ${response.statusCode}',
          response.body,
        );
      }
    } catch (e) {
      if (e is AIDiagnosisException) rethrow;
      throw AIDiagnosisException('Network error', e.toString());
    }
  }

  /// Health check endpoint
  static Future<bool> healthCheck() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/healthCheck'),
      ).timeout(const Duration(seconds: 10));
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}

// ============================================================
// DATA MODELS
// ============================================================

class DiagnosisResult {
  final bool isEmergency;
  final String? emergencyMessage;
  final List<PossibleCondition> possibleConditions;
  final String severity; // Ringan, Sederhana, Teruk
  final String recommendedAction;
  final List<String> redFlags;
  final bool referralNeeded;
  final String referralUrgency; // Segera, Dalam 24 jam, Tidak perlu
  final List<String> additionalQuestions;
  final String disclaimer;

  DiagnosisResult({
    required this.isEmergency,
    this.emergencyMessage,
    required this.possibleConditions,
    required this.severity,
    required this.recommendedAction,
    required this.redFlags,
    required this.referralNeeded,
    required this.referralUrgency,
    this.additionalQuestions = const [],
    required this.disclaimer,
  });

  factory DiagnosisResult.fromJson(Map<String, dynamic> json) {
    // Unwrap if cloud function returned error with nested fallback data
    final data = (json.containsKey('fallback') && json['fallback'] is Map)
        ? json['fallback'] as Map<String, dynamic>
        : json;

    return DiagnosisResult(
      isEmergency: data['is_emergency'] ?? false,
      emergencyMessage: data['emergency_message'],
      possibleConditions: (data['possible_conditions'] as List? ?? [])
          .map((c) => PossibleCondition.fromJson(c as Map<String, dynamic>))
          .toList(),
      severity: data['severity'] ?? 'Tidak dapat ditentukan',
      recommendedAction: data['recommended_action'] ?? '',
      redFlags: List<String>.from(data['red_flags'] ?? []),
      referralNeeded: data['referral_needed'] ?? false,
      referralUrgency: data['referral_urgency'] ?? 'Tidak perlu',
      additionalQuestions: List<String>.from(data['additional_questions'] ?? []),
      disclaimer: data['disclaimer'] ?? '',
    );
  }
}

class PossibleCondition {
  final String condition;
  final String confidence; // Tinggi, Sederhana, Rendah
  final String explanation;

  PossibleCondition({
    required this.condition,
    required this.confidence,
    required this.explanation,
  });

  factory PossibleCondition.fromJson(Map<String, dynamic> json) {
    return PossibleCondition(
      condition: json['condition'] ?? '',
      confidence: json['confidence'] ?? 'Rendah',
      explanation: json['explanation'] ?? '',
    );
  }
}

class AIDiagnosisException implements Exception {
  final String message;
  final String details;

  AIDiagnosisException(this.message, this.details);

  @override
  String toString() => 'AIDiagnosisException: $message - $details';
}