import 'package:kitahack_app/app/app.dart';
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import '../features/home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clinical Assistant',
      debugShowCheckedModeBanner: false, // Removes the red "Debug" corner ribbon
      theme: AppTheme.lightTheme,       // Uses the theme we created earlier
      home: const HomePage(),           // Starts the app on your dashboard
    );
  }
}