import 'lesion_box.dart';

class DiagnosisResult {
  final String id;
  final String cropId;
  final String cropName;
  final String diseaseId;
  final String diseaseName;
  final String scientificName;
  final double confidence; // e.g. 92.4%
  final String severityTier; // 'Mild', 'Moderate', 'Severe', 'Healthy'
  final double foliarDamagePct;
  final DateTime analyzedAt;
  final String? imagePath;
  final String? sampleKey;
  final List<LesionBox> lesions;
  final String inferenceMode;
  final bool isDemo;
  final String disclaimer;
  final bool isLowConfidence;
  final bool isSaved;
  final String overview;
  final String favorableConditions;
  final List<String> symptoms;
  final List<String> possibleCauses;
  final List<String> immediateRemedies;
  final List<String> culturalPrevention;
  final String extensionProtocol;
  final String primarySource;

  const DiagnosisResult({
    required this.id,
    required this.cropId,
    required this.cropName,
    required this.diseaseId,
    required this.diseaseName,
    required this.scientificName,
    required this.confidence,
    required this.severityTier,
    required this.foliarDamagePct,
    required this.analyzedAt,
    this.imagePath,
    this.sampleKey,
    required this.lesions,
    this.inferenceMode = 'Demo Simulation (Deterministic)',
    this.isDemo = true,
    required this.disclaimer,
    required this.isLowConfidence,
    this.isSaved = false,
    required this.overview,
    required this.favorableConditions,
    required this.symptoms,
    required this.possibleCauses,
    required this.immediateRemedies,
    required this.culturalPrevention,
    required this.extensionProtocol,
    required this.primarySource,
  });

  DiagnosisResult copyWith({
    String? id,
    String? cropId,
    String? cropName,
    String? diseaseId,
    String? diseaseName,
    String? scientificName,
    double? confidence,
    String? severityTier,
    double? foliarDamagePct,
    DateTime? analyzedAt,
    String? imagePath,
    String? sampleKey,
    List<LesionBox>? lesions,
    String? inferenceMode,
    bool? isDemo,
    String? disclaimer,
    bool? isLowConfidence,
    bool? isSaved,
    String? overview,
    String? favorableConditions,
    List<String>? symptoms,
    List<String>? possibleCauses,
    List<String>? immediateRemedies,
    List<String>? culturalPrevention,
    String? extensionProtocol,
    String? primarySource,
  }) {
    return DiagnosisResult(
      id: id ?? this.id,
      cropId: cropId ?? this.cropId,
      cropName: cropName ?? this.cropName,
      diseaseId: diseaseId ?? this.diseaseId,
      diseaseName: diseaseName ?? this.diseaseName,
      scientificName: scientificName ?? this.scientificName,
      confidence: confidence ?? this.confidence,
      severityTier: severityTier ?? this.severityTier,
      foliarDamagePct: foliarDamagePct ?? this.foliarDamagePct,
      analyzedAt: analyzedAt ?? this.analyzedAt,
      imagePath: imagePath ?? this.imagePath,
      sampleKey: sampleKey ?? this.sampleKey,
      lesions: lesions ?? this.lesions,
      inferenceMode: inferenceMode ?? this.inferenceMode,
      isDemo: isDemo ?? this.isDemo,
      disclaimer: disclaimer ?? this.disclaimer,
      isLowConfidence: isLowConfidence ?? this.isLowConfidence,
      isSaved: isSaved ?? this.isSaved,
      overview: overview ?? this.overview,
      favorableConditions: favorableConditions ?? this.favorableConditions,
      symptoms: symptoms ?? this.symptoms,
      possibleCauses: possibleCauses ?? this.possibleCauses,
      immediateRemedies: immediateRemedies ?? this.immediateRemedies,
      culturalPrevention: culturalPrevention ?? this.culturalPrevention,
      extensionProtocol: extensionProtocol ?? this.extensionProtocol,
      primarySource: primarySource ?? this.primarySource,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'cropId': cropId,
        'cropName': cropName,
        'diseaseId': diseaseId,
        'diseaseName': diseaseName,
        'scientificName': scientificName,
        'confidence': confidence,
        'severityTier': severityTier,
        'foliarDamagePct': foliarDamagePct,
        'analyzedAt': analyzedAt.toIso8601String(),
        'imagePath': imagePath,
        'sampleKey': sampleKey,
        'lesions': lesions.map((l) => l.toJson()).toList(),
        'inferenceMode': inferenceMode,
        'isDemo': isDemo,
        'disclaimer': disclaimer,
        'isLowConfidence': isLowConfidence,
        'isSaved': isSaved,
        'overview': overview,
        'favorableConditions': favorableConditions,
        'symptoms': symptoms,
        'possibleCauses': possibleCauses,
        'immediateRemedies': immediateRemedies,
        'culturalPrevention': culturalPrevention,
        'extensionProtocol': extensionProtocol,
        'primarySource': primarySource,
      };

  factory DiagnosisResult.fromJson(Map<String, dynamic> json) => DiagnosisResult(
        id: json['id'] as String,
        cropId: json['cropId'] as String,
        cropName: json['cropName'] as String,
        diseaseId: json['diseaseId'] as String,
        diseaseName: json['diseaseName'] as String,
        scientificName: json['scientificName'] as String,
        confidence: (json['confidence'] as num).toDouble(),
        severityTier: json['severityTier'] as String? ?? 'Moderate',
        foliarDamagePct: (json['foliarDamagePct'] as num).toDouble(),
        analyzedAt: DateTime.parse(json['analyzedAt'] as String),
        imagePath: json['imagePath'] as String?,
        sampleKey: json['sampleKey'] as String?,
        lesions: (json['lesions'] as List<dynamic>?)
                ?.map((l) => LesionBox.fromJson(l as Map<String, dynamic>))
                .toList() ??
            [],
        inferenceMode: json['inferenceMode'] as String? ?? 'Demo Simulation',
        isDemo: json['isDemo'] as bool? ?? true,
        disclaimer: json['disclaimer'] as String? ?? '',
        isLowConfidence: json['isLowConfidence'] as bool? ?? false,
        isSaved: json['isSaved'] as bool? ?? false,
        overview: json['overview'] as String? ?? '',
        favorableConditions: json['favorableConditions'] as String? ?? '',
        symptoms: List<String>.from(json['symptoms'] as List? ?? []),
        possibleCauses: List<String>.from(json['possibleCauses'] as List? ?? []),
        immediateRemedies:
            List<String>.from(json['immediateRemedies'] as List? ?? []),
        culturalPrevention:
            List<String>.from(json['culturalPrevention'] as List? ?? []),
        extensionProtocol: json['extensionProtocol'] as String? ?? '',
        primarySource: json['primarySource'] as String? ?? '',
      );
}
