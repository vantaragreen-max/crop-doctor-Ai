import 'dart:io';
import 'package:flutter/material.dart';
import '../../models/lesion_box.dart';
import '../constants/app_colors.dart';

enum VisualizationMode {
  boundingBoxes,
  heatmap,
  tissueMask,
}

class LeafCanvasOverlay extends StatelessWidget {
  final String? imagePath;
  final String cropId;
  final String diseaseName;
  final List<LesionBox> lesions;
  final double foliarDamagePct;
  final bool showHighlights; // Original vs Highlighted
  final VisualizationMode mode;
  final double height;
  final bool isSamplePhoto;

  const LeafCanvasOverlay({
    super.key,
    this.imagePath,
    required this.cropId,
    required this.diseaseName,
    required this.lesions,
    required this.foliarDamagePct,
    this.showHighlights = true,
    this.mode = VisualizationMode.boundingBoxes,
    this.height = 280,
    this.isSamplePhoto = false,
  });

  @override
  Widget build(BuildContext context) {
    final hasRealFile = imagePath != null &&
        imagePath!.isNotEmpty &&
        File(imagePath!).existsSync();

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: height,
        width: double.infinity,
        color: const Color(0xFF0F172A),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Base layer: Actual image or botanical custom painter
            if (hasRealFile)
              Image.file(
                File(imagePath!),
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, stack) => _buildBotanicalCanvas(),
              )
            else
              _buildBotanicalCanvas(),

            // Overlay layer (only when showHighlights is true)
            if (showHighlights) ...[
              CustomPaint(
                painter: _OverlayPainter(
                  lesions: lesions,
                  mode: mode,
                  cropId: cropId,
                  diseaseName: diseaseName,
                  isArbitraryUpload: hasRealFile && !isSamplePhoto,
                ),
              ),
              // Top notice badge
              Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white24, width: 0.5),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        lesions.isEmpty
                            ? Icons.check_circle_outline
                            : Icons.center_focus_strong,
                        color: lesions.isEmpty
                            ? AppColors.brightLeafGreen
                            : AppColors.warningAmber,
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          lesions.isEmpty
                              ? 'HEALTHY LAMINA — ZERO LESION CONTOURS'
                              : 'AFFECTED AREA: ${foliarDamagePct.toStringAsFixed(1)}% | ${lesions.length} LESIONS DETECTED',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBotanicalCanvas() {
    return CustomPaint(
      painter: _BotanicalLeafPainter(
        cropId: cropId,
        diseaseName: diseaseName,
        lesions: lesions,
        showHighlights: showHighlights,
        mode: mode,
      ),
    );
  }
}

class _BotanicalLeafPainter extends CustomPainter {
  final String cropId;
  final String diseaseName;
  final List<LesionBox> lesions;
  final bool showHighlights;
  final VisualizationMode mode;

  _BotanicalLeafPainter({
    required this.cropId,
    required this.diseaseName,
    required this.lesions,
    required this.showHighlights,
    required this.mode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Dark sleek diagnostic background
    final bgPaint = Paint()..color = const Color(0xFF1E293B);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final isCorn = cropId.toLowerCase().contains('corn');

    // Draw Leaf Shape
    final leafPaint = Paint()..style = PaintingStyle.fill;
    final veinPaint = Paint()
      ..color = const Color(0xFF1B5E20)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final leafPath = Path();

    if (isCorn) {
      // Corn Monocot Blade
      leafPath.moveTo(cx, 18);
      leafPath.quadraticBezierTo(cx + 48, cy, cx + 22, size.height - 18);
      leafPath.lineTo(cx - 22, size.height - 18);
      leafPath.quadraticBezierTo(cx - 48, cy, cx, 18);
      leafPath.close();

      leafPaint.color = (showHighlights && mode == VisualizationMode.tissueMask)
          ? Colors.black
          : const Color(0xFF2E7D32);
      canvas.drawPath(leafPath, leafPaint);

      if (!showHighlights || mode != VisualizationMode.tissueMask) {
        canvas.drawLine(
          Offset(cx, 22),
          Offset(cx, size.height - 22),
          veinPaint,
        );
      }
    } else {
      // Dicot Broad Leaflet for Tomato / Potato
      leafPath.moveTo(cx, 28);
      leafPath.cubicTo(cx + 96, cy - 54, cx + 116, cy + 34, cx, size.height - 28);
      leafPath.cubicTo(cx - 116, cy + 34, cx - 96, cy - 54, cx, 28);
      leafPath.close();

      final baseColor = cropId.toLowerCase() == 'potato'
          ? const Color(0xFF388E3C)
          : const Color(0xFF2E7D32);

      leafPaint.color = (showHighlights && mode == VisualizationMode.tissueMask)
          ? Colors.black
          : baseColor;
      canvas.drawPath(leafPath, leafPaint);

      if (!showHighlights || mode != VisualizationMode.tissueMask) {
        canvas.drawLine(
          Offset(cx, 32),
          Offset(cx, size.height - 32),
          veinPaint,
        );
        for (double y = 75; y < size.height - 45; y += 36) {
          canvas.drawLine(Offset(cx, y), Offset(cx + 50, y - 20), veinPaint);
          canvas.drawLine(Offset(cx, y), Offset(cx - 50, y - 20), veinPaint);
        }
      }
    }

    // Natural lesion rendering on botanical blade
    for (var l in lesions) {
      final lx = l.relX * size.width;
      final ly = l.relY * size.height;
      final lw = l.relW * size.width;
      final lh = l.relH * size.height;
      final lCenter = Offset(lx + lw / 2, ly + lh / 2);

      if (diseaseName.toLowerCase().contains('rust')) {
        final rustPaint = Paint()..color = const Color(0xFFD97706);
        canvas.drawOval(
          Rect.fromCenter(center: lCenter, width: lw * 0.65, height: lh * 0.55),
          rustPaint,
        );
      } else if (diseaseName.toLowerCase().contains('early')) {
        canvas.drawCircle(lCenter, lw * 0.36, Paint()..color = const Color(0xFFFDE68A));
        canvas.drawCircle(lCenter, lw * 0.26, Paint()..color = const Color(0xFF3E2723));
        canvas.drawCircle(lCenter, lw * 0.16, Paint()..color = const Color(0xFF5D4037));
      } else if (diseaseName.toLowerCase().contains('spot')) {
        canvas.drawCircle(lCenter, lw * 0.28, Paint()..color = const Color(0xFFFBBF24));
        canvas.drawCircle(lCenter, lw * 0.18, Paint()..color = const Color(0xFF1E293B));
      } else {
        // Late blight rot
        final rotPaint = Paint()..color = const Color(0xFF263238);
        canvas.drawOval(
          Rect.fromCenter(center: lCenter, width: lw * 0.75, height: lh * 0.7),
          rotPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BotanicalLeafPainter oldDelegate) {
    return oldDelegate.cropId != cropId ||
        oldDelegate.showHighlights != showHighlights ||
        oldDelegate.mode != mode;
  }
}

class _OverlayPainter extends CustomPainter {
  final List<LesionBox> lesions;
  final VisualizationMode mode;
  final String cropId;
  final String diseaseName;
  final bool isArbitraryUpload;

  _OverlayPainter({
    required this.lesions,
    required this.mode,
    required this.cropId,
    required this.diseaseName,
    required this.isArbitraryUpload,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (isArbitraryUpload) {
      // Disclose that demo overlay coordinates are illustrative on arbitrary uploads
      final noticePaint = Paint()..color = Colors.black.withValues(alpha: 0.6);
      canvas.drawRect(
        Rect.fromLTWH(10, size.height - 34, size.width - 20, 24),
        noticePaint,
      );
      final textSpan = const TextSpan(
        text: 'Demonstration overlay — Edge contouring illustrative',
        style: TextStyle(
          color: Colors.white70,
          fontSize: 9,
          fontStyle: FontStyle.italic,
        ),
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas, Offset(16, size.height - 28));
    }

    for (var l in lesions) {
      final lx = l.relX * size.width;
      final ly = l.relY * size.height;
      final lw = l.relW * size.width;
      final lh = l.relH * size.height;
      final lCenter = Offset(lx + lw / 2, ly + lh / 2);

      if (mode == VisualizationMode.heatmap) {
        // Grad-CAM Radial Heatmap
        final gradient = RadialGradient(
          colors: [
            Colors.red.withValues(alpha: 0.85),
            Colors.amber.withValues(alpha: 0.55),
            Colors.blue.withValues(alpha: 0.0),
          ],
          stops: const [0.2, 0.6, 1.0],
        );
        final glowPaint = Paint()
          ..shader = gradient.createShader(
            Rect.fromCircle(center: lCenter, radius: lw * 0.95),
          );
        canvas.drawCircle(lCenter, lw * 0.95, glowPaint);
      } else if (mode == VisualizationMode.tissueMask) {
        // Binary Tissue Mask
        final maskPaint = Paint()..color = Colors.white;
        canvas.drawOval(
          Rect.fromCenter(center: lCenter, width: lw * 0.8, height: lh * 0.8),
          maskPaint,
        );
      } else {
        // Bounding Boxes
        final boxColor = l.severity == 'Severe'
            ? const Color(0xFFEF4444)
            : (l.severity == 'Moderate'
                ? const Color(0xFFF59E0B)
                : const Color(0xFF10B981));

        final boxPaint = Paint()
          ..color = boxColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;
        canvas.drawRect(Rect.fromLTWH(lx, ly, lw, lh), boxPaint);

        // Tag label
        final tagText = '#${l.id} ${l.severity} (${l.areaPct}%)';
        final textSpan = TextSpan(
          text: tagText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        );
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        )..layout();

        final tagBg = Paint()..color = boxColor;
        canvas.drawRect(
          Rect.fromLTWH(lx, ly - 15, textPainter.width + 8, 15),
          tagBg,
        );
        textPainter.paint(canvas, Offset(lx + 4, ly - 13));
      }
    }
  }

  @override
  bool shouldRepaint(covariant _OverlayPainter oldDelegate) {
    return oldDelegate.mode != mode ||
        oldDelegate.lesions.length != lesions.length;
  }
}
