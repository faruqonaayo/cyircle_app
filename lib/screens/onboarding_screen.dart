import 'package:cyircle_app/screens/login_screen.dart';
import 'package:cyircle_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth >= 768;

    Widget buildOnboardingImage() {
      return ClipRRect(
        borderRadius: BorderRadius.circular(160),
        child: Image.asset("assets/images/onboarding.gif", width: 320),
      );
    }

    Widget buildOnboardingText() {
      return SizedBox(
        width: isLargeScreen ? double.infinity : screenWidth * 0.8,
        child: Column(
          children: [
            Text(
              "Welcome to Cyircle",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Your number 1 software for keeping your personal belongings safe",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.tertiary.withValues(alpha: 0.8),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    Widget buildOnboardingButtons() {
      return SizedBox(
        child: Column(
          spacing: 8,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (ctx) => SignupScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(16),
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (ctx) => LoginScreen()));
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(16),
                ),
                child: const Text(
                  "Already have an account? Login",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        child: screenWidth < 768
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  buildOnboardingImage(),
                  const SizedBox(height: 32),
                  buildOnboardingText(),
                  const SizedBox(height: 80),
                  buildOnboardingButtons(),
                ],
              )
            : Row(
                children: [
                  buildOnboardingImage(),
                  const SizedBox(width: 32),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildOnboardingText(),
                        const SizedBox(height: 80),
                        buildOnboardingButtons(),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
