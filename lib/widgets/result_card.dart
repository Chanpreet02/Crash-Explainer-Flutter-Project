import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/crash_response.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'severity_badge.dart';

class ResultCard extends StatelessWidget {
  final CrashResponse response;

  const ResultCard({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header with Badge
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                SeverityBadge(severity: response.severity),
              ],
            ),
          ),
          
          const Divider(height: 1, color: AppColors.border),
          
          // Actionable Fix Area
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('SUGGESTED FIX', style: AppTypography.title.copyWith(color: AppColors.primaryAccent)),
                    IconButton(
                      icon: const Icon(Icons.copy_rounded, size: 20, color: AppColors.textSecondary),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: response.fix));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Fix copied to clipboard'),
                            backgroundColor: AppColors.surfaceElevated,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        );
                      },
                      tooltip: 'Copy Fix',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(response.fix, style: AppTypography.body),
              ],
            ),
          ),

          const Divider(height: 1, color: AppColors.border),

          // Cause and Explanation Area
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('LIKELY CAUSE', style: AppTypography.title),
                const SizedBox(height: 8),
                Text(response.cause, style: AppTypography.bodySecondary),
                
                const SizedBox(height: 24),
                
                Text('EXPLANATION', style: AppTypography.title),
                const SizedBox(height: 8),
                Text(response.explanation, style: AppTypography.bodySecondary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
