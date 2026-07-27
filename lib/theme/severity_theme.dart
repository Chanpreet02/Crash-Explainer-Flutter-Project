import 'package:flutter/material.dart';
import 'app_colors.dart';

class SeverityTheme {
  final Color color;
  final IconData icon;
  final String label;

  const SeverityTheme({
    required this.color,
    required this.icon,
    required this.label,
  });

  static SeverityTheme getTheme(String severity) {
    switch (severity.toLowerCase()) {
      case 'low':
        return const SeverityTheme(
          color: AppColors.severityLow,
          icon: Icons.info_outline,
          label: 'LOW',
        );
      case 'medium':
        return const SeverityTheme(
          color: AppColors.severityMedium,
          icon: Icons.warning_amber_rounded,
          label: 'MEDIUM',
        );
      case 'high':
        return const SeverityTheme(
          color: AppColors.severityHigh,
          icon: Icons.warning_rounded,
          label: 'HIGH',
        );
      case 'critical':
        return const SeverityTheme(
          color: AppColors.severityCritical,
          icon: Icons.error_outline,
          label: 'CRITICAL',
        );
      default:
        return const SeverityTheme(
          color: AppColors.textSecondary,
          icon: Icons.help_outline,
          label: 'UNKNOWN',
        );
    }
  }
}
