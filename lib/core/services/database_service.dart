// lib/core/services/database_service.dart

import 'package:kitahack_app/features/triage/data/triage_dao.dart';
import 'app_database.dart'; // The generated database file

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  late AppDatabase _db;

  Future<void> init() async {
    _db = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }

  // Access the DAO from the service
  TriageDao get triageDao => _db.triageDao;
}
