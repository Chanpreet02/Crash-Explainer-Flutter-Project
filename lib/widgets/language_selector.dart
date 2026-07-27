import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class LanguageSelector extends StatelessWidget {
  final String selectedLanguage;
  final ValueChanged<String> onChanged;
  final List<String> languages;

  const LanguageSelector({
    super.key,
    required this.selectedLanguage,
    required this.onChanged,
    required this.languages,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceElevated,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedLanguage,
          dropdownColor: AppColors.surfaceElevated,
          icon: const Icon(Icons.language_rounded, color: AppColors.textSecondary, size: 20),
          style: AppTypography.body,
          items: languages.map((lang) {
            return DropdownMenuItem(
              value: lang,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(lang[0].toUpperCase() + lang.substring(1)),
              ),
            );
          }).toList(),
          onChanged: (val) {
            if (val != null) onChanged(val);
          },
        ),
      ),
    );
  }
}
