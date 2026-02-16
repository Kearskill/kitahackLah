import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import '../features/home/home_page.dart';
import '../features/onboarding/splash_view.dart';
import '../features/onboarding/onboarding_view.dart';
import '../features/triage/triage_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DocTeleMy',
      debugShowCheckedModeBanner:
          false, // Removes the red "Debug" corner ribbon
      theme: AppTheme.lightTheme, // Uses the theme we created earlier
      // home: const HomePage(),           // Starts the app on your dashboard
      initialRoute: '/', // Starts at splash every time
      routes: {
        '/': (context) => const SplashView(),
        '/onboarding': (context) => const OnboardingView(),
        '/home': (context) => const HomePage(),
        '/triage': (context) => const TriagePage(),
      },
    );
  }
}
