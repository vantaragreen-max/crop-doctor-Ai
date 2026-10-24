class Disease {
  final String id;
  final String cropId;
  final String name;
  final String scientificName;
  final String pathogenType; // 'Fungus', 'Oomycete', 'Bacteria', 'None (Healthy)'
  final String overview;
  final List<String> symptoms;
  final List<String> possibleCauses;
  final String favorableConditions;
  final List<String> prevention;
  final List<String> culturalPractices;
  final List<String> lowCostRemedies;
  final String extensionProtocol;
  final List<String> referenceIds;
  final String sampleSeverity; // 'Mild', 'Moderate', 'Severe', 'Healthy'
  final bool isHealthy;

  const Disease({
    required this.id,
    required this.cropId,
    required this.name,
    required this.scientificName,
    required this.pathogenType,
    required this.overview,
    required this.symptoms,
    required this.possibleCauses,
    required this.favorableConditions,
    required this.prevention,
    required this.culturalPractices,
    required this.lowCostRemedies,
    required this.extensionProtocol,
    required this.referenceIds,
    required this.sampleSeverity,
    this.isHealthy = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'cropId': cropId,
        'name': name,
        'scientificName': scientificName,
        'pathogenType': pathogenType,
        'overview': overview,
        'symptoms': symptoms,
        'possibleCauses': possibleCauses,
        'favorableConditions': favorableConditions,
        'prevention': prevention,
        'culturalPractices': culturalPractices,
        'lowCostRemedies': lowCostRemedies,
        'extensionProtocol': extensionProtocol,
        'referenceIds': referenceIds,
        'sampleSeverity': sampleSeverity,
        'isHealthy': isHealthy,
      };

  factory Disease.fromJson(Map<String, dynamic> json) => Disease(
        id: json['id'] as String,
        cropId: json['cropId'] as String,
        name: json['name'] as String,
        scientificName: json['scientificName'] as String,
        pathogenType: json['pathogenType'] as String,
        overview: json['overview'] as String,
        symptoms: List<String>.from(json['symptoms'] as List),
        possibleCauses: List<String>.from(json['possibleCauses'] as List),
        favorableConditions: json['favorableConditions'] as String,
        prevention: List<String>.from(json['prevention'] as List),
        culturalPractices: List<String>.from(json['culturalPractices'] as List),
        lowCostRemedies: List<String>.from(json['lowCostRemedies'] as List),
        extensionProtocol: json['extensionProtocol'] as String,
        referenceIds: List<String>.from(json['referenceIds'] as List),
        sampleSeverity: json['sampleSeverity'] as String? ?? 'Moderate',
        isHealthy: json['isHealthy'] as bool? ?? false,
      );
}
