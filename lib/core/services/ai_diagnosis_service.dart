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
  }) async {
    final uri = Uri.parse('$_baseUrl/getDiagnosis');
    
    final body = {
      'symptoms': symptoms,
      if (patientAge != null) 'patient_age': patientAge,
      if (patientGender != null) 'patient_gender': patientGender,
      if (duration != null) 'duration': duration,
      if (imageBase64 != null) 'image_base64': imageBase64,
    };

    try {
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 30));

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
  final String referralUrgency; // Segera, Dalam 24 jam, Tidak segera
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
    required this.disclaimer,
  });

  factory DiagnosisResult.fromJson(Map<String, dynamic> json) {
    return DiagnosisResult(
      isEmergency: json['is_emergency'] ?? false,
      emergencyMessage: json['emergency_message'],
      possibleConditions: (json['possible_conditions'] as List? ?? [])
          .map((c) => PossibleCondition.fromJson(c))
          .toList(),
      severity: json['severity'] ?? 'Tidak dapat ditentukan',
      recommendedAction: json['recommended_action'] ?? '',
      redFlags: List<String>.from(json['red_flags'] ?? []),
      referralNeeded: json['referral_needed'] ?? false,
      referralUrgency: json['referral_urgency'] ?? 'Tidak segera',
      disclaimer: json['disclaimer'] ?? '',
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