import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_badge.dart';
import '../../../data/mock/mock_crops.dart';
import '../../../data/mock/mock_references.dart';
import '../../../models/disease.dart';

class DiseaseDetailScreen extends StatelessWidget {
  final Disease disease;

  const DiseaseDetailScreen({
    super.key,
    required this.disease,
  });

  @override
  Widget build(BuildContext context) {
    final crop = MockCrops.getById(disease.cropId);
    final references = MockReferences.getReferencesForDisease(disease.id);

    return Scaffold(
      backgroundColor: AppColors.warmOffWhite,
      appBar: AppBar(
        backgroundColor: AppColors.warmOffWhite,
        elevation: 0,
        title: Text(
          disease.name,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: AppColors.primaryText,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.subtleBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.softMint,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(crop.iconEmoji, style: const TextStyle(fontSize: 26)),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              crop.name,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryText,
                              ),
                            ),
                            Text(
                              disease.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primaryText,
                              ),
                            ),
                            Text(
                              disease.scientificName,
                              style: const TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                                color: AppColors.primaryForestGreen,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      CustomBadge(
                        text: 'Pathogen: ${disease.pathogenType}',
                        variant: disease.isHealthy ? BadgeVariant.success : BadgeVariant.neutral,
                        isSmall: true,
                      ),
                      const SizedBox(width: 8),
                      CustomBadge(
                        text: 'Typical Risk: ${disease.sampleSeverity}',
                        variant: disease.sampleSeverity == 'Severe'
                            ? BadgeVariant.error
                            : (disease.sampleSeverity == 'Moderate'
                                ? BadgeVariant.warning
                                : BadgeVariant.info),
                        isSmall: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Overview
            _buildSection(
              title: 'Overview',
              icon: Icons.info_outline,
              content: Text(
                disease.overview,
                style: const TextStyle(fontSize: 13, height: 1.45, color: AppColors.primaryText),
              ),
            ),
            const SizedBox(height: 14),

            // Typical Symptoms
            _buildSection(
              title: 'Diagnostic Symptoms',
              icon: Icons.visibility_outlined,
              content: Column(
                children: disease.symptoms
                    .map((s) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 5, right: 8),
                                child: Icon(Icons.circle, size: 6, color: AppColors.primaryForestGreen),
                              ),
                              Expanded(
                                child: Text(s, style: const TextStyle(fontSize: 12, height: 1.35)),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 14),

            // Causes & Conditions
            _buildSection(
              title: 'Biological Causes & Conditions',
              icon: Icons.biotech_outlined,
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...disease.possibleCauses.map((c) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 5, right: 8),
                              child: Icon(Icons.arrow_right, size: 16, color: AppColors.infoBlue),
                            ),
                            Expanded(child: Text(c, style: const TextStyle(fontSize: 12, height: 1.35))),
                          ],
                        ),
                      )),
                  const SizedBox(height: 8),
                  const Text('Favorable Weather Drivers:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text(disease.favorableConditions, style: const TextStyle(fontSize: 11, color: AppColors.secondaryText)),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Prevention & Cultural Guidance
            _buildSection(
              title: 'Prevention & Cultural Practices',
              icon: Icons.shield_outlined,
              content: Column(
                children: disease.culturalPractices
                    .map((p) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 5, right: 8),
                                child: Icon(Icons.check, size: 14, color: AppColors.primaryForestGreen),
                              ),
                              Expanded(child: Text(p, style: const TextStyle(fontSize: 12, height: 1.35))),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 14),

            // Low-Cost Organic Management
            _buildSection(
              title: 'Low-Cost Management Steps',
              icon: Icons.eco_outlined,
              content: Column(
                children: disease.lowCostRemedies
                    .map((r) => Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.warmOffWhite,
                            borderRadius: BorderRadius.circular(10),
                            border: const Border(
                              left: BorderSide(color: AppColors.brightLeafGreen, width: 3),
                            ),
                          ),
                          child: Text(r, style: const TextStyle(fontSize: 11, height: 1.35)),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 14),

            // Extension Protocol
            _buildSection(
              title: 'Extension Protocol',
              icon: Icons.local_hospital_outlined,
              content: Text(
                disease.extensionProtocol,
                style: const TextStyle(fontSize: 12, height: 1.4, color: AppColors.secondaryText),
              ),
            ),
            const SizedBox(height: 14),

            // Trusted References
            if (references.isNotEmpty)
              _buildSection(
                title: 'Trusted Agricultural References',
                icon: Icons.menu_book_outlined,
                content: Column(
                  children: references
                      .map((ref) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.library_books, size: 14, color: AppColors.primaryForestGreen),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(ref.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11)),
                                      Text('${ref.organization} • ${ref.publicationDate}', style: const TextStyle(fontSize: 10, color: AppColors.secondaryText)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Widget content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
              Icon(icon, size: 18, color: AppColors.primaryForestGreen),
              const SizedBox(width: 8),
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
          const SizedBox(height: 10),
          content,
        ],
      ),
    );
  }
}
