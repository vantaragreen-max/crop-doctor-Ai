import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/persistence/local_storage_service.dart';

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  throw UnimplementedError('localStorageServiceProvider must be overridden in main');
});

class ConfidenceThresholdNotifier extends Notifier<double> {
  @override
  double build() {
    final storage = ref.watch(localStorageServiceProvider);
    return storage.getConfidenceThreshold();
  }

  Future<void> setThreshold(double value) async {
    state = value;
    final storage = ref.read(localStorageServiceProvider);
    await storage.setConfidenceThreshold(value);
  }
}

final confidenceThresholdProvider =
    NotifierProvider<ConfidenceThresholdNotifier, double>(
  ConfidenceThresholdNotifier.new,
);
