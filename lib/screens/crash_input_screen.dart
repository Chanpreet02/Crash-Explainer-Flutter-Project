import 'package:flutter/material.dart';
import '../models/crash_response.dart';
import '../services/api_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/language_selector.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/result_card.dart';

enum AppState { idle, loading, success, error }

class CrashInputScreen extends StatefulWidget {
  const CrashInputScreen({super.key});

  @override
  State<CrashInputScreen> createState() => _CrashInputScreenState();
}

class _CrashInputScreenState extends State<CrashInputScreen> {
  final TextEditingController _stackTraceController = TextEditingController();
  final ApiService _apiService = ApiService();
  
  String _selectedLanguage = 'english';
  AppState _currentState = AppState.idle;
  String _errorMessage = '';
  CrashResponse? _response;
  
  final List<String> _languages = ['english', 'hindi', 'punjabi'];

  // Example stack trace for easy demoing
  final String _exampleStackTrace = '''Flutter Exception:
Null check operator used on a null value
#0      _MyHomePageState.build (package:my_app/main.dart:42:18)
#1      StatelessElement.build (package:flutter/src/widgets/framework.dart:4837:28)''';

  @override
  void dispose() {
    _stackTraceController.dispose();
    super.dispose();
  }

  Future<void> _analyzeCrash() async {
    final text = _stackTraceController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please paste a stack trace to analyze.', style: AppTypography.body),
          backgroundColor: AppColors.severityCritical,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _currentState = AppState.loading;
      _errorMessage = '';
    });

    try {
      final response = await _apiService.analyzeCrash(text, _selectedLanguage);
      if (!mounted) return;
      
      setState(() {
        _response = response;
        _currentState = AppState.success;
      });
    } catch (e) {
      if (!mounted) return;
      
      setState(() {
        final cleanMessage = e.toString().replaceFirst('Exception: ', '');
        _errorMessage = cleanMessage;
        _currentState = AppState.error;
      });
    }
  }

  void _loadExample() {
    _stackTraceController.text = _exampleStackTrace;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        title: Text('AI Crash Explainer', style: AppTypography.headline),
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: AppColors.border, height: 1.0),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Stack Trace Input', style: AppTypography.title),
                TextButton.icon(
                  onPressed: _loadExample,
                  icon: const Icon(Icons.paste_rounded, size: 16, color: AppColors.primaryAccent),
                  label: Text('Try Example', style: AppTypography.button.copyWith(color: AppColors.primaryAccent)),
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.primaryAccentDim,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Input Area
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: AppColors.surfaceDark,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border),
              ),
              child: TextField(
                controller: _stackTraceController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                style: AppTypography.code,
                decoration: InputDecoration(
                  hintText: 'Paste raw crash logs or stack trace here...\n\nExample:\nException: Null check operator used on a null value',
                  hintStyle: AppTypography.codeHint,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Action Bar
            Row(
              children: [
                LanguageSelector(
                  selectedLanguage: _selectedLanguage,
                  languages: _languages,
                  onChanged: (val) {
                    setState(() => _selectedLanguage = val);
                  },
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _currentState == AppState.loading ? null : _analyzeCrash,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryAccent,
                      foregroundColor: AppColors.backgroundDark,
                      disabledBackgroundColor: AppColors.border,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      elevation: 0,
                    ),
                    child: Text('Analyze Crash', style: AppTypography.button),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 48),
            
            // Dynamic Result Area
            _buildResultArea(),
          ],
        ),
      ),
    );
  }

  Widget _buildResultArea() {
    switch (_currentState) {
      case AppState.idle:
        return const SizedBox.shrink();
        
      case AppState.loading:
        return const LoadingIndicator();
        
      case AppState.error:
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.severityCritical.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.severityCritical.withOpacity(0.3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.error_outline, color: AppColors.severityCritical),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Analysis Failed', style: AppTypography.title.copyWith(color: AppColors.severityCritical)),
                    const SizedBox(height: 4),
                    Text(_errorMessage, style: AppTypography.body),
                  ],
                ),
              ),
            ],
          ),
        );
        
      case AppState.success:
        if (_response == null) return const SizedBox.shrink();
        return ResultCard(response: _response!);
    }
  }
}
