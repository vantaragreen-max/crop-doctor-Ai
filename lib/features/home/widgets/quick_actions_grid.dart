import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class QuickActionsGrid extends StatelessWidget {
  final VoidCallback onDiagnose;
  final VoidCallback onDiseaseLibrary;
  final VoidCallback onTreatmentGuide;

  const QuickActionsGrid({
    super.key,
    required this.onDiagnose,
    required this.onDiseaseLibrary,
    required this.onTreatmentGuide,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                title: 'Diagnose',
                subtitle: 'Analyze leaf photo',
                icon: Icons.document_scanner_outlined,
                color: AppColors.primaryForestGreen,
                bgColor: AppColors.softMint,
                onTap: onDiagnose,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildActionCard(
                title: 'Library',
                subtitle: 'Symptoms & pests',
                icon: Icons.menu_book_outlined,
                color: AppColors.infoBlue,
                bgColor: AppColors.infoBlueLight,
                onTap: onDiseaseLibrary,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildActionCard(
                title: 'Treatments',
                subtitle: 'Low-cost guidance',
                icon: Icons.healing_outlined,
                color: const Color(0xFFB45309),
                bgColor: AppColors.warningAmberLight,
                onTap: onTreatmentGuide,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.subtleBorder, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.secondaryText,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
