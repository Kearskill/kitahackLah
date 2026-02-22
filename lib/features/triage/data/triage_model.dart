import 'package:floor/floor.dart';

@entity // This tells Floor to create a database table
class TriageRecord {
  @primaryKey // Every patient record needs a unique ID
  final String id;

  final String name;
  final int age;
  final String gender;
  final String symptoms;

  // Vitals
  final double temperature;
  final int heartRate;
  final int respiratoryRate;
  final String bloodPressure;

  // AI Result
  final String triageLevel; // RINGAN, SEDERHANA, TERUK
  final String timestamp;

  TriageRecord({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.symptoms,
    required this.temperature,
    required this.heartRate,
    required this.respiratoryRate,
    required this.bloodPressure,
    required this.triageLevel,
    required this.timestamp,
  });

  // Helper to convert to Firebase format
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'symptoms': symptoms,
      'vitals': {
        'temp': temperature,
        'hr': heartRate,
        'rr': respiratoryRate,
        'bp': bloodPressure,
      },
      'result': triageLevel,
      'date': timestamp,
    };
  }
}
