class AgriculturalReference {
  final String id;
  final String title;
  final String organization;
  final String sourceUrl;
  final List<String> cropIds;
  final List<String> diseaseIds;
  final String content;
  final List<String> keywords;
  final bool isVerified;
  final String publicationDate;

  const AgriculturalReference({
    required this.id,
    required this.title,
    required this.organization,
    required this.sourceUrl,
    required this.cropIds,
    required this.diseaseIds,
    required this.content,
    required this.keywords,
    this.isVerified = true,
    required this.publicationDate,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'organization': organization,
        'sourceUrl': sourceUrl,
        'cropIds': cropIds,
        'diseaseIds': diseaseIds,
        'content': content,
        'keywords': keywords,
        'isVerified': isVerified,
        'publicationDate': publicationDate,
      };

  factory AgriculturalReference.fromJson(Map<String, dynamic> json) =>
      AgriculturalReference(
        id: json['id'] as String,
        title: json['title'] as String,
        organization: json['organization'] as String,
        sourceUrl: json['sourceUrl'] as String,
        cropIds: List<String>.from(json['cropIds'] as List),
        diseaseIds: List<String>.from(json['diseaseIds'] as List),
        content: json['content'] as String,
        keywords: List<String>.from(json['keywords'] as List),
        isVerified: json['isVerified'] as bool? ?? true,
        publicationDate: json['publicationDate'] as String? ?? '2023',
      );
}
