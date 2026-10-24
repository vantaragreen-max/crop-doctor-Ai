import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_badge.dart';
import '../../../data/mock/mock_crops.dart';
import '../../../data/mock/mock_diseases.dart';

class DiseaseLibraryScreen extends StatefulWidget {
  const DiseaseLibraryScreen({super.key});

  @override
  State<DiseaseLibraryScreen> createState() => _DiseaseLibraryScreenState();
}

class _DiseaseLibraryScreenState extends State<DiseaseLibraryScreen> {
  String _selectedFilter = 'all'; // 'all', 'tomato', 'potato', 'corn', 'healthy'

  @override
  Widget build(BuildContext context) {
    final diseases = MockDiseases.diseases.where((d) {
      if (_selectedFilter == 'healthy') return d.isHealthy;
      if (_selectedFilter != 'all') return d.cropId == _selectedFilter;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.warmOffWhite,
      appBar: AppBar(
        backgroundColor: AppColors.warmOffWhite,
        elevation: 0,
        title: const Text(
          'Disease Library',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: AppColors.primaryText,
          ),
        ),
      ),
      body: Column(
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildFilterChip('All Profiles (${MockDiseases.diseases.length})', 'all'),
                const SizedBox(width: 8),
                _buildFilterChip('🍅 Tomato', 'tomato'),
                const SizedBox(width: 8),
                _buildFilterChip('🥔 Potato', 'potato'),
                const SizedBox(width: 8),
                _buildFilterChip('🌽 Corn', 'corn'),
                const SizedBox(width: 8),
                _buildFilterChip('🌿 Healthy Only', 'healthy'),
              ],
            ),
          ),
          const SizedBox(height: 4),

          // Diseases list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: diseases.length,
              separatorBuilder: (ctx, i) => const SizedBox(height: 12),
              itemBuilder: (ctx, index) {
                final d = diseases[index];
                final crop = MockCrops.getById(d.cropId);

                return Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () {
                      context.push('/disease-detail', extra: d);
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.subtleBorder),
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
                                alignment: Alignment.center,
                                child: Text(crop.iconEmoji, style: const TextStyle(fontSize: 22)),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      d.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                        color: AppColors.primaryText,
                                      ),
                                    ),
                                    Text(
                                      d.scientificName,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        fontStyle: FontStyle.italic,
                                        color: AppColors.secondaryText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: AppColors.mutedText,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            d.overview,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.primaryText,
                              height: 1.35,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              CustomBadge(
                                text: d.pathogenType,
                                variant: d.isHealthy ? BadgeVariant.success : BadgeVariant.neutral,
                                isSmall: true,
                              ),
                              const SizedBox(width: 8),
                              CustomBadge(
                                text: 'Severity: ${d.sampleSeverity}',
                                variant: d.sampleSeverity == 'Severe'
                                    ? BadgeVariant.error
                                    : (d.sampleSeverity == 'Moderate'
                                        ? BadgeVariant.warning
                                        : BadgeVariant.info),
                                isSmall: true,
                              ),
                              const Spacer(),
                              Text(
                                '${d.symptoms.length} symptoms listed',
                                style: const TextStyle(fontSize: 10, color: AppColors.mutedText),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedFilter == value;
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          color: isSelected ? Colors.white : AppColors.primaryText,
        ),
      ),
      selected: isSelected,
      selectedColor: AppColors.primaryForestGreen,
      backgroundColor: Colors.white,
      onSelected: (val) {
        if (val) setState(() => _selectedFilter = value);
      },
    );
  }
}
