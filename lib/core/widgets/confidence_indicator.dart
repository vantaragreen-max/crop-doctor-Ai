import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class ConfidenceIndicator extends StatelessWidget {
  final double confidence; // 0.0 to 100.0
  final double threshold;
  final double size;
  final bool showLabel;

  const ConfidenceIndicator({
    super.key,
    required this.confidence,
    required this.threshold,
    this.size = 120,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    final meetsThreshold = confidence >= threshold;
    final strokeColor = meetsThreshold
        ? AppColors.primaryForestGreen
        : AppColors.warningAmber;
    final trackColor = meetsThreshold
        ? AppColors.softMint
        : AppColors.warningAmberLight;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background track
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  value: 1.0,
                  strokeWidth: size * 0.08,
                  valueColor: AlwaysStoppedAnimation<Color>(trackColor),
                ),
              ),
              // Value ring
              SizedBox(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  value: (confidence / 100.0).clamp(0.0, 1.0),
                  strokeWidth: size * 0.08,
                  strokeCap: StrokeCap.round,
                  valueColor: AlwaysStoppedAnimation<Color>(strokeColor),
                ),
              ),
              // Center percentage
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${confidence.toStringAsFixed(1)}%',
                    style: TextStyle(
                      fontSize: size * 0.22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryText,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    meetsThreshold ? 'Confidence' : 'Uncertain',
                    style: TextStyle(
                      fontSize: size * 0.10,
                      fontWeight: FontWeight.w600,
                      color: meetsThreshold
                          ? AppColors.secondaryText
                          : AppColors.warningAmberDark,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (showLabel) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: trackColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Threshold: ${threshold.toInt()}%',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: meetsThreshold
                    ? AppColors.deepForestGreen
                    : AppColors.warningAmberDark,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
