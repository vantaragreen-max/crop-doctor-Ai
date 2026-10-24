class Crop {
  final String id;
  final String name;
  final String scientificName;
  final String description;
  final String iconEmoji;
  final String commonDiseasesCount;

  const Crop({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.description,
    required this.iconEmoji,
    required this.commonDiseasesCount,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'scientificName': scientificName,
        'description': description,
        'iconEmoji': iconEmoji,
        'commonDiseasesCount': commonDiseasesCount,
      };

  factory Crop.fromJson(Map<String, dynamic> json) => Crop(
        id: json['id'] as String,
        name: json['name'] as String,
        scientificName: json['scientificName'] as String,
        description: json['description'] as String,
        iconEmoji: json['iconEmoji'] as String? ?? '🌱',
        commonDiseasesCount: json['commonDiseasesCount'] as String? ?? '3+ Diseases',
      );
}
