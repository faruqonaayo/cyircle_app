import 'package:cyircle_app/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(CyircleApp());
}

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromRGBO(79, 149, 157, 1),
  brightness: Brightness.light,
);

var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromRGBO(79, 149, 157, 1),
  brightness: Brightness.dark,
);

class CyircleApp extends StatelessWidget {
  const CyircleApp({super.key});
  ThemeData _getThemeData(ColorScheme colorScheme) {
    return ThemeData().copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: TextTheme().copyWith(
        displayLarge: GoogleFonts.josefinSans(color: colorScheme.onSurface),
        displayMedium: GoogleFonts.josefinSans(color: colorScheme.onSurface),
        displaySmall: GoogleFonts.josefinSans(color: colorScheme.onSurface),
        headlineLarge: GoogleFonts.josefinSans(color: colorScheme.onSurface),
        headlineMedium: GoogleFonts.josefinSans(color: colorScheme.onSurface),
        headlineSmall: GoogleFonts.josefinSans(color: colorScheme.onSurface),
        titleLarge: GoogleFonts.josefinSans(color: colorScheme.onSurface),
        titleMedium: GoogleFonts.josefinSans(color: colorScheme.onSurface),
        titleSmall: GoogleFonts.josefinSans(color: colorScheme.onSurface),
        labelLarge: GoogleFonts.lato(color: colorScheme.onSurface),
        labelMedium: GoogleFonts.lato(color: colorScheme.onSurface),
        labelSmall: GoogleFonts.lato(color: colorScheme.onSurface),
        bodyLarge: GoogleFonts.lato(color: colorScheme.onSurface),
        bodyMedium: GoogleFonts.lato(color: colorScheme.onSurface),
        bodySmall: GoogleFonts.lato(color: colorScheme.onSurface),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: _getThemeData(kColorScheme),
      darkTheme: _getThemeData(kDarkColorScheme),
      title: "Cyircle Application",
      home: const OnboardingScreen(),
    );
  }
}
