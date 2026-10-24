import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';

class HowItWorksSheet extends StatelessWidget {
  const HowItWorksSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const HowItWorksSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
          const SizedBox(height: 18),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.softMint,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.psychology_outlined,
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
                      'How Crop Doctor AI Works',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryText,
                      ),
                    ),
                    Text(
                      'Science-backed prototype workflow',
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
          const SizedBox(height: 16),
          _buildStep(
            number: '1',
            title: 'Capture a Clear Leaf Photograph',
            description:
                'Photograph a single leaf in natural morning light. Keep the leaf in sharp focus and avoid dark shadows.',
            icon: Icons.photo_camera_rounded,
          ),
          _buildStep(
            number: '2',
            title: 'Edge Computer Vision & Contours',
            description:
                'Image pre-processing isolates the lamina, identifies chlorosis patterns, and segments potential lesion boundaries.',
            icon: Icons.filter_center_focus_rounded,
          ),
          _buildStep(
            number: '3',
            title: 'Pathogen Classification & Confidence',
            description:
                'The model generates a diagnostic probability. If confidence is below the configured threshold (default 70%), an expert alert is triggered.',
            icon: Icons.verified_user_outlined,
          ),
          _buildStep(
            number: '4',
            title: 'RAG Knowledge Retrieval (ICAR & Extension)',
            description:
                'Relevant guidance is retrieved from verified university extension publications and ICAR institutes, prioritizing low-cost organic management.',
            icon: Icons.menu_book_rounded,
          ),
          _buildStep(
            number: '5',
            title: 'Local Farm Safety First',
            description:
                'Demonstration mode disclaimers remind farmers to verify serious outbreaks with local agricultural officers before applying inputs.',
            icon: Icons.health_and_safety_outlined,
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF3C7),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFDE68A)),
            ),
            child: const Text(
              AppConstants.demoNoticeFull,
              style: TextStyle(fontSize: 11, color: Color(0xFF78350F), height: 1.3),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep({
    required String number,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.softMint,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: AppColors.primaryForestGreen,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  description,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.secondaryText,
                    height: 1.3,
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
