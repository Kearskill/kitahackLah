// lib\core\services\app_database.dart

import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

// Import your DAO and Model
import '../../features/triage/data/triage_dao.dart';
import '../../features/triage/data/triage_model.dart';

part 'app_database.g.dart'; // This is what the generator creates uwu

@Database(version: 1, entities: [TriageRecord])
abstract class AppDatabase extends FloorDatabase {
  TriageDao get triageDao;
}
