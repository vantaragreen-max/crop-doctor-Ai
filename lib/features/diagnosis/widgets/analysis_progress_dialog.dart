import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class AnalysisProgressDialog extends StatelessWidget {
  final int stage; // 1 to 5
  final String label;

  const AnalysisProgressDialog({
    super.key,
    required this.stage,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final stages = [
      'Preparing image & checking resolution',
      'Examining visible leaf symptoms',
      'Checking disease patterns & contours',
      'Retrieving agricultural guidance (ICAR/KVK)',
      'Preparing leaf diagnostic report',
    ];

    return PopScope(
      canPop: false,
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Pulsing leaf emblem
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.softMint,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.psychology_outlined,
                    color: AppColors.primaryForestGreen,
                    size: 32,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Analyzing Crop Health',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryText,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.primaryForestGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 18),
              // Linear progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: (stage / 5.0).clamp(0.1, 1.0),
                  minHeight: 6,
                  backgroundColor: AppColors.softMint,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.primaryForestGreen,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              // Stages checklist
              Column(
                children: List.generate(stages.length, (index) {
                  final itemStage = index + 1;
                  final isDone = itemStage < stage;
                  final isCurrent = itemStage == stage;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      children: [
                        Icon(
                          isDone
                              ? Icons.check_circle_rounded
                              : (isCurrent
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_unchecked),
                          size: 16,
                          color: isDone
                              ? AppColors.primaryForestGreen
                              : (isCurrent
                                  ? AppColors.primaryForestGreen
                                  : AppColors.mutedText),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            stages[index],
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isCurrent ? FontWeight.w700 : FontWeight.normal,
                              color: isCurrent
                                  ? AppColors.primaryText
                                  : (isDone
                                      ? AppColors.secondaryText
                                      : AppColors.mutedText),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(height: 12),
              const Text(
                'Deterministic Demo Mode Active',
                style: TextStyle(fontSize: 10, color: AppColors.mutedText, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
