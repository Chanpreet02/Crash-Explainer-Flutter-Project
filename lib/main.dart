import 'package:flutter/material.dart';
import 'screens/crash_input_screen.dart';
import 'theme/app_colors.dart';
import 'theme/app_typography.dart';

void main() {
  runApp(const AICrashExplainerApp());
}

class AICrashExplainerApp extends StatelessWidget {
  const AICrashExplainerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Crash Explainer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.backgroundDark,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryAccent,
          surface: AppColors.surfaceDark,
        ),
        textTheme: TextTheme(
          bodyMedium: AppTypography.body,
        ),
        useMaterial3: true,
      ),
      home: const CrashInputScreen(),
    );
  }
}
