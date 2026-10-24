class AppConstants {
  static const String appName = 'Crop Doctor AI';
  static const String appTagline = 'Know Your Crop. Protect Your Harvest.';
  static const String appVersion = '1.0.0 (Prototype Preview)';

  // Confidence Thresholds
  static const double defaultConfidenceThreshold = 70.0;
  static const double minConfidenceThreshold = 50.0;
  static const double maxConfidenceThreshold = 95.0;

  // Extension Hotline
  static const String kisanCallCenterTollFree = '1800-180-1551';
  static const String extensionEmergencyEmail = 'extension@cropdoctor.ai';

  // Demo Disclaimer Notices
  static const String demoModeBadge = 'DEMO SIMULATION';
  static const String demoNoticeShort =
      'DEMO RESULT — Not a real AI diagnosis';
  static const String demoNoticeFull =
      'Demonstration result. This prediction has not been verified by a trained diagnostic model. '
      'AI predictions are estimates, not confirmed diagnoses. Verify important crop-health decisions '
      'with a qualified agricultural professional.';

  static const String lowConfidenceWarning =
      'Low-confidence result. We couldn’t identify the crop condition reliably. '
      'Try a clearer photograph or consult your local agricultural extension officer before applying treatment.';
}
