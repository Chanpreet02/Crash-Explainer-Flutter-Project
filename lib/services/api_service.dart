import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/crash_response.dart';

class ApiService {
  static const String backendUrl = 'http://127.0.0.1:8000/analyze-crash';

  Future<CrashResponse> analyzeCrash(String stackTrace, String language) async {
  log("This is the payload: ${stackTrace}, ${language}");
    try {
      final response = await http.post(
        Uri.parse(backendUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'stack_trace': stackTrace,
          'language': language,
        }),
      ).timeout(const Duration(seconds: 60));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        log("This is the response: ${response.body}");
        return CrashResponse.fromJson(decoded);
      } else {
        try {
          final errorDecoded = jsonDecode(response.body);
          throw Exception(errorDecoded['detail'] ?? 'Failed with status ${response.statusCode}');
        } catch (_) {
          throw Exception('Failed with status ${response.statusCode}');
        }
      }
    } on Exception catch (e) {
      if (e.toString().contains('TimeoutException')) {
        throw Exception('Connection timed out. Please check if the backend is running and reachable.');
      }
      rethrow;
    }
  }
}
