import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.warmOffWhite,
      appBar: AppBar(
        backgroundColor: AppColors.warmOffWhite,
        elevation: 0,
        title: const Text(
          'Farmer Learning Hub',
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
            // How It Works Banner
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              child: InkWell(
                onTap: () => context.push('/how-it-works'),
                borderRadius: BorderRadius.circular(22),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: AppColors.primaryForestGreen, width: 1.5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.softMint,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.psychology_outlined,
                          color: AppColors.primaryForestGreen,
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'How Crop Doctor AI Works',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: AppColors.primaryText,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Learn how computer vision, threshold safety, and RAG references protect your crops.',
                              style: TextStyle(fontSize: 11, color: AppColors.secondaryText),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.primaryForestGreen),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Educational Guides',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: 12),

            // 1. Recognizing common crop diseases
            _buildGuideCard(
              context,
              title: '1. Recognizing Common Crop Diseases',
              subtitle: 'Key visual markers of Blights, Rusts, and Wilts',
              icon: Icons.biotech_outlined,
              color: AppColors.primaryForestGreen,
              details: [
                'Early Blight: Target-like concentric rings on older lower leaves with yellow halo.',
                'Late Blight: Fast-spreading water-soaked greasy brown lesions with white mold underneath.',
                'Common Rust: Golden-brown to cinnamon powdery pustules along leaf midrib.',
                'Bacterial Spot: Small 2-3mm dark spots with distinct translucent halos.',
              ],
            ),
            const SizedBox(height: 12),

            // 2. Photographing leaves for better analysis
            _buildGuideCard(
              context,
              title: '2. Photographing Leaves for Better AI Accuracy',
              subtitle: 'Techniques to avoid false diagnoses',
              icon: Icons.camera_alt_outlined,
              color: AppColors.infoBlue,
              details: [
                'Fill 70% of the viewfinder with a single symptomatic leaf blade.',
                'Photograph during early morning or overcast light; harsh noon sunlight washes out lesion colors.',
                'Place a neutral hand or plain paper behind the leaf to eliminate background weed interference.',
                'Wipe camera lens clean before snapping; blur is the #1 cause of low-confidence predictions.',
              ],
            ),
            const SizedBox(height: 12),

            // 3. Preventing the spread of plant diseases
            _buildGuideCard(
              context,
              title: '3. Preventing Disease Spread in Your Field',
              subtitle: 'Biosecurity and crop management practices',
              icon: Icons.shield_outlined,
              color: const Color(0xFFB45309),
              details: [
                'Prune bottom 30 cm canopy foliage to stop rain-splash inoculation from soil.',
                'Sterilize shears in 70% rubbing alcohol between plants when pruning tomatoes.',
                'Never walk through or weed fields while foliage is damp with dew.',
                'Immediately rogue (remove, bag, and bury) late-blight infected vines; do not compost them.',
              ],
            ),
            const SizedBox(height: 12),

            // 4. Basic crop hygiene
            _buildGuideCard(
              context,
              title: '4. Essential Crop & Soil Hygiene',
              subtitle: 'Cultural practices recommended by ICAR & FAO',
              icon: Icons.cleaning_services_outlined,
              color: AppColors.deepForestGreen,
              details: [
                'Rotate solanaceous crops (tomato, potato, eggplant) with legumes or maize every 2-3 years.',
                'Adopt ground drip irrigation instead of overhead sprinklers to eliminate prolonged leaf wetness.',
                'Mulch heavily with clean dry straw to prevent soil-borne spore splash.',
                'Deep-till corn residue post-harvest to speed decomposition of Northern Leaf Blight fungal bodies.',
              ],
            ),
            const SizedBox(height: 12),

            // 5. Understanding confidence scores
            _buildGuideCard(
              context,
              title: '5. Understanding Model Confidence Scores',
              subtitle: 'What percentages really mean for your farm',
              icon: Icons.percent_outlined,
              color: AppColors.primaryForestGreen,
              details: [
                'Confidence reflects visual similarity to trained disease prototypes, not a physical certainty.',
                'Score ≥ 70% indicates strong matching characteristics against verified reference symptoms.',
                'Score < 70% automatically triggers an uncertainty warning advising KVK extension officer review.',
                'You can calibrate your personal risk tolerance via the confidence threshold slider.',
              ],
            ),
            const SizedBox(height: 12),

            // 6. When to consult an agricultural expert
            _buildGuideCard(
              context,
              title: '6. When to Consult an Agricultural Expert',
              subtitle: 'Kisan Call Center & KVK protocols',
              icon: Icons.local_hospital_outlined,
              color: AppColors.errorRedDark,
              details: [
                'Outbreaks spreading across >20% of the field within 48 hours.',
                'Unexplained sudden wilt where stems collapse without obvious leaf spotting.',
                'Before investing in expensive synthetic fungicides for unknown conditions.',
                'Kisan Toll-Free Helpline: ${AppConstants.kisanCallCenterTollFree} (Available 6 AM - 10 PM).',
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildGuideCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required List<String> details,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.subtleBorder),
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: const EdgeInsets.only(top: 8),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            color: AppColors.primaryText,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 11, color: AppColors.secondaryText),
        ),
        children: details
            .map((item) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 6, right: 8),
                        child: Icon(Icons.circle, size: 5, color: AppColors.primaryForestGreen),
                      ),
                      Expanded(
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 12, color: AppColors.primaryText, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}
