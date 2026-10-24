import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../models/treatment_recommendation.dart';

class TreatmentCard extends StatelessWidget {
  final TreatmentRecommendation recommendation;

  const TreatmentCard({
    super.key,
    required this.recommendation,
  });

  @override
  Widget build(BuildContext context) {
    Color accentColor;
    IconData icon;

    switch (recommendation.category) {
      case 'Low-Cost Remedy':
        accentColor = AppColors.primaryForestGreen;
        icon = Icons.eco_outlined;
        break;
      case 'Cultural Prevention':
        accentColor = AppColors.infoBlue;
        icon = Icons.shield_outlined;
        break;
      case 'Expert Consultation':
        accentColor = AppColors.warningAmberDark;
        icon = Icons.local_hospital_outlined;
        break;
      default:
        accentColor = AppColors.primaryForestGreen;
        icon = Icons.check_circle_outline;
        break;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border(
          left: BorderSide(color: accentColor, width: 4),
          top: const BorderSide(color: AppColors.subtleBorder, width: 1),
          right: const BorderSide(color: AppColors.subtleBorder, width: 1),
          bottom: const BorderSide(color: AppColors.subtleBorder, width: 1),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: accentColor),
              const SizedBox(width: 6),
              Text(
                recommendation.category,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: accentColor,
                  letterSpacing: 0.3,
                ),
              ),
              const Spacer(),
              Text(
                recommendation.sourceOrganization.split('(').first.trim(),
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.mutedText,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            recommendation.title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            recommendation.description,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.primaryText,
              height: 1.45,
            ),
          ),
          if (recommendation.safetyNotes.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.warmOffWhite,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.security, size: 12, color: AppColors.secondaryText),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Safety: ${recommendation.safetyNotes}',
                      style: const TextStyle(fontSize: 10, color: AppColors.secondaryText),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
