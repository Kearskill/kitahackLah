import 'severity_enum.dart';

class CaseModel {
  final String name;
  final int age;
  final String gender;

  final Severity severity;
  final String primaryDiagnosis;

  final DateTime createdAt;

  CaseModel({
    required this.name,
    required this.age,
    required this.gender,
    required this.severity,
    required this.primaryDiagnosis,
    required this.createdAt,
  });
}