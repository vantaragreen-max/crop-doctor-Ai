import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/settings_repository.dart';
import '../../../models/diagnosis_result.dart';
import '../../../services/diagnosis/crop_diagnosis_service.dart';
import '../../../services/diagnosis/demo_crop_diagnosis_service.dart';

final cropDiagnosisServiceProvider = Provider<CropDiagnosisService>((ref) {
  return DemoCropDiagnosisService();
});

class DiagnosisWorkflowState {
  final String? selectedCropId;
  final String? selectedImagePath;
  final String? selectedSampleKey;
  final bool isAnalyzing;
  final int progressStage; // 1 to 5
  final String progressLabel;
  final DiagnosisResult? currentResult;
  final String? errorMessage;

  const DiagnosisWorkflowState({
    this.selectedCropId,
    this.selectedImagePath,
    this.selectedSampleKey,
    this.isAnalyzing = false,
    this.progressStage = 1,
    this.progressLabel = 'Ready',
    this.currentResult,
    this.errorMessage,
  });

  bool get canAnalyze =>
      selectedCropId != null &&
      (selectedImagePath != null || selectedSampleKey != null);

  DiagnosisWorkflowState copyWith({
    String? selectedCropId,
    String? selectedImagePath,
    String? selectedSampleKey,
    bool? isAnalyzing,
    int? progressStage,
    String? progressLabel,
    DiagnosisResult? currentResult,
    String? errorMessage,
    bool clearImage = false,
    bool clearSample = false,
    bool clearCrop = false,
    bool clearError = false,
    bool clearResult = false,
  }) {
    return DiagnosisWorkflowState(
      selectedCropId: clearCrop ? null : (selectedCropId ?? this.selectedCropId),
      selectedImagePath: clearImage ? null : (selectedImagePath ?? this.selectedImagePath),
      selectedSampleKey: clearSample ? null : (selectedSampleKey ?? this.selectedSampleKey),
      isAnalyzing: isAnalyzing ?? this.isAnalyzing,
      progressStage: progressStage ?? this.progressStage,
      progressLabel: progressLabel ?? this.progressLabel,
      currentResult: clearResult ? null : (currentResult ?? this.currentResult),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class DiagnosisWorkflowNotifier extends Notifier<DiagnosisWorkflowState> {
  @override
  DiagnosisWorkflowState build() {
    return const DiagnosisWorkflowState();
  }

  void selectCrop(String cropId) {
    state = state.copyWith(selectedCropId: cropId, clearError: true);
  }

  void selectImage(String imagePath) {
    state = state.copyWith(
      selectedImagePath: imagePath,
      clearSample: true,
      clearError: true,
    );
  }

  void selectSample(String sampleKey, String cropId) {
    state = state.copyWith(
      selectedSampleKey: sampleKey,
      selectedCropId: cropId,
      clearImage: true,
      clearError: true,
    );
  }

  void removeImage() {
    state = state.copyWith(clearImage: true, clearSample: true);
  }

  void resetWorkflow() {
    state = const DiagnosisWorkflowState();
  }

  Future<DiagnosisResult?> runAnalysis() async {
    if (state.selectedCropId == null) {
      state = state.copyWith(errorMessage: 'Please select a crop before analyzing.');
      return null;
    }
    if (state.selectedImagePath == null && state.selectedSampleKey == null) {
      state = state.copyWith(errorMessage: 'Please provide a leaf photograph or select a sample.');
      return null;
    }

    state = state.copyWith(
      isAnalyzing: true,
      progressStage: 1,
      progressLabel: 'Preparing leaf photograph...',
      clearError: true,
      clearResult: true,
    );

    try {
      await Future.delayed(const Duration(milliseconds: 350));
      state = state.copyWith(
        progressStage: 2,
        progressLabel: 'Examining visible foliar symptoms...',
      );

      await Future.delayed(const Duration(milliseconds: 400));
      state = state.copyWith(
        progressStage: 3,
        progressLabel: 'Checking disease patterns & lesion contours...',
      );

      await Future.delayed(const Duration(milliseconds: 400));
      state = state.copyWith(
        progressStage: 4,
        progressLabel: 'Retrieving agricultural guidance (ICAR/KVK)...',
      );

      await Future.delayed(const Duration(milliseconds: 350));
      state = state.copyWith(
        progressStage: 5,
        progressLabel: 'Compiling leaf diagnostic report...',
      );

      final currentThreshold = ref.read(confidenceThresholdProvider);
      final service = ref.read(cropDiagnosisServiceProvider);

      final result = await service.diagnose(
        cropId: state.selectedCropId!,
        imagePath: state.selectedImagePath,
        sampleKey: state.selectedSampleKey,
        currentThreshold: currentThreshold,
      );

      state = state.copyWith(
        isAnalyzing: false,
        currentResult: result,
      );

      return result;
    } catch (e) {
      state = state.copyWith(
        isAnalyzing: false,
        errorMessage: 'Analysis could not be completed: $e',
      );
      return null;
    }
  }
}

final diagnosisWorkflowProvider =
    NotifierProvider<DiagnosisWorkflowNotifier, DiagnosisWorkflowState>(
  DiagnosisWorkflowNotifier.new,
);
