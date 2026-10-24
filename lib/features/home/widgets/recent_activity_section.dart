import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_badge.dart';
import '../../../models/diagnosis_result.dart';

class RecentActivitySection extends StatelessWidget {
  final List<DiagnosisResult> recentItems;
  final ValueChanged<DiagnosisResult> onViewReport;
  final VoidCallback onStartScan;
  final VoidCallback onViewAllHistory;

  const RecentActivitySection({
    super.key,
    required this.recentItems,
    required this.onViewReport,
    required this.onStartScan,
    required this.onViewAllHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Analyses',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryText,
              ),
            ),
            if (recentItems.isNotEmpty)
              TextButton(
                onPressed: onViewAllHistory,
                style: TextButton.styleFrom(
                  visualDensity: VisualDensity.compact,
                  foregroundColor: AppColors.primaryForestGreen,
                ),
                child: const Text('View All', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
          ],
        ),
        const SizedBox(height: 10),
        if (recentItems.isEmpty)
          _buildEmptyState()
        else
          Column(
            children: recentItems.take(3).map((result) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _buildRecentItemCard(result),
              );
            }).toList(),
          ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.subtleBorder, width: 1),
      ),
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColors.softMint,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.camera_enhance_outlined,
              color: AppColors.primaryForestGreen,
              size: 26,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'No Scans Yet',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Photograph a plant leaf to get instant diagnostic insight and organic management steps.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(height: 14),
          ElevatedButton(
            onPressed: onStartScan,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            child: const Text('Start Your First Scan', style: TextStyle(fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentItemCard(DiagnosisResult result) {
    final dateFormat = DateFormat('MMM d, h:mm a');
    final formattedDate = dateFormat.format(result.analyzedAt);
    final isSeedDemo = result.id.startsWith('seed_demo');

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.subtleBorder, width: 1),
      ),
      child: Row(
        children: [
          // Crop leaf thumbnail icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.softMint,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Icon(
                result.diseaseName.toLowerCase().contains('healthy')
                    ? Icons.spa_rounded
                    : Icons.biotech_rounded,
                color: AppColors.primaryForestGreen,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Info column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        result.diseaseName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: AppColors.primaryText,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isSeedDemo)
                      const CustomBadge(
                        text: 'Sample',
                        variant: BadgeVariant.demo,
                        isSmall: true,
                      ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Text(
                      '${result.cropName} • ',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryText,
                      ),
                    ),
                    Text(
                      '${result.confidence.toStringAsFixed(1)}% conf',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: result.isLowConfidence
                            ? AppColors.errorRed
                            : AppColors.primaryForestGreen,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.mutedText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // View report button
          IconButton(
            onPressed: () => onViewReport(result),
            icon: const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: AppColors.primaryForestGreen,
            ),
            tooltip: 'View Diagnostic Report',
          ),
        ],
      ),
    );
  }
}
