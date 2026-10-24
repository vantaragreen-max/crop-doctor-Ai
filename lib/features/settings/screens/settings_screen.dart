import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/app_logo.dart';
import '../../../core/widgets/custom_badge.dart';
import '../../../data/repositories/history_repository.dart';
import '../../../data/repositories/settings_repository.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  void _confirmClearHistory(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear All Local History?'),
        content: const Text(
          'This will permanently delete all stored leaf diagnosis reports and demonstration scans from this device.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.errorRed),
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(historyListProvider.notifier).clearAll();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All local diagnosis history cleared.')),
              );
            },
            child: const Text('Clear History'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThreshold = ref.watch(confidenceThresholdProvider);
    final notifier = ref.read(confidenceThresholdProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.warmOffWhite,
      appBar: AppBar(
        backgroundColor: AppColors.warmOffWhite,
        elevation: 0,
        title: const Text(
          'Settings & Privacy',
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
            // Confidence Threshold Setting Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.subtleBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.softMint,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.tune_rounded, color: AppColors.primaryForestGreen, size: 20),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Confidence Threshold',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryText,
                          ),
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
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Analyses yielding confidence below this threshold will display an uncertainty warning recommending KVK officer referral.',
                    style: TextStyle(fontSize: 12, color: AppColors.secondaryText, height: 1.35),
                  ),
                  const SizedBox(height: 12),
                  Slider(
                    value: currentThreshold,
                    min: AppConstants.minConfidenceThreshold,
                    max: AppConstants.maxConfidenceThreshold,
                    divisions: 45,
                    activeColor: AppColors.primaryForestGreen,
                    inactiveColor: AppColors.mintAccent,
                    onChanged: (val) => notifier.setThreshold(val),
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
            const SizedBox(height: 16),

            // Demo Mode Information Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.subtleBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.science_outlined, color: AppColors.warningAmberDark, size: 20),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Demo Mode Disclosure',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryText,
                          ),
                        ),
                      ),
                      CustomBadge(
                        text: 'PROTOTYPE',
                        variant: BadgeVariant.demo,
                        isSmall: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Crop Doctor AI is currently operating in deterministic demo simulation mode. '
                    'Predictions are generated from structured agricultural sample scenarios and transparent keyword knowledge retrieval. '
                    'Predictions are not real medical/agronomic diagnoses and must be validated with an agricultural extension officer.',
                    style: TextStyle(fontSize: 12, color: AppColors.secondaryText, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Data & Privacy Card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.subtleBorder),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.lock_outline_rounded, color: AppColors.infoBlue, size: 20),
                      SizedBox(width: 10),
                      Text(
                        'Data & Privacy',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryText,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    '• Zero Cloud Uploads: All photograph analysis and reference retrieval execute locally on your device.\n'
                    '• No Mandatory Account: No farmer registration, phone number tracking, or forced authentication.\n'
                    '• Local History: Diagnostic reports remain stored inside your device’s sandbox via SharedPreferences.',
                    style: TextStyle(fontSize: 12, color: AppColors.secondaryText, height: 1.45),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Storage Management
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.subtleBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Storage Management',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryText,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Remove all cached diagnosis records, seeded demonstration data, and reset threshold.',
                    style: TextStyle(fontSize: 12, color: AppColors.secondaryText),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.errorRed,
                      side: const BorderSide(color: AppColors.errorRed),
                    ),
                    onPressed: () => _confirmClearHistory(context, ref),
                    icon: const Icon(Icons.delete_forever, size: 18),
                    label: const Text('Clear All Local History'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // About Crop Doctor AI
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: AppColors.subtleBorder),
              ),
              child: Column(
                children: [
                  const AppLogo(size: 56),
                  const SizedBox(height: 10),
                  const Text(
                    AppConstants.appName,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: AppColors.primaryText),
                  ),
                  const Text(
                    AppConstants.appTagline,
                    style: TextStyle(fontSize: 12, color: AppColors.secondaryText),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    AppConstants.appVersion,
                    style: TextStyle(fontSize: 11, color: AppColors.mutedText),
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 8),
                  const Text(
                    'Dedicated to smallholder farmers worldwide. Grounded in research from ICAR, CIMMYT, KVKs, and agricultural university extension centers.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 11, color: AppColors.secondaryText, height: 1.4),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.warmOffWhite,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      '📞 Kisan Extension Helpline: 1800-180-1551',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primaryForestGreen),
                    ),
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
}
