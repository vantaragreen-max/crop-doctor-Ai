import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../data/repositories/settings_repository.dart';

class ConfidenceSliderSheet extends ConsumerWidget {
  const ConfidenceSliderSheet({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const ConfidenceSliderSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThreshold = ref.watch(confidenceThresholdProvider);
    final notifier = ref.read(confidenceThresholdProvider.notifier);

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.softMint,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.tune_rounded,
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
                      'Confidence Decision Threshold',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryText,
                      ),
                    ),
                    Text(
                      'Safety threshold for extension officer referral',
                      style: TextStyle(fontSize: 11, color: AppColors.secondaryText),
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
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.warmOffWhite,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: AppColors.subtleBorder),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Current Threshold:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppColors.primaryText,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryForestGreen,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${currentThreshold.toInt()}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Slider(
                  value: currentThreshold,
                  min: AppConstants.minConfidenceThreshold,
                  max: AppConstants.maxConfidenceThreshold,
                  divisions: 45,
                  activeColor: AppColors.primaryForestGreen,
                  inactiveColor: AppColors.mintAccent,
                  onChanged: (val) {
                    notifier.setThreshold(val);
                  },
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('50% (Permissive)', style: TextStyle(fontSize: 10, color: AppColors.mutedText)),
                    Text('70% (Default Safe)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.primaryForestGreen)),
                    Text('95% (Strict)', style: TextStyle(fontSize: 10, color: AppColors.mutedText)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Safety Logic: If model confidence < threshold, Crop Doctor AI triggers an urgent warning advising the farmer to collect leaves for a Krishi Vigyan Kendra (KVK) officer before applying costly fungicides.',
            style: TextStyle(fontSize: 11, color: AppColors.secondaryText, height: 1.35),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Apply Threshold'),
            ),
          ),
        ],
      ),
    );
  }
}
