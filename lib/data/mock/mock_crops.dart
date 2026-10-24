import '../../models/crop.dart';

class MockCrops {
  static const List<Crop> crops = [
    Crop(
      id: 'tomato',
      name: 'Tomato',
      scientificName: 'Solanum lycopersicum',
      description: 'Solanaceous fruiting vegetable highly vulnerable to blights, wilts, and leaf mold in humid climates.',
      iconEmoji: '🍅',
      commonDiseasesCount: 'Early Blight, Late Blight, Bacterial Spot',
    ),
    Crop(
      id: 'potato',
      name: 'Potato',
      scientificName: 'Solanum tuberosum',
      description: 'Starchy tuber crop susceptible to aggressive Phytophthora late blight and soil-borne pathogens.',
      iconEmoji: '🥔',
      commonDiseasesCount: 'Early Blight, Late Blight',
    ),
    Crop(
      id: 'corn',
      name: 'Corn (Maize)',
      scientificName: 'Zea mays',
      description: 'Major cereal grain crop prone to foliar rusts and blights impacting photosynthesizing leaf area.',
      iconEmoji: '🌽',
      commonDiseasesCount: 'Common Rust, Northern Leaf Blight',
    ),
  ];

  static Crop getById(String id) {
    return crops.firstWhere(
      (c) => c.id.toLowerCase() == id.toLowerCase(),
      orElse: () => crops.first,
    );
  }
}
