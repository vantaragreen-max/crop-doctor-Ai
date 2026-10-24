import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/diagnosis_result.dart';
import 'settings_repository.dart';

class HistoryNotifier extends Notifier<List<DiagnosisResult>> {
  @override
  List<DiagnosisResult> build() {
    final storage = ref.watch(localStorageServiceProvider);
    return storage.getHistory();
  }

  void reload() {
    final storage = ref.read(localStorageServiceProvider);
    state = storage.getHistory();
  }

  Future<void> saveResult(DiagnosisResult result) async {
    final storage = ref.read(localStorageServiceProvider);
    await storage.saveDiagnosis(result);
    reload();
  }

  Future<void> deleteResult(String id) async {
    final storage = ref.read(localStorageServiceProvider);
    await storage.deleteDiagnosis(id);
    reload();
  }

  Future<void> clearAll() async {
    final storage = ref.read(localStorageServiceProvider);
    await storage.clearHistory();
    state = [];
  }
}

final historyListProvider =
    NotifierProvider<HistoryNotifier, List<DiagnosisResult>>(
  HistoryNotifier.new,
);

// Computed providers for dashboard personal statistics
final totalScansCountProvider = Provider<int>((ref) {
  final history = ref.watch(historyListProvider);
  return history.length;
});

final uniqueCropsCountProvider = Provider<int>((ref) {
  final history = ref.watch(historyListProvider);
  final crops = history.map((e) => e.cropId).toSet();
  return crops.length;
});

final expertReviewCountProvider = Provider<int>((ref) {
  final history = ref.watch(historyListProvider);
  return history.where((e) => e.isLowConfidence).length;
});
