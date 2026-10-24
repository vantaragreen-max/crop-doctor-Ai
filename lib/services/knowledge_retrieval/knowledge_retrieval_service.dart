import '../../data/mock/mock_diseases.dart';
import '../../data/mock/mock_references.dart';
import '../../models/agricultural_reference.dart';
import '../../models/treatment_recommendation.dart';

class RagSearchResult {
  final AgriculturalReference reference;
  final double relevanceScore;
  final String matchedExcerpt;

  const RagSearchResult({
    required this.reference,
    required this.relevanceScore,
    required this.matchedExcerpt,
  });
}

class KnowledgeRetrievalService {
  /// Retrieves structured treatment recommendations for a given disease ID
  List<TreatmentRecommendation> getTreatmentPlanForDisease(String diseaseId) {
    final disease = MockDiseases.getById(diseaseId);
    final refs = MockReferences.getReferencesForDisease(diseaseId);
    final primaryOrg = refs.isNotEmpty ? refs.first.organization : 'ICAR / KVK Advisory';

    final recommendations = <TreatmentRecommendation>[];

    // 1. Immediate Actions
    for (int i = 0; i < disease.lowCostRemedies.length; i++) {
      recommendations.add(
        TreatmentRecommendation(
          id: 'imm_${disease.id}_$i',
          title: 'Low-Cost Organic Remedy #${i + 1}',
          description: disease.lowCostRemedies[i],
          category: 'Low-Cost Remedy',
          sourceOrganization: primaryOrg,
          safetyNotes: 'Wear cloth mask and gloves when spraying. Spray in early morning or late evening.',
        ),
      );
    }

    // 2. Cultural Prevention
    for (int i = 0; i < disease.culturalPractices.length; i++) {
      recommendations.add(
        TreatmentRecommendation(
          id: 'cul_${disease.id}_$i',
          title: 'Agronomic Prevention Practice #${i + 1}',
          description: disease.culturalPractices[i],
          category: 'Cultural Prevention',
          sourceOrganization: 'FAO IPM & State Agricultural Universities',
          safetyNotes: 'Do not handle crops when leaves are wet to avoid pathogen spread.',
        ),
      );
    }

    // 3. Extension Protocol
    if (disease.extensionProtocol.isNotEmpty) {
      recommendations.add(
        TreatmentRecommendation(
          id: 'ext_${disease.id}',
          title: 'Extension Protocol & Community Notification',
          description: disease.extensionProtocol,
          category: 'Expert Consultation',
          sourceOrganization: 'Krishi Vigyan Kendra (KVK)',
          safetyNotes: 'Consult extension officer before purchasing high-potency chemical formulations.',
        ),
      );
    }

    return recommendations;
  }

  /// Transparent keyword and semantic-like document retrieval over local knowledge base
  List<RagSearchResult> searchKnowledgeBase({
    required String query,
    String? cropId,
    String? diseaseId,
  }) {
    final q = query.toLowerCase().trim();
    final results = <RagSearchResult>[];

    for (final ref in MockReferences.references) {
      double score = 0.0;

      // Crop match
      if (cropId != null && ref.cropIds.contains(cropId.toLowerCase())) {
        score += 35.0;
      }

      // Disease match
      if (diseaseId != null && ref.diseaseIds.contains(diseaseId.toLowerCase())) {
        score += 45.0;
      }

      // Keyword match
      if (q.isNotEmpty) {
        final queryTerms = q.split(RegExp(r'\s+'));
        for (final term in queryTerms) {
          if (term.length < 3) continue;
          if (ref.keywords.any((k) => k.toLowerCase().contains(term))) {
            score += 20.0;
          }
          if (ref.title.toLowerCase().contains(term)) {
            score += 25.0;
          }
          if (ref.content.toLowerCase().contains(term)) {
            score += 15.0;
          }
        }
      }

      if (score > 10.0 || q.isEmpty) {
        results.add(
          RagSearchResult(
            reference: ref,
            relevanceScore: score.clamp(30.0, 99.0),
            matchedExcerpt: ref.content,
          ),
        );
      }
    }

    results.sort((a, b) => b.relevanceScore.compareTo(a.relevanceScore));
    return results;
  }
}
