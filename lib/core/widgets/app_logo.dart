import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// AppLogo displays the user's custom logo from assets if present,
/// or falls back gracefully to the branded Eco/Botanical badge.
class AppLogo extends StatelessWidget {
  final double size;
  final double? borderRadius;
  final bool showBackground;
  final Color? backgroundColor;

  const AppLogo({
    super.key,
    this.size = 36,
    this.borderRadius,
    this.showBackground = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? (size * 0.28);

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.asset(
        'assets/images/app_logo.png',
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          // Secondary fallback attempt: check logo.png
          return Image.asset(
            'assets/images/logo.png',
            width: size,
            height: size,
            fit: BoxFit.contain,
            errorBuilder: (context, error2, stackTrace2) {
              // Graceful branded fallback icon
              return Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: showBackground
                      ? (backgroundColor ?? AppColors.softMint)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(radius),
                ),
                child: Center(
                  child: Icon(
                    Icons.eco_rounded,
                    color: AppColors.primaryForestGreen,
                    size: size * 0.58,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
