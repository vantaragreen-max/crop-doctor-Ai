import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_badge.dart';

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmOffWhite,
      appBar: AppBar(
        backgroundColor: AppColors.warmOffWhite,
        elevation: 0,
        title: const Text(
          'How Crop Doctor AI Works',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: AppColors.primaryText,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Intro Hero
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.deepForestGreen, AppColors.primaryForestGreen],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomBadge(
                    text: 'Scientific Architecture',
                    variant: BadgeVariant.neutral,
                    isSmall: true,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'From Leaf Photograph to Agronomic Action',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Crop Doctor AI combines edge vision models with local document retrieval to assist smallholder farmers in early intervention.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _buildStageCard(
              stageNumber: '01',
              title: 'Leaf Photograph Collection',
              subtitle: 'Capturing clear diagnostic signals',
              description:
                  'Farmers photograph a symptomatic leaf in natural morning lighting. A single leaf filling 70% of the frame eliminates background noise from soil and competing foliage.',
              icon: Icons.camera_alt_outlined,
            ),
            const SizedBox(height: 14),

            _buildStageCard(
              stageNumber: '02',
              title: 'Computer Vision & Lesion Detection',
              subtitle: 'Feature extraction and contour analysis',
              description:
                  'Edge-deployed neural networks (such as YOLOv8 or MobileNetV4) analyze foliar texture, yellow chlorotic halos, and concentric fungal ring patterns on the leaf lamina.',
              icon: Icons.filter_center_focus_outlined,
            ),
            const SizedBox(height: 14),

            _buildStageCard(
              stageNumber: '03',
              title: 'Disease Classification & Confidence',
              subtitle: 'Softmax probability scoring',
              description:
                  'The model outputs a candidate disease along with a statistical confidence score. Confidence reflects the model’s certainty in feature matching — it is NOT a diagnosis guarantee.',
              icon: Icons.insights_outlined,
            ),
            const SizedBox(height: 14),

            _buildStageCard(
              stageNumber: '04',
              title: 'Confidence Safety Gate (70% Default)',
              subtitle: 'Automated extension officer referral',
              description:
                  'If reported confidence falls below the user-configured threshold (default 70%), Crop Doctor AI flags an uncertainty alert and instructs the farmer to contact their local KVK officer before buying inputs.',
              icon: Icons.verified_user_outlined,
            ),
            const SizedBox(height: 14),

            _buildStageCard(
              stageNumber: '05',
              title: 'RAG Knowledge Retrieval',
              subtitle: 'Grounded in ICAR & University research',
              description:
                  'Instead of hallucinations, a Retrieval-Augmented Generation (RAG) pipeline indexes verified extension bulletins (ICAR, CIMMYT, Cornell, Purdue, FAO IPM) to provide safe, low-cost organic remedies.',
              icon: Icons.menu_book_outlined,
            ),
            const SizedBox(height: 20),

            // Critical Distinction Callout
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFFDE68A)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, color: Color(0xFF92400E), size: 20),
                      SizedBox(width: 8),
                      Text(
                        'AI Estimate vs Confirmed Diagnosis',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xFF78350F),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Leaf symptoms from distinct pathogens (e.g., Early Blight vs Septoria vs nutrient deficiencies) can look virtually identical to the naked eye. '
                    'Crop Doctor AI is an early warning assistant, not a substitute for laboratory microscopy or experienced agronomic field officers.',
                    style: TextStyle(fontSize: 12, color: Color(0xFF78350F), height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStageCard({
    required String stageNumber,
    required String title,
    required String subtitle,
    required String description,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.subtleBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.softMint,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColors.primaryForestGreen, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'STAGE $stageNumber',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primaryForestGreen,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 12, color: AppColors.primaryText, height: 1.4),
          ),
        ],
      ),
    );
  }
}
