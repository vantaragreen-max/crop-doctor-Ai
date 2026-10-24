import '../../models/diagnosis_result.dart';

abstract class CropDiagnosisService {
  Future<DiagnosisResult> diagnose({
    required String cropId,
    String? imagePath,
    String? sampleKey,
    required double currentThreshold,
  });
}
