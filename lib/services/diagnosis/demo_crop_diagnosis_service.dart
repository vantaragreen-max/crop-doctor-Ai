import 'dart:math';
import '../../core/constants/app_constants.dart';
import '../../data/mock/mock_crops.dart';
import '../../data/mock/mock_diseases.dart';
import '../../data/mock/mock_leaf_samples.dart';
import '../../data/mock/mock_references.dart';
import '../../models/diagnosis_result.dart';
import 'crop_diagnosis_service.dart';

class DemoCropDiagnosisService implements CropDiagnosisService {
  @override
  Future<DiagnosisResult> diagnose({
    required String cropId,
    String? imagePath,
    String? sampleKey,
    required double currentThreshold,
  }) async {
    // Artificial realistic progressive delay (simulates inference)
    await Future.delayed(const Duration(milliseconds: 1400));

    final crop = MockCrops.getById(cropId);
    LeafSample sample;

    if (sampleKey != null && sampleKey.isNotEmpty) {
      sample = MockLeafSamples.getByKey(sampleKey);
    } else {
      // Deterministically pick scenario based on imagePath hash and cropId
      final cropSamples = MockLeafSamples.getForCrop(cropId);
      if (cropSamples.isNotEmpty) {
        final seed = imagePath != null ? imagePath.hashCode.abs() : 42;
        final index = seed % cropSamples.length;
        sample = cropSamples[index];
      } else {
        sample = MockLeafSamples.samples.first;
      }
    }

    final disease = MockDiseases.getById(sample.diseaseId);
    final ref = MockReferences.getReferencesForDisease(disease.id);
    final primarySource = ref.isNotEmpty
        ? '${ref.first.organization} • ${ref.first.title}'
        : 'Agricultural Extension Manual';

    final isLowConfidence = sample.confidence < currentThreshold;

    return DiagnosisResult(
      id: 'diag_${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(9999)}',
      cropId: crop.id,
      cropName: crop.name,
      diseaseId: disease.id,
      diseaseName: disease.name,
      scientificName: disease.scientificName,
      confidence: sample.confidence,
      severityTier: sample.severityTier,
      foliarDamagePct: sample.foliarDamagePct,
      analyzedAt: DateTime.now(),
      imagePath: imagePath,
      sampleKey: sample.key,
      lesions: sample.lesions,
      inferenceMode: 'Demo Simulation (Deterministic)',
      isDemo: true,
      disclaimer: AppConstants.demoNoticeFull,
      isLowConfidence: isLowConfidence,
      isSaved: false,
      overview: disease.overview,
      favorableConditions: disease.favorableConditions,
      symptoms: disease.symptoms,
      possibleCauses: disease.possibleCauses,
      immediateRemedies: disease.lowCostRemedies,
      culturalPrevention: disease.culturalPractices,
      extensionProtocol: disease.extensionProtocol,
      primarySource: primarySource,
    );
  }
}
