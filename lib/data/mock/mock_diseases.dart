import '../../models/disease.dart';

class MockDiseases {
  static const List<Disease> diseases = [
    // Tomato Diseases
    Disease(
      id: 'tomato_early_blight',
      cropId: 'tomato',
      name: 'Tomato Early Blight',
      scientificName: 'Alternaria solani',
      pathogenType: 'Fungus',
      overview:
          'A pervasive fungal disease characterized by brown-to-black necrotic lesions exhibiting concentric rings resembling a target board, predominantly affecting older lower foliage.',
      symptoms: [
        'Dark brown circular to angular spots on older, lower leaves',
        'Distinct concentric target-board ring pattern within lesions',
        'Surrounding chlorotic yellow halos around expanding spots',
        'Premature foliar defoliation exposing developing fruit to sunscald',
      ],
      possibleCauses: [
        'Alternaria solani fungal spores overwintering in crop debris',
        'Soil splashing onto lower leaves during rainfall or overhead watering',
        'Stressed plants suffering from nitrogen deficiency or heavy fruit loads',
      ],
      favorableConditions:
          'Warm temperatures (24–29°C), high relative humidity (>80%), frequent rainfall, and continuous leaf wetness duration exceeding 6–8 hours.',
      prevention: [
        'Prune lower 30 cm canopy foliage to prevent soil splash inoculations',
        'Apply clean straw or plastic mulch around the base of plants',
        'Enforce 2–3 year crop rotation away from solanaceous species',
        'Switch strictly from overhead sprinklers to ground drip irrigation',
      ],
      culturalPractices: [
        'Stake and trellis vines to optimize intra-canopy airflow',
        'Scout weekly and immediately prune early infected leaflets into sealed disposal bags',
        'Maintain balanced fertilization; avoid both nitrogen depletion and excess softness',
      ],
      lowCostRemedies: [
        'Neem Seed Kernel Extract (NSKE 5%): 50g crushed seeds soaked per liter water + mild organic soap surfactant, sprayed every 7–10 days.',
        'Baking Soda Foliar Wash: 1 tablespoon (15g) sodium bicarbonate + 1 teaspoon mild soap in 4 liters clean water to elevate leaf surface pH.',
        'Bordeaux Mixture (1%): 100g copper sulfate + 100g slaked lime in 10 liters clean water as a protective foliar barrier.',
        'Trichoderma harzianum bio-agent: 5g per liter foliar spray to outcompete Alternaria spore germination sites.',
      ],
      extensionProtocol:
          'If lesions advance past mid-canopy within 5 consecutive days despite organic washes, collect 3 fresh leaves in a dry paper envelope and submit to your nearest Krishi Vigyan Kendra (KVK) or District Agricultural Office.',
      referenceIds: ['ref_icar_iivr_eb', 'ref_fao_gap_general'],
      sampleSeverity: 'Moderate',
      isHealthy: false,
    ),
    Disease(
      id: 'tomato_late_blight',
      cropId: 'tomato',
      name: 'Tomato Late Blight',
      scientificName: 'Phytophthora infestans',
      pathogenType: 'Oomycete',
      overview:
          'A devastating water-mold disease capable of destroying entire canopies and fruit clusters within days during cool, humid periods.',
      symptoms: [
        'Large, irregular water-soaked pale-green lesions that rapidly turn dark brown or purplish-black',
        'Delicate white fungal-like sporulation on the underside of leaves during humid mornings',
        'Dark brown sunken lesions girdling leaf petioles and stems',
        'Greasy brown firm rot developing on green and ripening tomato fruit',
      ],
      possibleCauses: [
        'Airborne sporangia carried over long distances by wind currents',
        'Infected potato volunteer plants or contaminated greenhouse seedlings',
        'Free moisture persisting on leaves for more than 10 hours',
      ],
      favorableConditions:
          'Cool, damp weather with temperatures between 15–22°C and sustained relative humidity above 90%.',
      prevention: [
        'Plant certified disease-free transplants and resistant cultivars when available',
        'Ensure wide plant spacing (75–90 cm) for fast morning dew evaporation',
        'Never plant tomatoes adjacent to potato fields',
      ],
      culturalPractices: [
        'Immediate rogueing: Cut, bag, and bury infected plants; do not compost infected material',
        'Irrigate early in the morning so sun dries canopy leaves quickly',
      ],
      lowCostRemedies: [
        'Copper Oxychloride (COC 50% WP): 2.5g/L preventative barrier before forecasted rain events.',
        'Fresh Milk/Whey Solution: 1 part cow milk to 9 parts water; creates a natural antiseptic biofilm.',
        'Dry Wood Ash Dusting: Sifted hardwood ash dusted around lower plant bases to discourage damp microclimates.',
      ],
      extensionProtocol:
          'Late Blight is an aggressive community-level epidemic. Alert your local Block Agriculture Extension Officer immediately so neighboring growers can be notified.',
      referenceIds: ['ref_cornell_lb'],
      sampleSeverity: 'Severe',
      isHealthy: false,
    ),
    Disease(
      id: 'tomato_bacterial_spot',
      cropId: 'tomato',
      name: 'Tomato Bacterial Spot',
      scientificName: 'Xanthomonas perforans',
      pathogenType: 'Bacteria',
      overview:
          'A widespread bacterial foliage and fruit disease causing small dark necrotic lesions with yellow halos, leading to extensive leaf drop in rainy tropical seasons.',
      symptoms: [
        'Small (2–3 mm), dark brown to black circular lesions on leaves',
        'Noticeable translucent yellow chlorotic halo encircling spots',
        'Leaf edges appear scorched and curled inward',
        'Rough, raised scab-like dark spots on unripe green fruit',
      ],
      possibleCauses: [
        'Contaminated seed stocks or infected seedbed soil',
        'Splash dispersal from driving rainfall or overhead irrigation',
        'Field workers moving through wet fields spreading bacterial ooze',
      ],
      favorableConditions:
          'Warm, humid tropical conditions (25–30°C) with frequent thunderstorms and splashing raindrops.',
      prevention: [
        'Hot-water seed sanitation: Soak tomato seeds in 50°C water for 25 minutes prior to planting',
        'Disinfect all pruning shears with 70% alcohol or 10% bleach between plants',
        'Strictly avoid handling or pruning tomato plants while foliage is wet with dew',
      ],
      culturalPractices: [
        'Utilize raised beds and organic mulch to restrict ground splash back',
        'Remove solanaceous weeds (black nightshade) harboring Xanthomonas bacteria',
      ],
      lowCostRemedies: [
        'Copper Hydroxide or Copper Oxychloride: 2.0g/L spray applied as a preventative protectant.',
        'Pseudomonas fluorescens bio-formulation: 5g/L foliar spray to colonize leaf phyllosphere.',
        'Fermented butter milk foliar spray (sour curd diluted 1:10) for mild natural acidity.',
      ],
      extensionProtocol:
          'Submit symptomatic leaves if fruit lesions develop scab-like cracking. Request seed lot testing support from local KVK.',
      referenceIds: ['ref_tnau_bacterial_spot'],
      sampleSeverity: 'Moderate',
      isHealthy: false,
    ),
    Disease(
      id: 'tomato_healthy',
      cropId: 'tomato',
      name: 'Tomato Healthy Foliage',
      scientificName: 'Solanum lycopersicum (Vigorous)',
      pathogenType: 'None (Healthy)',
      overview:
          'Uniform green leaf blades with robust turgidity, well-defined venation, and no visible necrotic lesions or chlorosis.',
      symptoms: [
        'Vibrant emerald green leaf coloration across all leaf tiers',
        'Intact leaf margins free from necrosis, curling, or spotting',
        'Stout stems and regular, vigorous flowering nodes',
      ],
      possibleCauses: [
        'Optimal soil biological activity, proper N-P-K nutrient balance, and clean irrigation water',
      ],
      favorableConditions:
          'Balanced sunlight (6–8 hours/day), well-drained loam soil with pH 6.0–6.8, and moderate humidity.',
      prevention: [
        'Maintain routine bi-weekly field scouting routines',
        'Apply composted manure and vermicompost to preserve root microbiome vigor',
      ],
      culturalPractices: [
        'Continue regular drip watering schedules and keep field borders weed-free',
        'Avoid over-application of synthetic nitrogen which causes overly succulent leaves',
      ],
      lowCostRemedies: [
        'Seaweed extract or Panchagavya: 3% foliar spray every 15 days as natural tonic.',
        'No chemical fungicides or bactericides required.',
      ],
      extensionProtocol:
          'No intervention necessary. Maintain standard good agricultural scouting records.',
      referenceIds: ['ref_fao_gap_general'],
      sampleSeverity: 'Healthy',
      isHealthy: true,
    ),

    // Potato Diseases
    Disease(
      id: 'potato_early_blight',
      cropId: 'potato',
      name: 'Potato Early Blight',
      scientificName: 'Alternaria solani',
      pathogenType: 'Fungus',
      overview:
          'Fungal foliar disease causing brown angular target-patterned lesions on mature potato canopies, reducing photosynthesis during tuber bulking.',
      symptoms: [
        'Small dark spots on lower leaves that enlarge into characteristic concentric rings',
        'Chlorotic yellowing around lesions with progressive leaf drying',
        'Lesions restricted by larger leaf veins, giving angular appearance',
      ],
      possibleCauses: [
        'Infected potato crop residues from prior seasons',
        'Alternating wet and dry weather cycles stressing the canopy',
      ],
      favorableConditions:
          'Moderate to warm temperatures (20–28°C) accompanied by heavy dew mornings followed by sunny dry afternoons.',
      prevention: [
        'Use certified disease-free seed tubers',
        'Rotate fields with non-host crops like maize, sorghum, or legumes for 3 years',
      ],
      culturalPractices: [
        'Maintain balanced nitrogen and potassium fertility; deficient plants succumb rapidly',
        'Avoid damaging potato foliage during intercultural operations',
      ],
      lowCostRemedies: [
        'Mancozeb 75% WP or Copper Oxychloride: 2.5g/L foliar spray at initial onset.',
        'Neem Seed Kernel Extract (5%): Bi-weekly application as an organic deterrent.',
      ],
      extensionProtocol:
          'Consult KVK extension specialist if early blight appears prior to tuber initiation.',
      referenceIds: ['ref_icar_cpri_potato'],
      sampleSeverity: 'Moderate',
      isHealthy: false,
    ),
    Disease(
      id: 'potato_late_blight',
      cropId: 'potato',
      name: 'Potato Late Blight',
      scientificName: 'Phytophthora infestans',
      pathogenType: 'Oomycete',
      overview:
          'The historical Irish potato famine pathogen; attacks stems, foliage, and tubers with rapid rot and complete field desiccation.',
      symptoms: [
        'Water-soaked dark lesions at leaf tips and margins spreading rapidly across leaflets',
        'White cottony fungal growth on lower leaf surfaces under high morning humidity',
        'Blackened, collapsed stems and decaying foul-smelling foliage in advanced stages',
        'Reddish-brown granular dry rot under the skin of harvested tubers',
      ],
      possibleCauses: [
        'Latent Phytophthora mycelium in seed tubers or infected cull piles',
        'Long-range atmospheric transport of sporangia during monsoon fronts',
      ],
      favorableConditions:
          'Cool temperatures (10–20°C), relative humidity > 90%, and persistent drizzle or heavy fog.',
      prevention: [
        'Plant resistant varieties recommended by ICAR-CPRI (e.g., Kufri Girdhari, Kufri Khyati)',
        'Earthing up: Build tall, broad soil ridges around plants to shield tubers from washed spores',
        'De-haulming: Cut and remove potato haulms (vines) 10–14 days before tuber harvest',
      ],
      culturalPractices: [
        'Scout low-lying or shaded corners of the field where dew persists longest',
        'Never dispose of rotten potatoes near active fields or irrigation canals',
      ],
      lowCostRemedies: [
        'Copper Oxychloride 50% WP (2.5–3.0g/L) as a prophylactic spray prior to fog/rain.',
        'Fermented Panchagavya (cow dung, urine, milk, curd, ghee mixture) foliar wash (10%).',
      ],
      extensionProtocol:
          'Immediately report late blight outbreaks to your district agriculture office to activate regional early warning forecasts.',
      referenceIds: ['ref_icar_cpri_potato', 'ref_cornell_lb'],
      sampleSeverity: 'Severe',
      isHealthy: false,
    ),
    Disease(
      id: 'potato_healthy',
      cropId: 'potato',
      name: 'Potato Healthy Foliage',
      scientificName: 'Solanum tuberosum (Vigorous)',
      pathogenType: 'None (Healthy)',
      overview:
          'Lush, deep green potato compound leaves with smooth margins, turgid stems, and intact photosynthetic lamina.',
      symptoms: [
        'Uniform deep-green compound leaves without spots or necrotic margins',
        'Erect, sturdy canopy structure with uniform flowering and stem strength',
      ],
      possibleCauses: [
        'Certified disease-free seed, balanced soil nutrition, and optimal drainage ridges',
      ],
      favorableConditions:
          'Cool nights (15–18°C), mild sunny days (20–24°C), and well-aerated sandy loam soil.',
      prevention: [
        'Continue regular field ridging and earthing up to protect developing tubers',
      ],
      culturalPractices: [
        'Scout weekly under the lower canopy for any sudden microclimate moisture buildup',
      ],
      lowCostRemedies: [
        'Routine foliar micronutrient spray (Zinc + Boron) during tuber expansion.',
      ],
      extensionProtocol:
          'No chemical treatment needed. Continue good agricultural management.',
      referenceIds: ['ref_icar_cpri_potato', 'ref_fao_gap_general'],
      sampleSeverity: 'Healthy',
      isHealthy: true,
    ),

    // Corn Diseases
    Disease(
      id: 'corn_common_rust',
      cropId: 'corn',
      name: 'Corn Common Rust',
      scientificName: 'Puccinia sorghi',
      pathogenType: 'Fungus',
      overview:
          'A fungal foliar rust producing circular to elongate golden-brown to cinnamon-brown powdery pustules on both upper and lower corn leaf surfaces.',
      symptoms: [
        'Small, round to oval cinnamon-brown pustules (uredinia) scattered across the leaf',
        'Pustules rupture the leaf epidermis to release powdery reddish-brown spores',
        'Pustules turn brownish-black late in the season as dark teliospores form',
        'Extensive pustule coalescence causes leaf chlorosis and premature leaf death',
      ],
      possibleCauses: [
        'Urediniospores carried by southerly storm systems and seasonal winds',
        'Overwintering near alternative weed hosts such as wood sorrel (Oxalis)',
      ],
      favorableConditions:
          'Cool to moderate temperatures (16–25°C) combined with high relative humidity (>95%) and 6–8 hours of night dew.',
      prevention: [
        'Plant resistant maize hybrids and open-pollinated varieties with known rust resistance',
        'Adjust planting dates to ensure grain fill completes before peak rust spore arrival',
        'Eradicate wild Oxalis weed patches along field boundaries',
      ],
      culturalPractices: [
        'Avoid overly dense plant stands that trap morning moisture within the leaf whorl',
      ],
      lowCostRemedies: [
        'Wettable Sulfur (80% WP): 2.5–3.0g per liter water; effective and low-cost rust barrier.',
        'Neem Oil (10,000 ppm formulation): 3ml/L emulsified with mild liquid soap.',
        'Target sprays to upper leaves and ear leaf prior to silking.',
      ],
      extensionProtocol:
          'If more than 6 pustules per leaf appear on the three leaves below the ear prior to tasseling, seek extension input for economic threshold assessment.',
      referenceIds: ['ref_cimmyt_maize_rust'],
      sampleSeverity: 'Mild',
      isHealthy: false,
    ),
    Disease(
      id: 'corn_northern_leaf_blight',
      cropId: 'corn',
      name: 'Corn Northern Leaf Blight',
      scientificName: 'Exserohilum turcicum',
      pathogenType: 'Fungus',
      overview:
          'A damaging fungal disease characterized by long, elliptical grayish-green to tan "cigar-shaped" lesions on corn leaves.',
      symptoms: [
        'Distinctive long, elliptical lesions (2.5–15 cm in length) resembling cigars',
        'Lesions initially appear grayish-green and dry to a pale tan or brown hue',
        'Dark olive-green fuzzy fungal sporulation inside lesions during damp weather',
        'Whole leaves turn gray and die when multiple lesions merge across veins',
      ],
      possibleCauses: [
        'Infected corn stubble and crop residue left on the soil surface from previous harvest',
        'Wind and rain splash carrying spores up onto lower leaves during early vegetative stages',
      ],
      favorableConditions:
          'Moderate temperatures (18–27°C) accompanied by extended periods of heavy dew, overcast skies, and high humidity.',
      prevention: [
        'Select maize hybrids with proven Ht gene resistance against Exserohilum races',
        'Crop rotation: Rotate out of corn for at least 1–2 years using soybeans, cowpeas, or sunflowers',
        'Post-harvest deep tillage to bury infected stalk debris and speed decomposition',
      ],
      culturalPractices: [
        'Maintain balanced potassium fertilization; low potassium heightens blight vulnerability',
      ],
      lowCostRemedies: [
        'Mancozeb 75% WP: 2.5g/L foliar spray applied at early whorl emergence.',
        'Aerated compost tea foliar wash to establish beneficial foliar microorganisms.',
      ],
      extensionProtocol:
          'If lesions advance onto the critical ear leaf within 2 weeks before silking, contact your KVK or CIMMYT extension coordinator.',
      referenceIds: ['ref_purdue_corn_nlb'],
      sampleSeverity: 'Moderate',
      isHealthy: false,
    ),
    Disease(
      id: 'corn_healthy',
      cropId: 'corn',
      name: 'Corn Healthy Foliage',
      scientificName: 'Zea mays (Vigorous)',
      pathogenType: 'None (Healthy)',
      overview:
          'Robust, broad monocot corn leaf blades with deep green coloration, clear parallel venation, and clean margins.',
      symptoms: [
        'Vibrant dark green leaf blades without rust pustules or elongated lesions',
        'Strong central midrib and healthy arching leaf habit',
      ],
      possibleCauses: [
        'Adequate soil nitrogen, optimal plant spacing, and clean seedbed preparation',
      ],
      favorableConditions:
          'Warm sunny days (25–32°C), adequate soil moisture during vegetative and silking stages.',
      prevention: [
        'Maintain balanced side-dressing of nitrogen and potassium',
      ],
      culturalPractices: [
        'Scout fields bi-weekly, inspecting both upper and lower canopy leaves',
      ],
      lowCostRemedies: [
        'Bio-fertilizer foliar wash (Azotobacter or Phosphobacteria) to support vegetative growth.',
      ],
      extensionProtocol:
          'Crop is vigorous and healthy. Continue regular irrigation and scouting.',
      referenceIds: ['ref_fao_gap_general'],
      sampleSeverity: 'Healthy',
      isHealthy: true,
    ),
  ];

  static Disease getById(String id) {
    return diseases.firstWhere(
      (d) => d.id.toLowerCase() == id.toLowerCase(),
      orElse: () => diseases.first,
    );
  }

  static List<Disease> getForCrop(String cropId) {
    return diseases
        .where((d) => d.cropId.toLowerCase() == cropId.toLowerCase())
        .toList();
  }
}
