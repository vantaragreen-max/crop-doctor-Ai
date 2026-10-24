class TreatmentRecommendation {
  final String id;
  final String title;
  final String description;
  final String category; // 'Immediate Management', 'Low-Cost Organic Remedy', 'Cultural Prevention', 'Precautions'
  final String sourceOrganization;
  final String safetyNotes;

  const TreatmentRecommendation({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.sourceOrganization,
    required this.safetyNotes,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'sourceOrganization': sourceOrganization,
        'safetyNotes': safetyNotes,
      };

  factory TreatmentRecommendation.fromJson(Map<String, dynamic> json) =>
      TreatmentRecommendation(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String,
        category: json['category'] as String,
        sourceOrganization: json['sourceOrganization'] as String,
        safetyNotes: json['safetyNotes'] as String? ?? '',
      );
}
