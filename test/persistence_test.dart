import 'package:flutter_test/flutter_test.dart';
import 'package:granthu_project/models/diagnosis_result.dart';
import 'package:granthu_project/services/persistence/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LocalStorageService & Persistence Tests', () {
    late LocalStorageService service;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      service = await LocalStorageService.init();
    });

    test('Initializes with default threshold 70.0 and seeds demonstration history', () {
      expect(service.getConfidenceThreshold(), 70.0);
      final history = service.getHistory();
      expect(history.isNotEmpty, isTrue);
      expect(history.first.isDemo, isTrue);
    });

    test('Sets and persists updated confidence threshold', () async {
      final success = await service.setConfidenceThreshold(82.5);
      expect(success, isTrue);
      expect(service.getConfidenceThreshold(), 82.5);
    });

    test('Saves new diagnosis result and prepends to history', () async {
      final newResult = DiagnosisResult(
        id: 'new_unique_test_scan',
        cropId: 'corn',
        cropName: 'Corn (Maize)',
        diseaseId: 'corn_common_rust',
        diseaseName: 'Corn Common Rust',
        scientificName: 'Puccinia sorghi',
        confidence: 95.0,
        severityTier: 'Mild',
        foliarDamagePct: 5.2,
        analyzedAt: DateTime.now(),
        lesions: const [],
        isLowConfidence: false,
        disclaimer: 'Demo',
        overview: 'Overview',
        favorableConditions: 'Conditions',
        symptoms: const ['Pustules'],
        possibleCauses: const ['Puccinia'],
        immediateRemedies: const ['Sulfur'],
        culturalPrevention: const ['Hybrid'],
        extensionProtocol: 'KVK',
        primarySource: 'CIMMYT',
      );

      await service.saveDiagnosis(newResult);
      final history = service.getHistory();
      expect(history.first.id, 'new_unique_test_scan');
    });

    test('Deletes individual diagnosis from history', () async {
      final historyBefore = service.getHistory();
      final idToDelete = historyBefore.first.id;

      await service.deleteDiagnosis(idToDelete);
      final historyAfter = service.getHistory();
      expect(historyAfter.any((r) => r.id == idToDelete), isFalse);
    });

    test('Clears all history', () async {
      await service.clearHistory();
      final history = service.getHistory();
      expect(history.isEmpty, isTrue);
    });
  });
}
