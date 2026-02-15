import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', false); // Mark as seen
    if (mounted) Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) => setState(() => _currentPage = page),
            children: [
              _buildOnboardPage("DocTeleMY", "Bantuan triaj AI untuk klinik luar bandar."),
              _buildOnboardPage("Analisa Luka", "Imbasan Cloud Vision untuk penilaian klinikal."),
              _buildOnboardPage("Koordinasi", "Rujukan pantas ke hospital daerah."),
            ],
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: _completeOnboarding, child: const Text("SKIP")),
                Row(children: _buildIndicators()), // Custom dots
                TextButton(
                  onPressed: () => _currentPage == 2 
                      ? _completeOnboarding() 
                      : _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease),
                  child: Text(_currentPage == 2 ? "START" : "NEXT"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // Inside your OnboardingView build method for the button
  }

  // Helper for dots indicator
  List<Widget> _buildIndicators() {
    return List.generate(3, (index) => AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    ));
  }

  Widget _buildOnboardPage(String title, String desc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.health_and_safety, size: 100, color: Colors.blue),
        const SizedBox(height: 40),
        Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        Padding(padding: const EdgeInsets.all(16), child: Text(desc, textAlign: TextAlign.center)),
      ],
    );
  }
}