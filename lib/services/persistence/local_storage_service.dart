import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';
import '../../data/mock/mock_diseases.dart';
import '../../data/mock/mock_leaf_samples.dart';
import '../../models/diagnosis_result.dart';

class LocalStorageService {
  static const String _keyThreshold = 'confidence_threshold';
  static const String _keyHistory = 'diagnosis_history_v1';
  static const String _keySeeded = 'history_sample_seeded_v1';

  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  static Future<LocalStorageService> init() async {
    final prefs = await SharedPreferences.getInstance();
    final service = LocalStorageService(prefs);
    await service._seedInitialDemonstrationHistory();
    return service;
  }

  // --- Confidence Threshold ---
  double getConfidenceThreshold() {
    return _prefs.getDouble(_keyThreshold) ?? AppConstants.defaultConfidenceThreshold;
  }

  Future<bool> setConfidenceThreshold(double threshold) async {
    return await _prefs.setDouble(_keyThreshold, threshold);
  }

  // --- History ---
  List<DiagnosisResult> getHistory() {
    final rawList = _prefs.getStringList(_keyHistory);
    if (rawList == null || rawList.isEmpty) return [];

    try {
      return rawList.map((jsonStr) {
        final map = jsonDecode(jsonStr) as Map<String, dynamic>;
        return DiagnosisResult.fromJson(map);
      }).toList();
    } catch (_) {
      return [];
    }
  }

  Future<bool> saveDiagnosis(DiagnosisResult result) async {
    final current = getHistory();
    // Prepend new or update existing
    final index = current.indexWhere((r) => r.id == result.id);
    if (index >= 0) {
      current[index] = result.copyWith(isSaved: true);
    } else {
      current.insert(0, result.copyWith(isSaved: true));
    }

    final encoded = current.map((r) => jsonEncode(r.toJson())).toList();
    return await _prefs.setStringList(_keyHistory, encoded);
  }

  Future<bool> deleteDiagnosis(String id) async {
    final current = getHistory();
    current.removeWhere((r) => r.id == id);
    final encoded = current.map((r) => jsonEncode(r.toJson())).toList();
    return await _prefs.setStringList(_keyHistory, encoded);
  }

  Future<bool> clearHistory() async {
    return await _prefs.remove(_keyHistory);
  }

  // Seed sample demonstration history so user has something to explore right away
  Future<void> _seedInitialDemonstrationHistory() async {
    final hasSeeded = _prefs.getBool(_keySeeded) ?? false;
    if (hasSeeded) return;

    final sample1 = MockLeafSamples.samples[0]; // Tomato Early Blight
    final sample2 = MockLeafSamples.samples[3]; // Potato Early Blight
    final sample3 = MockLeafSamples.samples[5]; // Corn Common Rust

    final d1 = MockDiseases.getById(sample1.diseaseId);
    final d2 = MockDiseases.getById(sample2.diseaseId);
    final d3 = MockDiseases.getById(sample3.diseaseId);

    final now = DateTime.now();

    final seededResults = [
      DiagnosisResult(
        id: 'seed_demo_tomato_1',
        cropId: 'tomato',
        cropName: 'Tomato',
        diseaseId: d1.id,
        diseaseName: d1.name,
        scientificName: d1.scientificName,
        confidence: sample1.confidence,
        severityTier: sample1.severityTier,
        foliarDamagePct: sample1.foliarDamagePct,
        analyzedAt: now.subtract(const Duration(hours: 3)),
        sampleKey: sample1.key,
        lesions: sample1.lesions,
        inferenceMode: 'Demo Simulation (Deterministic)',
        isDemo: true,
        disclaimer: AppConstants.demoNoticeFull,
        isLowConfidence: sample1.confidence < AppConstants.defaultConfidenceThreshold,
        isSaved: true,
        overview: d1.overview,
        favorableConditions: d1.favorableConditions,
        symptoms: d1.symptoms,
        possibleCauses: d1.possibleCauses,
        immediateRemedies: d1.lowCostRemedies,
        culturalPrevention: d1.culturalPractices,
        extensionProtocol: d1.extensionProtocol,
        primarySource: 'ICAR-IIVR Demonstration Record',
      ),
      DiagnosisResult(
        id: 'seed_demo_potato_2',
        cropId: 'potato',
        cropName: 'Potato',
        diseaseId: d2.id,
        diseaseName: d2.name,
        scientificName: d2.scientificName,
        confidence: sample2.confidence,
        severityTier: sample2.severityTier,
        foliarDamagePct: sample2.foliarDamagePct,
        analyzedAt: now.subtract(const Duration(days: 1, hours: 2)),
        sampleKey: sample2.key,
        lesions: sample2.lesions,
        inferenceMode: 'Demo Simulation (Deterministic)',
        isDemo: true,
        disclaimer: AppConstants.demoNoticeFull,
        isLowConfidence: sample2.confidence < AppConstants.defaultConfidenceThreshold,
        isSaved: true,
        overview: d2.overview,
        favorableConditions: d2.favorableConditions,
        symptoms: d2.symptoms,
        possibleCauses: d2.possibleCauses,
        immediateRemedies: d2.lowCostRemedies,
        culturalPrevention: d2.culturalPractices,
        extensionProtocol: d2.extensionProtocol,
        primarySource: 'ICAR-CPRI Demonstration Record',
      ),
      DiagnosisResult(
        id: 'seed_demo_corn_3',
        cropId: 'corn',
        cropName: 'Corn (Maize)',
        diseaseId: d3.id,
        diseaseName: d3.name,
        scientificName: d3.scientificName,
        confidence: sample3.confidence,
        severityTier: sample3.severityTier,
        foliarDamagePct: sample3.foliarDamagePct,
        analyzedAt: now.subtract(const Duration(days: 2, hours: 5)),
        sampleKey: sample3.key,
        lesions: sample3.lesions,
        inferenceMode: 'Demo Simulation (Deterministic)',
        isDemo: true,
        disclaimer: AppConstants.demoNoticeFull,
        isLowConfidence: sample3.confidence < AppConstants.defaultConfidenceThreshold,
        isSaved: true,
        overview: d3.overview,
        favorableConditions: d3.favorableConditions,
        symptoms: d3.symptoms,
        possibleCauses: d3.possibleCauses,
        immediateRemedies: d3.lowCostRemedies,
        culturalPrevention: d3.culturalPractices,
        extensionProtocol: d3.extensionProtocol,
        primarySource: 'CIMMYT Demonstration Record',
      ),
    ];

    final encoded = seededResults.map((r) => jsonEncode(r.toJson())).toList();
    await _prefs.setStringList(_keyHistory, encoded);
    await _prefs.setBool(_keySeeded, true);
  }
}
