import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:cyircle_app/screens/onboarding_screen.dart';
import 'package:cyircle_app/providers/theme_mode_provider.dart';
import 'package:cyircle_app/screens/loading_screen.dart';
import 'package:cyircle_app/widgets/app_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: CyircleApp()));
}

var kColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromRGBO(103, 148, 54, 1),
  brightness: Brightness.light,
);

var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromRGBO(103, 148, 54, 1),
  brightness: Brightness.dark,
);

class CyircleApp extends ConsumerWidget {
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
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          textStyle: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentAppTheme = ref.watch(themeModeProvider);

    return MaterialApp(
      themeMode: currentAppTheme,
      theme: _getThemeData(kColorScheme),
      darkTheme: _getThemeData(kDarkColorScheme),
      title: "Cyircle Application",
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          }

          if (snapshot.hasData) {
            return const AppLayout();
          }

          return const OnboardingScreen();
        },
      ),
    );
  }
}
