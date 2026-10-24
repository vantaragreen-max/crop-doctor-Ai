import 'package:flutter_test/flutter_test.dart';
import 'package:granthu_project/models/diagnosis_result.dart';
import 'package:granthu_project/models/lesion_box.dart';

void main() {
  group('DiagnosisResult Serialization Tests', () {
    test('DiagnosisResult toJson and fromJson round-trip preserves all fields', () {
      final original = DiagnosisResult(
        id: 'test_123',
        cropId: 'tomato',
        cropName: 'Tomato',
        diseaseId: 'tomato_early_blight',
        diseaseName: 'Tomato Early Blight',
        scientificName: 'Alternaria solani',
        confidence: 93.5,
        severityTier: 'Moderate',
        foliarDamagePct: 14.2,
        analyzedAt: DateTime.utc(2026, 10, 23, 12, 0, 0),
        imagePath: '/tmp/test_leaf.jpg',
        sampleKey: 'tomato_early_blight',
        lesions: const [
          LesionBox(
            id: 1,
            relX: 0.35,
            relY: 0.42,
            relW: 0.28,
            relH: 0.26,
            areaPct: 2.7,
            severity: 'Moderate',
          ),
        ],
        inferenceMode: 'Demo Simulation (Deterministic)',
        isDemo: true,
        disclaimer: 'Demonstration result only.',
        isLowConfidence: false,
        isSaved: true,
        overview: 'Overview test',
        favorableConditions: 'Favorable conditions test',
        symptoms: const ['Concentric rings', 'Yellow halo'],
        possibleCauses: const ['Alternaria fungus'],
        immediateRemedies: const ['Neem seed extract'],
        culturalPrevention: const ['Bottom pruning'],
        extensionProtocol: 'Call KVK',
        primarySource: 'ICAR-IIVR',
      );

      final json = original.toJson();
      final restored = DiagnosisResult.fromJson(json);

      expect(restored.id, original.id);
      expect(restored.cropId, original.cropId);
      expect(restored.cropName, original.cropName);
      expect(restored.diseaseId, original.diseaseId);
      expect(restored.confidence, original.confidence);
      expect(restored.severityTier, original.severityTier);
      expect(restored.foliarDamagePct, original.foliarDamagePct);
      expect(restored.lesions.length, 1);
      expect(restored.lesions.first.severity, 'Moderate');
      expect(restored.isLowConfidence, original.isLowConfidence);
      expect(restored.isDemo, original.isDemo);
      expect(restored.immediateRemedies.first, 'Neem seed extract');
    });
  });
}
