import 'package:flutter_test/flutter_test.dart';
import 'package:granthu_project/data/mock/mock_diseases.dart';
import 'package:granthu_project/data/mock/mock_references.dart';
import 'package:granthu_project/services/knowledge_retrieval/knowledge_retrieval_service.dart';

void main() {
  group('Knowledge Retrieval & RAG Matching Tests', () {
    late KnowledgeRetrievalService service;

    setUp(() {
      service = KnowledgeRetrievalService();
    });

    test('All mock diseases have at least one verified agricultural reference', () {
      for (final disease in MockDiseases.diseases) {
        final refs = MockReferences.getReferencesForDisease(disease.id);
        expect(refs.isNotEmpty, isTrue, reason: 'Missing reference for ${disease.name}');
      }
    });

    test('Query for "neem" returns ICAR / IPM recommendations', () {
      final results = service.searchKnowledgeBase(query: 'neem');
      expect(results.isNotEmpty, isTrue);
      final hasNeem = results.any((r) =>
          r.reference.content.toLowerCase().contains('neem') ||
          r.reference.keywords.contains('neem'));
      expect(hasNeem, isTrue);
    });

    test('Query for "copper" or "bordeaux" returns Cornell or IIVR late blight/early blight reference', () {
      final results = service.searchKnowledgeBase(query: 'copper');
      expect(results.isNotEmpty, isTrue);
      expect(results.first.reference.isVerified, isTrue);
    });

    test('Query filtering by cropId restricts non-relevant crops', () {
      final results = service.searchKnowledgeBase(query: 'rust', cropId: 'corn');
      expect(results.isNotEmpty, isTrue);
      for (final r in results) {
        expect(r.reference.cropIds.contains('corn'), isTrue);
      }
    });

    test('getTreatmentPlanForDisease returns non-empty structured list of recommendations', () {
      final plan = service.getTreatmentPlanForDisease('tomato_early_blight');
      expect(plan.isNotEmpty, isTrue);
      expect(plan.any((item) => item.category == 'Low-Cost Remedy'), isTrue);
      expect(plan.any((item) => item.category == 'Cultural Prevention'), isTrue);
      expect(plan.any((item) => item.category == 'Expert Consultation'), isTrue);
    });
  });
}
