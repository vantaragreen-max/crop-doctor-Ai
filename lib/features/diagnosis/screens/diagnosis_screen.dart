import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../providers/diagnosis_provider.dart';
import '../widgets/analysis_progress_dialog.dart';
import '../widgets/crop_selector_grid.dart';
import '../widgets/image_picker_area.dart';
import '../widgets/photography_tips_card.dart';
import '../widgets/sample_leaf_picker_sheet.dart';

class DiagnosisScreen extends ConsumerWidget {
  const DiagnosisScreen({super.key});

  Future<void> _handleAnalyze(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(diagnosisWorkflowProvider.notifier);

    // Show non-dismissible analysis dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Consumer(
          builder: (context, dialogRef, child) {
            final state = dialogRef.watch(diagnosisWorkflowProvider);
            return AnalysisProgressDialog(
              stage: state.progressStage,
              label: state.progressLabel,
            );
          },
        );
      },
    );

    final result = await notifier.runAnalysis();

    // Close progress dialog
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    if (result != null && context.mounted) {
      context.push('/results', extra: result);
    } else if (context.mounted) {
      final error = ref.read(diagnosisWorkflowProvider).errorMessage;
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            backgroundColor: AppColors.errorRed,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(diagnosisWorkflowProvider);
    final notifier = ref.read(diagnosisWorkflowProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.warmOffWhite,
      appBar: AppBar(
        backgroundColor: AppColors.warmOffWhite,
        elevation: 0,
        title: const Text(
          'Diagnose Crop Leaf',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: AppColors.primaryText,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => notifier.resetWorkflow(),
            child: const Text(
              'Reset',
              style: TextStyle(
                color: AppColors.secondaryText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Validation error banner if present
            if (state.errorMessage != null)
              Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.errorRedLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.errorRed),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: AppColors.errorRed, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        state.errorMessage!,
                        style: const TextStyle(
                          color: AppColors.errorRedDark,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Step A: Select Crop
            CropSelectorGrid(
              selectedCropId: state.selectedCropId,
              onSelectCrop: (cropId) => notifier.selectCrop(cropId),
            ),
            const SizedBox(height: 22),

            // Step B: Add Leaf Photograph
            ImagePickerArea(
              imagePath: state.selectedImagePath,
              sampleKey: state.selectedSampleKey,
              onImageSelected: (path) => notifier.selectImage(path),
              onSamplePickerTap: () {
                SampleLeafPickerSheet.show(
                  context,
                  currentCropId: state.selectedCropId,
                  onSelectSample: (sample) {
                    notifier.selectSample(sample.key, sample.cropId);
                  },
                );
              },
              onRemoveImage: () => notifier.removeImage(),
            ),
            const SizedBox(height: 18),

            // Photographic Tips
            const PhotographyTipsCard(),
            const SizedBox(height: 24),

            // Step C: Analyze Leaf Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                onPressed: state.isAnalyzing
                    ? null
                    : (state.canAnalyze
                        ? () => _handleAnalyze(context, ref)
                        : () {
                            if (state.selectedCropId == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please select a crop (Tomato, Potato, or Corn) first.'),
                                  backgroundColor: AppColors.warningAmberDark,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please take a photo, choose from gallery, or pick a sample leaf.'),
                                  backgroundColor: AppColors.warningAmberDark,
                                ),
                              );
                            }
                          }),
                icon: state.isAnalyzing
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Icon(Icons.biotech_rounded, size: 22),
                label: Text(
                  state.isAnalyzing ? 'Analyzing Leaf...' : 'Analyze Leaf',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: state.canAnalyze
                      ? AppColors.primaryForestGreen
                      : Colors.grey.shade400,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
