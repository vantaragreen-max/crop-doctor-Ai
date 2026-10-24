import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_badge.dart';
import '../../../models/diagnosis_result.dart';

class HistoryCard extends StatelessWidget {
  final DiagnosisResult result;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const HistoryCard({
    super.key,
    required this.result,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, yyyy • h:mm a');
    final isSeedDemo = result.id.startsWith('seed_demo');
    final isHealthy = result.diseaseName.toLowerCase().contains('healthy');

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: result.isLowConfidence
                  ? AppColors.warningAmber
                  : AppColors.subtleBorder,
              width: result.isLowConfidence ? 1.5 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.softMint,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Icon(
                        isHealthy ? Icons.spa_rounded : Icons.biotech_rounded,
                        color: AppColors.primaryForestGreen,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          result.diseaseName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: AppColors.primaryText,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${result.cropName} • ${dateFormat.format(result.analyzedAt)}',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.secondaryText,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: AppColors.mutedText, size: 20),
                    tooltip: 'Delete Record',
                    onPressed: onDelete,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  CustomBadge(
                    text: '${result.confidence.toStringAsFixed(1)}% Confidence',
                    icon: Icons.verified_outlined,
                    variant: result.isLowConfidence
                        ? BadgeVariant.warning
                        : BadgeVariant.success,
                    isSmall: true,
                  ),
                  CustomBadge(
                    text: result.severityTier,
                    variant: BadgeVariant.neutral,
                    isSmall: true,
                  ),
                  if (isSeedDemo)
                    const CustomBadge(
                      text: 'Sample Seed',
                      variant: BadgeVariant.demo,
                      isSmall: true,
                    ),
                ],
              ),
              if (result.isLowConfidence) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.warningAmberLight,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.warning, size: 12, color: AppColors.warningAmberDark),
                      SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          'Below configured threshold: Recommend KVK extension review',
                          style: TextStyle(fontSize: 10, color: Color(0xFF78350F), fontWeight: FontWeight.w600),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
