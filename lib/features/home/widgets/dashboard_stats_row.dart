import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/repositories/history_repository.dart';

class DashboardStatsRow extends ConsumerWidget {
  const DashboardStatsRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalScans = ref.watch(totalScansCountProvider);
    final uniqueCrops = ref.watch(uniqueCropsCountProvider);
    final expertReviews = ref.watch(expertReviewCountProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.subtleBorder, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            label: 'Scans Done',
            value: '$totalScans',
            color: AppColors.primaryForestGreen,
            icon: Icons.qr_code_scanner_rounded,
          ),
          _buildDivider(),
          _buildStatItem(
            label: 'Crops Monitored',
            value: '$uniqueCrops',
            color: AppColors.infoBlue,
            icon: Icons.grass_rounded,
          ),
          _buildDivider(),
          _buildStatItem(
            label: 'Need KVK Review',
            value: '$expertReviews',
            color: AppColors.warningAmberDark,
            icon: Icons.warning_amber_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 32,
      width: 1,
      color: AppColors.subtleBorder,
    );
  }

  Widget _buildStatItem({
    required String label,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.secondaryText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
