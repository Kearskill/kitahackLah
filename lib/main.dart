// lib\main.dart

import 'package:flutter/material.dart';
// import 'app/app.dart';
import 'package:kitahack_app/app/app.dart';
import 'core/services/database_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// ok ni entry point, dia run MyApp
void main() async {
  // ouh kena tambah async
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Start the database service
  final dbService = DatabaseService();
  await dbService.init();

  runApp(const MyApp());
}
