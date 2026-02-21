import 'package:flutter/material.dart';
// import 'app/app.dart';
import 'package:kitahack_app/app/app.dart';

// ok ni entry point, dia run MyApp
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Start the database service
  final dbService = DatabaseService();
  await dbService.init();

  
  runApp(const MyApp());
}
