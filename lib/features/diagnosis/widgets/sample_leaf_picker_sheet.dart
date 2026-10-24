import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_badge.dart';
import '../../../data/mock/mock_leaf_samples.dart';

class SampleLeafPickerSheet extends StatelessWidget {
  final String? currentCropId;
  final ValueChanged<LeafSample> onSelectSample;

  const SampleLeafPickerSheet({
    super.key,
    this.currentCropId,
    required this.onSelectSample,
  });

  static void show(
    BuildContext context, {
    String? currentCropId,
    required ValueChanged<LeafSample> onSelectSample,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => SampleLeafPickerSheet(
        currentCropId: currentCropId,
        onSelectSample: onSelectSample,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Show samples matching crop first, then others
    final samples = List<LeafSample>.from(MockLeafSamples.samples);
    if (currentCropId != null) {
      samples.sort((a, b) {
        if (a.cropId == currentCropId && b.cropId != currentCropId) return -1;
        if (b.cropId == currentCropId && a.cropId != currentCropId) return 1;
        return 0;
      });
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.softMint,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.photo_library_outlined,
                  color: AppColors.primaryForestGreen,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Choose Demonstration Leaf',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryText,
                      ),
                    ),
                    Text(
                      'Pre-configured botanical leaf scenarios',
                      style: TextStyle(fontSize: 12, color: AppColors.secondaryText),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, size: 16, color: Color(0xFF92400E)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Demonstration leaves include pre-calculated contour overlays and verified citations.',
                    style: TextStyle(fontSize: 11, color: Color(0xFF78350F)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: ListView.separated(
              itemCount: samples.length,
              separatorBuilder: (ctx, i) => const SizedBox(height: 10),
              itemBuilder: (ctx, index) {
                final s = samples[index];
                final isCurrentCrop = s.cropId == currentCropId;

                return InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    onSelectSample(s);
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isCurrentCrop ? AppColors.softMint.withValues(alpha: 0.5) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isCurrentCrop ? AppColors.brightLeafGreen : AppColors.subtleBorder,
                        width: isCurrentCrop ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: s.leafBaseColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(Icons.eco, color: s.leafBaseColor, size: 24),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                s.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                  color: AppColors.primaryText,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                s.previewDescription,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.secondaryText,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  CustomBadge(
                                    text: '${s.confidence}% conf',
                                    variant: s.confidence < 70
                                        ? BadgeVariant.warning
                                        : BadgeVariant.success,
                                    isSmall: true,
                                  ),
                                  const SizedBox(width: 6),
                                  CustomBadge(
                                    text: s.severityTier,
                                    variant: BadgeVariant.neutral,
                                    isSmall: true,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                          color: AppColors.mutedText,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
