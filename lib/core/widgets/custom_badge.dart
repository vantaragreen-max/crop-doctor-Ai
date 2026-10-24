import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

enum BadgeVariant {
  demo,
  success,
  warning,
  error,
  info,
  neutral,
}

class CustomBadge extends StatelessWidget {
  final String text;
  final IconData? icon;
  final BadgeVariant variant;
  final bool isSmall;

  const CustomBadge({
    super.key,
    required this.text,
    this.icon,
    this.variant = BadgeVariant.info,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    Color border;

    switch (variant) {
      case BadgeVariant.demo:
        bg = const Color(0xFFFEF3C7);
        fg = const Color(0xFF92400E);
        border = const Color(0xFFFDE68A);
        break;
      case BadgeVariant.success:
        bg = AppColors.successGreenLight;
        fg = const Color(0xFF166534);
        border = const Color(0xFFBBF7D0);
        break;
      case BadgeVariant.warning:
        bg = AppColors.warningAmberLight;
        fg = AppColors.warningAmberDark;
        border = const Color(0xFFFDE68A);
        break;
      case BadgeVariant.error:
        bg = AppColors.errorRedLight;
        fg = AppColors.errorRedDark;
        border = const Color(0xFFFECACA);
        break;
      case BadgeVariant.neutral:
        bg = const Color(0xFFF1F5F9);
        fg = const Color(0xFF475569);
        border = const Color(0xFFE2E8F0);
        break;
      case BadgeVariant.info:
        bg = AppColors.softMint;
        fg = AppColors.deepForestGreen;
        border = AppColors.mintAccent;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 8 : 10,
        vertical: isSmall ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: isSmall ? 12 : 14, color: fg),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: isSmall ? 11 : 12,
              fontWeight: FontWeight.w600,
              color: fg,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
