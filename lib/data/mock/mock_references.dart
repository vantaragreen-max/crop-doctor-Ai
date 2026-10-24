import '../../models/agricultural_reference.dart';

class MockReferences {
  static const List<AgriculturalReference> references = [
    AgriculturalReference(
      id: 'ref_icar_iivr_eb',
      title: 'Integrated Pest & Disease Management in Solanaceous Crops',
      organization: 'ICAR - Indian Institute of Vegetable Research (IIVR)',
      sourceUrl: 'https://iivr.icar.gov.in/extension-bulletins',
      cropIds: ['tomato'],
      diseaseIds: ['tomato_early_blight', 'tomato_bacterial_spot'],
      content:
          'Early blight caused by Alternaria solani manifests as concentric target-board rings on older foliage. '
          'Recommended cultural controls include 3-year crop rotation with non-solanaceous crops, bottom-canopy pruning '
          'to 30 cm height, and organic foliar bio-fungicides such as Neem Seed Kernel Extract (NSKE 5%) or Trichoderma viride.',
      keywords: ['alternaria', 'target spot', 'concentric rings', 'neem', 'nske', 'pruning', 'icar', 'baking soda'],
      isVerified: true,
      publicationDate: '2023',
    ),
    AgriculturalReference(
      id: 'ref_cornell_lb',
      title: 'Managing Late Blight in Organically and Conventionally Produced Tomatoes and Potatoes',
      organization: 'Cornell University Cooperative Extension',
      sourceUrl: 'https://cals.cornell.edu/late-blight-management',
      cropIds: ['tomato', 'potato'],
      diseaseIds: ['tomato_late_blight', 'potato_late_blight'],
      content:
          'Phytophthora infestans is an aggressive oomycete requiring relative humidity > 90% and moderate temperatures. '
          'Spores travel several kilometers on wind. Rogueing and destroying early infected volunteer plants is paramount. '
          'Preventative copper oxychloride applications before extended rainfall arrest sporangia germination.',
      keywords: ['phytophthora', 'late blight', 'water-soaked', 'copper', 'bordeaux', 'cornell', 'humidity', 'rogueing'],
      isVerified: true,
      publicationDate: '2022',
    ),
    AgriculturalReference(
      id: 'ref_icar_cpri_potato',
      title: 'Handbook of Potato Diseases and Integrated Management Protocols',
      organization: 'ICAR - Central Potato Research Institute (CPRI), Shimla',
      sourceUrl: 'https://cpri.icar.gov.in/technical-bulletins',
      cropIds: ['potato'],
      diseaseIds: ['potato_early_blight', 'potato_late_blight'],
      content:
          'CPRI advisory recommends high soil hilling (earthing up) to protect tuber eyes from zoospore wash-down. '
          'De-haulming (cutting vines) 10-14 days before harvest hardens tuber skins and breaks the infection chain. '
          'Certified disease-free seed tubers (e.g., Kufri Girdhari, Kufri Khyati) should be prioritized.',
      keywords: ['potato', 'de-haulming', 'hilling', 'cpri', 'kufri', 'tubers', 'earthing up', 'seed certification'],
      isVerified: true,
      publicationDate: '2024',
    ),
    AgriculturalReference(
      id: 'ref_cimmyt_maize_rust',
      title: 'Field Guide to Maize Diseases and Pest Diagnostics in Sub-Saharan Africa and Asia',
      organization: 'CIMMYT (International Maize & Wheat Improvement Center)',
      sourceUrl: 'https://repository.cimmyt.org/handle/10883/20120',
      cropIds: ['corn'],
      diseaseIds: ['corn_common_rust'],
      content:
          'Common rust (Puccinia sorghi) produces oval, golden-brown to cinnamon pustules on both upper and lower leaf surfaces. '
          'Yield impact is most severe when infection occurs prior to tassel emergence. Cultural prevention includes planting '
          'resistant hybrid varieties and eliminating alternate weed hosts (Oxalis species). Wettable sulfur sprays provide safe early protection.',
      keywords: ['cimmyt', 'maize', 'rust', 'puccinia', 'pustules', 'sulfur', 'tasseling', 'oxalis'],
      isVerified: true,
      publicationDate: '2023',
    ),
    AgriculturalReference(
      id: 'ref_purdue_corn_nlb',
      title: 'Northern Corn Leaf Blight Management in Field Corn',
      organization: 'Purdue University Extension - Department of Botany and Plant Pathology',
      sourceUrl: 'https://extension.purdue.edu/field-crops/diseases/northern-corn-leaf-blight',
      cropIds: ['corn'],
      diseaseIds: ['corn_northern_leaf_blight'],
      content:
          'Exserohilum turcicum overwinters in corn residue and produces long, elliptical cigar-shaped grayish lesions. '
          'Deep tillage post-harvest buries residue to accelerate pathogen breakdown. Balanced fertilization avoiding nitrogen '
          'overload reduces foliar susceptibility. Crop rotation with legumes (soybean, cowpea) interrupts pathogen persistence.',
      keywords: ['purdue', 'northern corn leaf blight', 'cigar lesion', 'exserohilum', 'crop rotation', 'tillage'],
      isVerified: true,
      publicationDate: '2023',
    ),
    AgriculturalReference(
      id: 'ref_fao_gap_general',
      title: 'FAO Guidelines on Good Agricultural Practices (GAP) for Smallholders',
      organization: 'Food and Agriculture Organization (FAO) of the United Nations',
      sourceUrl: 'https://www.fao.org/good-agricultural-practices',
      cropIds: ['tomato', 'potato', 'corn'],
      diseaseIds: ['tomato_healthy', 'potato_healthy', 'corn_healthy'],
      content:
          'Healthy plant tissue maintenance requires proactive soil organic matter enrichment, drip irrigation scheduling, '
          'routine bi-weekly field scouting, and clean border management. Beneficial mycorrhizae and balanced micronutrients '
          'bolster natural plant phytoalexin defense mechanisms against opportunistic pathogens.',
      keywords: ['fao', 'gap', 'healthy', 'scouting', 'soil health', 'drip irrigation', 'prevention', 'organic'],
      isVerified: true,
      publicationDate: '2022',
    ),
    AgriculturalReference(
      id: 'ref_tnau_bacterial_spot',
      title: 'Crop Protection Compendium: Bacterial Spot Management in Solanaceous Crops',
      organization: 'Tamil Nadu Agricultural University (TNAU) Agritech Portal',
      sourceUrl: 'https://agritech.tnau.ac.in/crop_protection/tomato_diseases',
      cropIds: ['tomato'],
      diseaseIds: ['tomato_bacterial_spot'],
      content:
          'Xanthomonas perforans creates small water-soaked dark spots with distinctive yellow halos. '
          'Bacteria spread via overhead splash, contaminated pruning shears, and working wet foliage. '
          'Soaking seeds in hot water (50°C for 25 minutes) eliminates seed-borne inoculum. Copper hydroxide foliar sprays protect uninfected foliage.',
      keywords: ['tnau', 'bacterial spot', 'xanthomonas', 'halo', 'seed treatment', 'sanitation', 'copper'],
      isVerified: true,
      publicationDate: '2023',
    ),
  ];

  static List<AgriculturalReference> getReferencesForDisease(String diseaseId) {
    return references
        .where((r) => r.diseaseIds.contains(diseaseId))
        .toList();
  }

  static List<AgriculturalReference> search(String query, {String? cropId}) {
    final q = query.toLowerCase().trim();
    if (q.isEmpty) return references;

    return references.where((r) {
      if (cropId != null && !r.cropIds.contains(cropId.toLowerCase())) {
        return false;
      }
      final matchesTitle = r.title.toLowerCase().contains(q);
      final matchesContent = r.content.toLowerCase().contains(q);
      final matchesOrg = r.organization.toLowerCase().contains(q);
      final matchesKeyword = r.keywords.any((k) => k.toLowerCase().contains(q));
      return matchesTitle || matchesContent || matchesOrg || matchesKeyword;
    }).toList();
  }
}
