import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cyircle_app/providers/theme_mode_provider.dart';

class ThemeModeButton extends ConsumerStatefulWidget {
  const ThemeModeButton({super.key});

  @override
  ConsumerState<ThemeModeButton> createState() {
    return _ThemeModeButtonState();
  }
}

class _ThemeModeButtonState extends ConsumerState<ThemeModeButton> {
  @override
  Widget build(BuildContext context) {
    final currentAppTheme = ref.watch(themeModeProvider);
    final currentAppThemeNotifier = ref.watch(themeModeProvider.notifier);

    return IconButton(
      onPressed: () {
        currentAppThemeNotifier.toggleThemeMode();
      },
      icon: Icon(
        currentAppTheme == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
      ),
    );
  }
}
