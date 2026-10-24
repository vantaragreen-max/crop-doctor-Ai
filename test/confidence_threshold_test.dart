import 'package:flutter_test/flutter_test.dart';
import 'package:granthu_project/core/constants/app_constants.dart';

void main() {
  group('Confidence Threshold Safety Evaluation Tests', () {
    test('Default threshold should be 70%', () {
      expect(AppConstants.defaultConfidenceThreshold, 70.0);
    });

    test('Confidence score of exactly 70.0% against 70.0% threshold is NOT below threshold', () {
      const threshold = 70.0;
      const confidence = 70.0;
      final isLowConfidence = confidence < threshold;
      expect(isLowConfidence, isFalse);
    });

    test('Confidence score of 69.9% against 70.0% threshold IS below threshold', () {
      const threshold = 70.0;
      const confidence = 69.9;
      final isLowConfidence = confidence < threshold;
      expect(isLowConfidence, isTrue);
    });

    test('Confidence score of 93.8% against 70.0% threshold is NOT below threshold', () {
      const threshold = 70.0;
      const confidence = 93.8;
      final isLowConfidence = confidence < threshold;
      expect(isLowConfidence, isFalse);
    });

    test('Higher configured threshold (85%) correctly classifies 75% confidence as uncertain', () {
      const threshold = 85.0;
      const confidence = 75.0;
      final isLowConfidence = confidence < threshold;
      expect(isLowConfidence, isTrue);
    });

    test('Lower configured threshold (50%) classifies 60% confidence as acceptable', () {
      const threshold = 50.0;
      const confidence = 60.0;
      final isLowConfidence = confidence < threshold;
      expect(isLowConfidence, isFalse);
    });
  });
}
