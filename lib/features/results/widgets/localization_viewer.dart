import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/leaf_canvas_overlay.dart';
import '../../../models/diagnosis_result.dart';

class LocalizationViewer extends StatefulWidget {
  final DiagnosisResult result;

  const LocalizationViewer({
    super.key,
    required this.result,
  });

  @override
  State<LocalizationViewer> createState() => _LocalizationViewerState();
}

class _LocalizationViewerState extends State<LocalizationViewer> {
  bool _showHighlights = true;
  VisualizationMode _mode = VisualizationMode.boundingBoxes;

  @override
  Widget build(BuildContext context) {
    final result = widget.result;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.subtleBorder, width: 1),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Foliar Localization',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
              ),
              // Segmented Control: Original vs Highlighted
              Container(
                decoration: BoxDecoration(
                  color: AppColors.warmOffWhite,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.subtleBorder),
                ),
                padding: const EdgeInsets.all(3),
                child: Row(
                  children: [
                    _buildSegmentButton(
                      label: 'Original',
                      isSelected: !_showHighlights,
                      onTap: () => setState(() => _showHighlights = false),
                    ),
                    _buildSegmentButton(
                      label: 'Highlighted',
                      isSelected: _showHighlights,
                      onTap: () => setState(() => _showHighlights = true),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Secondary Mode Selector (only when Highlighted is active)
          if (_showHighlights) ...[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildModeChip('Bounding Boxes', VisualizationMode.boundingBoxes),
                  const SizedBox(width: 8),
                  _buildModeChip('Grad-CAM Heatmap', VisualizationMode.heatmap),
                  const SizedBox(width: 8),
                  _buildModeChip('Tissue Mask', VisualizationMode.tissueMask),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],

          // Leaf Canvas Overlay
          LeafCanvasOverlay(
            imagePath: result.imagePath,
            cropId: result.cropId,
            diseaseName: result.diseaseName,
            lesions: result.lesions,
            foliarDamagePct: result.foliarDamagePct,
            showHighlights: _showHighlights,
            mode: _mode,
            height: 270,
            isSamplePhoto: result.sampleKey != null,
          ),
          const SizedBox(height: 10),
          Text(
            _showHighlights
                ? 'Overlay demonstrates computer vision lesion localization. In production, YOLOv8 bounding boxes align to exact lesion pixels.'
                : 'Showing unaugmented raw camera photograph.',
            style: const TextStyle(fontSize: 11, color: AppColors.secondaryText),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryForestGreen : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.white : AppColors.secondaryText,
          ),
        ),
      ),
    );
  }

  Widget _buildModeChip(String label, VisualizationMode mode) {
    final isSelected = _mode == mode;

    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          color: isSelected ? Colors.white : AppColors.primaryText,
        ),
      ),
      selected: isSelected,
      selectedColor: AppColors.primaryForestGreen,
      backgroundColor: AppColors.warmOffWhite,
      onSelected: (val) {
        if (val) setState(() => _mode = mode);
      },
      visualDensity: VisualDensity.compact,
      padding: const EdgeInsets.symmetric(horizontal: 4),
    );
  }
}
