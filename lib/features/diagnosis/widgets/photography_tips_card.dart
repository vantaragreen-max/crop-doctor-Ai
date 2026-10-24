import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class PhotographyTipsCard extends StatelessWidget {
  const PhotographyTipsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.softMint.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.mintAccent, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.tips_and_updates_outlined, color: AppColors.primaryForestGreen, size: 18),
              SizedBox(width: 8),
              Text(
                'Photography Tips for Reliable Detection',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: AppColors.deepForestGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildTipRow(Icons.center_focus_strong, 'Keep leaf in focus', 'Capture sharp veins and clear lesion boundaries.'),
          const SizedBox(height: 6),
          _buildTipRow(Icons.wb_sunny_outlined, 'Avoid harsh shadows', 'Diffuse morning daylight yields highest accuracy.'),
          const SizedBox(height: 6),
          _buildTipRow(Icons.crop_original, 'Capture visible symptoms', 'Fill 70% of frame with the diseased leaf blade.'),
          const SizedBox(height: 6),
          _buildTipRow(Icons.layers_outlined, 'Use plain background', 'Hold a paper or neutral palm behind the leaf.'),
        ],
      ),
    );
  }

  Widget _buildTipRow(IconData icon, String title, String desc) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 14, color: AppColors.primaryForestGreen),
        const SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 11, color: AppColors.primaryText, height: 1.3),
              children: [
                TextSpan(
                  text: '$title: ',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text: desc,
                  style: const TextStyle(color: AppColors.secondaryText),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
