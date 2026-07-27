class CrashResponse {
  final String explanation;
  final String cause;
  final String fix;
  final String severity;

  CrashResponse({
    required this.explanation,
    required this.cause,
    required this.fix,
    required this.severity,
  });

  factory CrashResponse.fromJson(Map<String, dynamic> json) {
    return CrashResponse(
      explanation: json['explanation'] ?? 'No explanation provided.',
      cause: json['cause'] ?? 'No cause provided.',
      fix: json['fix'] ?? 'No fix provided.',
      severity: json['severity'] ?? 'Medium',
    );
  }
}
