import 'package:flutter/material.dart';
import '../../models/lesion_box.dart';

class LeafSample {
  final String key;
  final String title;
  final String cropId;
  final String diseaseId;
  final double confidence;
  final double foliarDamagePct;
  final String severityTier;
  final Color leafBaseColor;
  final List<LesionBox> lesions;
  final String previewDescription;

  const LeafSample({
    required this.key,
    required this.title,
    required this.cropId,
    required this.diseaseId,
    required this.confidence,
    required this.foliarDamagePct,
    required this.severityTier,
    required this.leafBaseColor,
    required this.lesions,
    required this.previewDescription,
  });
}

class MockLeafSamples {
  static const List<LeafSample> samples = [
    LeafSample(
      key: 'tomato_early_blight',
      title: 'Tomato — Early Blight (High Confidence)',
      cropId: 'tomato',
      diseaseId: 'tomato_early_blight',
      confidence: 93.8,
      foliarDamagePct: 14.2,
      severityTier: 'Moderate',
      leafBaseColor: Color(0xFF2E7D32),
      lesions: [
        LesionBox(id: 1, relX: 0.34, relY: 0.38, relW: 0.28, relH: 0.25, areaPct: 3.5, severity: 'Moderate'),
        LesionBox(id: 2, relX: 0.58, relY: 0.58, relW: 0.22, relH: 0.22, areaPct: 2.1, severity: 'Moderate'),
        LesionBox(id: 3, relX: 0.28, relY: 0.68, relW: 0.16, relH: 0.16, areaPct: 0.9, severity: 'Mild'),
      ],
      previewDescription: 'Concentric target spots on mid-canopy leaflet with yellow halos.',
    ),
    LeafSample(
      key: 'tomato_late_blight',
      title: 'Tomato — Late Blight (Severe)',
      cropId: 'tomato',
      diseaseId: 'tomato_late_blight',
      confidence: 96.2,
      foliarDamagePct: 22.8,
      severityTier: 'Severe',
      leafBaseColor: Color(0xFF2E7D32),
      lesions: [
        LesionBox(id: 1, relX: 0.42, relY: 0.28, relW: 0.34, relH: 0.30, areaPct: 4.8, severity: 'Severe'),
        LesionBox(id: 2, relX: 0.26, relY: 0.52, relW: 0.30, relH: 0.26, areaPct: 3.6, severity: 'Severe'),
      ],
      previewDescription: 'Rapid water-soaked lesions spreading across leaf blade tips.',
    ),
    LeafSample(
      key: 'tomato_bacterial_spot_low_conf',
      title: 'Tomato — Bacterial Spot (Low Confidence Demo: 64%)',
      cropId: 'tomato',
      diseaseId: 'tomato_bacterial_spot',
      confidence: 64.5, // Below default 70% threshold to test safety alert!
      foliarDamagePct: 6.8,
      severityTier: 'Mild',
      leafBaseColor: Color(0xFF2E7D32),
      lesions: [
        LesionBox(id: 1, relX: 0.45, relY: 0.42, relW: 0.16, relH: 0.14, areaPct: 0.7, severity: 'Mild'),
        LesionBox(id: 2, relX: 0.60, relY: 0.50, relW: 0.14, relH: 0.13, areaPct: 0.6, severity: 'Mild'),
      ],
      previewDescription: 'Small speckled spots with low certainty — triggers extension officer warning.',
    ),
    LeafSample(
      key: 'potato_early_blight',
      title: 'Potato — Early Blight (Typical)',
      cropId: 'potato',
      diseaseId: 'potato_early_blight',
      confidence: 91.5,
      foliarDamagePct: 11.4,
      severityTier: 'Moderate',
      leafBaseColor: Color(0xFF388E3C),
      lesions: [
        LesionBox(id: 1, relX: 0.36, relY: 0.35, relW: 0.26, relH: 0.24, areaPct: 2.8, severity: 'Moderate'),
        LesionBox(id: 2, relX: 0.52, relY: 0.55, relW: 0.24, relH: 0.22, areaPct: 2.2, severity: 'Moderate'),
      ],
      previewDescription: 'Angular target lesions constrained by potato leaf veins.',
    ),
    LeafSample(
      key: 'potato_late_blight',
      title: 'Potato — Late Blight (High Moisture)',
      cropId: 'potato',
      diseaseId: 'potato_late_blight',
      confidence: 97.4,
      foliarDamagePct: 18.9,
      severityTier: 'Severe',
      leafBaseColor: Color(0xFF388E3C),
      lesions: [
        LesionBox(id: 1, relX: 0.52, relY: 0.30, relW: 0.32, relH: 0.32, areaPct: 4.5, severity: 'Severe'),
        LesionBox(id: 2, relX: 0.30, relY: 0.50, relW: 0.26, relH: 0.24, areaPct: 2.9, severity: 'Moderate'),
      ],
      previewDescription: 'Dark water-soaked margin necrosis characteristic of Phytophthora.',
    ),
    LeafSample(
      key: 'corn_common_rust',
      title: 'Corn — Common Rust (Pustules)',
      cropId: 'corn',
      diseaseId: 'corn_common_rust',
      confidence: 95.0,
      foliarDamagePct: 7.2,
      severityTier: 'Mild',
      leafBaseColor: Color(0xFF43A047),
      lesions: [
        LesionBox(id: 1, relX: 0.44, relY: 0.22, relW: 0.13, relH: 0.11, areaPct: 0.8, severity: 'Mild'),
        LesionBox(id: 2, relX: 0.48, relY: 0.36, relW: 0.14, relH: 0.12, areaPct: 0.9, severity: 'Mild'),
        LesionBox(id: 3, relX: 0.42, relY: 0.50, relW: 0.15, relH: 0.11, areaPct: 0.9, severity: 'Mild'),
        LesionBox(id: 4, relX: 0.46, relY: 0.64, relW: 0.14, relH: 0.11, areaPct: 0.8, severity: 'Mild'),
        LesionBox(id: 5, relX: 0.43, relY: 0.76, relW: 0.13, relH: 0.10, areaPct: 0.7, severity: 'Mild'),
      ],
      previewDescription: 'Cinnamon pustules aligned across linear corn leaf midrib.',
    ),
    LeafSample(
      key: 'corn_northern_leaf_blight',
      title: 'Corn — Northern Leaf Blight (Cigar Lesion)',
      cropId: 'corn',
      diseaseId: 'corn_northern_leaf_blight',
      confidence: 94.1,
      foliarDamagePct: 12.6,
      severityTier: 'Moderate',
      leafBaseColor: Color(0xFF43A047),
      lesions: [
        LesionBox(id: 1, relX: 0.40, relY: 0.34, relW: 0.22, relH: 0.38, areaPct: 3.4, severity: 'Moderate'),
      ],
      previewDescription: 'Long elliptical cigar-shaped grayish lesion along blade.',
    ),
    LeafSample(
      key: 'tomato_healthy',
      title: 'Tomato — Healthy Foliage (Clean)',
      cropId: 'tomato',
      diseaseId: 'tomato_healthy',
      confidence: 98.2,
      foliarDamagePct: 0.0,
      severityTier: 'Healthy',
      leafBaseColor: Color(0xFF2E7D32),
      lesions: [],
      previewDescription: 'Clean, turgid leaf with intact cuticle and zero lesions.',
    ),
    LeafSample(
      key: 'corn_healthy',
      title: 'Corn — Healthy Foliage (Clean)',
      cropId: 'corn',
      diseaseId: 'corn_healthy',
      confidence: 97.6,
      foliarDamagePct: 0.0,
      severityTier: 'Healthy',
      leafBaseColor: Color(0xFF43A047),
      lesions: [],
      previewDescription: 'Clean parallel-veined green corn blade.',
    ),
  ];

  static LeafSample getByKey(String key) {
    return samples.firstWhere(
      (s) => s.key == key,
      orElse: () => samples.first,
    );
  }

  static List<LeafSample> getForCrop(String cropId) {
    return samples.where((s) => s.cropId == cropId).toList();
  }
}
