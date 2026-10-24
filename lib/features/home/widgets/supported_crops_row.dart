import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/mock/mock_crops.dart';
import '../../../models/crop.dart';

class SupportedCropsRow extends StatelessWidget {
  final ValueChanged<Crop> onSelectCrop;

  const SupportedCropsRow({
    super.key,
    required this.onSelectCrop,
  });

  @override
  Widget build(BuildContext context) {
    final crops = MockCrops.crops;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Supported Crops',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryText,
              ),
            ),
            Text(
              'Tap to diagnose',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryForestGreen,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: crops.map((crop) {
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: crop != crops.last ? 10.0 : 0.0,
                ),
                child: _buildCropCard(context, crop),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCropCard(BuildContext context, Crop crop) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: () => onSelectCrop(crop),
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.subtleBorder, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.softMint,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  crop.iconEmoji,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                crop.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                crop.scientificName,
                style: const TextStyle(
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                  color: AppColors.secondaryText,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Diagnose >',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryForestGreen,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
