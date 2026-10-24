import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/mock/mock_crops.dart';
import '../../../models/crop.dart';

class CropSelectorGrid extends StatelessWidget {
  final String? selectedCropId;
  final ValueChanged<String> onSelectCrop;

  const CropSelectorGrid({
    super.key,
    required this.selectedCropId,
    required this.onSelectCrop,
  });

  @override
  Widget build(BuildContext context) {
    final crops = MockCrops.crops;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What crop are you examining?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Select the host crop to tune disease classification models.',
          style: TextStyle(fontSize: 12, color: AppColors.secondaryText),
        ),
        const SizedBox(height: 12),
        Row(
          children: crops.map((crop) {
            final isSelected = selectedCropId == crop.id;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: crop != crops.last ? 10.0 : 0.0,
                ),
                child: _buildSelectableCard(crop, isSelected),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSelectableCard(Crop crop, bool isSelected) {
    return Material(
      color: isSelected ? AppColors.softMint : Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: () => onSelectCrop(crop.id),
        borderRadius: BorderRadius.circular(18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected
                  ? AppColors.primaryForestGreen
                  : AppColors.subtleBorder,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : AppColors.warmOffWhite,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      crop.iconEmoji,
                      style: const TextStyle(fontSize: 26),
                    ),
                  ),
                  if (isSelected)
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: AppColors.primaryForestGreen,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, size: 12, color: Colors.white),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                crop.name,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: isSelected
                      ? AppColors.primaryForestGreen
                      : AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                crop.scientificName.split(' ').first,
                style: const TextStyle(
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                  color: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
