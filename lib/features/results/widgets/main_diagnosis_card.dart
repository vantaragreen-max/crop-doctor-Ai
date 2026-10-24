import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/confidence_indicator.dart';
import '../../../core/widgets/custom_badge.dart';
import '../../../models/diagnosis_result.dart';

class MainDiagnosisCard extends StatelessWidget {
  final DiagnosisResult result;
  final double currentThreshold;
  final VoidCallback onOpenThresholdSlider;

  const MainDiagnosisCard({
    super.key,
    required this.result,
    required this.currentThreshold,
    required this.onOpenThresholdSlider,
  });

  @override
  Widget build(BuildContext context) {
    final isLowConfidence = result.confidence < currentThreshold;
    final isHealthy = result.diseaseName.toLowerCase().contains('healthy');

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isLowConfidence
              ? AppColors.warningAmber
              : AppColors.subtleBorder,
          width: isLowConfidence ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row with demo tag and threshold button
          Row(
            children: [
              const CustomBadge(
                text: 'DEMO RESULT',
                icon: Icons.science_outlined,
                variant: BadgeVariant.demo,
                isSmall: true,
              ),
              const Spacer(),
              InkWell(
                onTap: onOpenThresholdSlider,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.warmOffWhite,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.subtleBorder),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.tune, size: 12, color: AppColors.secondaryText),
                      const SizedBox(width: 4),
                      Text(
                        'Threshold: ${currentThreshold.toInt()}%',
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondaryText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Disease name & Confidence Ring
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Crop: ${result.cropName}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      result.diseaseName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryText,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      result.scientificName,
                      style: const TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: AppColors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        CustomBadge(
                          text: 'Severity: ${result.severityTier}',
                          icon: Icons.shield_outlined,
                          variant: isHealthy
                              ? BadgeVariant.success
                              : (result.severityTier == 'Severe'
                                  ? BadgeVariant.error
                                  : BadgeVariant.warning),
                          isSmall: true,
                        ),
                        CustomBadge(
                          text: isHealthy
                              ? 'Foliage Healthy'
                              : 'Damage: ${result.foliarDamagePct.toStringAsFixed(1)}%',
                          icon: Icons.crop_free,
                          variant: isHealthy
                              ? BadgeVariant.success
                              : BadgeVariant.neutral,
                          isSmall: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ConfidenceIndicator(
                confidence: result.confidence,
                threshold: currentThreshold,
                size: 96,
                showLabel: false,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Overview description
          Text(
            result.overview,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.primaryText,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14),

          // Primary Demo Notice Card
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7).withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFFDE68A)),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, size: 16, color: Color(0xFF92400E)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    AppConstants.demoNoticeFull,
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF78350F),
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
