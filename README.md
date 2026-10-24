# 🌱 Crop Doctor AI
> **"Know Your Crop. Protect Your Harvest."**

A premium, AI-powered agricultural diagnosis and crop health assistance Flutter mobile application prototype designed for smallholder farmers, agricultural extension workers, and agtech investors.

---

## 🌟 Executive Overview

**Crop Doctor AI** bridges the gap between modern computer vision diagnostics and practical, low-cost agronomic intervention for smallholder farmers. 

The application enables farmers to photograph crop foliage, receive instant diagnostic classification, visualize affected lesion areas with contour overlays and Grad-CAM heatmaps, assess foliar damage, and retrieve affordable, verified treatment plans grounded in authoritative agricultural research.

### Target Crops Supported in Prototype
* 🍅 **Tomato** (*Solanum lycopersicum*): Early Blight, Late Blight, Bacterial Spot, Healthy
* 🥔 **Potato** (*Solanum tuberosum*): Early Blight, Late Blight, Healthy
* 🌽 **Corn / Maize** (*Zea mays*): Common Rust, Northern Corn Leaf Blight, Healthy

---

## 🚀 Key Features

### 1. Persistent 4-Tab Navigation Shell
* **Home Dashboard**: Morning greeting, personalized local statistics (Total Scans, Crops Monitored, Expert Reviews Required), hero diagnosis banner with "How It Works" bottom sheet, quick action buttons, pre-selectable crop cards, and recent activity feed.
* **Diagnose Workflow**: Interactive 3-step diagnosis (Step A: Select Crop, Step B: Photo/Gallery upload or Demonstration Leaf Picker, Step C: Progressive 5-stage AI analysis).
* **Analysis History**: Searchable, crop-filterable, status-filterable (Diseases vs Healthy), and date-sorted archive of all local diagnosis reports with single-record deletion and full-wipe confirmation modals.
* **Learn & Farmer Education**: Six expandable illustrated agronomic guides and an interactive "How Crop Doctor AI Works" architectural explanation.

### 2. Diagnosis Results & Diagnostic Report
* **Diagnostic Report Card**: Large clear disease title, scientific name, severity tier (Mild, Moderate, Severe, Healthy), foliar damage percentage, and animated circular confidence indicator.
* **Original vs. Highlighted Image Localization**: Interactive segmented control displaying original leaf photography alongside computer-vision lesion overlays with three modes:
  1. *Bounding Boxes*: Contours with label tags (`#1 Moderate 3.5%`)
  2. *Grad-CAM Heatmap*: Translucent radial heat signatures
  3. *Tissue Mask*: Binary foliar infection isolation
* **Confidence Safety Gate (70% Default)**:
  - Adjustable slider (50% to 95%) accessible directly from results or settings.
  - If `Confidence < Threshold`, the app triggers a prominent amber safety warning advising the farmer to collect dry leaves and contact a Krishi Vigyan Kendra (KVK) officer or call the **Kisan Call Center (1800-180-1551)** before purchasing costly chemicals.
  - Scores of exactly 70.0% against 70.0% threshold are safely accepted.

### 3. Local RAG Knowledge Retrieval System
* Dedicated **Treatment Plan** screen acting as a local retrieval-augmented agricultural assistant.
* Indexes verified references from:
  - **ICAR-IIVR** (Indian Institute of Vegetable Research)
  - **ICAR-CPRI** (Central Potato Research Institute)
  - **CIMMYT** (International Maize and Wheat Improvement Center)
  - **FAO IPM** (Food and Agriculture Organization IPM Guidelines)
  - **Cornell University Cooperative Extension**
  - **Purdue University Extension**
  - **TNAU Agritech Portal**
* Categorized guidance:
  - *Understanding the Condition & Favorable Weather Drivers*
  - *What You Can Do Now* (Low-cost organic remedies: NSKE 5%, Baking Soda spray, Bordeaux mixture)
  - *Cultural Prevention & Hygiene* (Bottom canopy pruning, drip irrigation, crop rotation)
  - *Treatment Precautions* (Pesticide safety, pre-harvest intervals, pollinator safety)
  - *Interactive RAG Search Bar*: Type questions (e.g., "neem oil dosage", "canopy pruning") to retrieve matching citations instantly.

---

## 🎨 Design System

* **Primary Forest Green**: `#176B45`
* **Deep Forest Green**: `#104B35`
* **Bright Leaf Green**: `#65B96E`
* **Soft Mint Background**: `#E8F5EC`
* **Warm Off-White Surface**: `#F7F8F4`
* **Primary Text**: `#17251D`
* **Secondary Text**: `#68756D`
* **Warning Amber**: `#E9A23B`
* **Error Red**: `#D9534F`
* **Information Blue**: `#3F7FD5`
* **Typography**: Clean, accessible sans-serif typography powered by `GoogleFonts.inter`.

---

## 🔬 Architecture & Separation of Responsibilities

```
lib/
├── app/
│   ├── app.dart                   # MaterialApp.router configuration
│   ├── router.dart                # GoRouter with StatefulShellRoute (4 tabs + sub-routes)
│   └── theme.dart                 # Custom Material 3 theme & color tokens
├── core/
│   ├── constants/
│   │   ├── app_colors.dart        # Strict brand palette
│   │   └── app_constants.dart     # Thresholds, hotline numbers, disclaimers
│   └── widgets/
│       ├── app_scaffold.dart      # Persistent bottom navigation bar
│       ├── confidence_indicator.dart # Circular animated percentage indicator
│       ├── custom_badge.dart      # Standardized status tags
│       └── leaf_canvas_overlay.dart # Bounding boxes, Grad-CAM, & tissue mask painter
├── models/
│   ├── agricultural_reference.dart # Source metadata & keyword document model
│   ├── crop.dart                  # Host plant definition
│   ├── diagnosis_result.dart      # Full diagnostic report model (JSON serializable)
│   ├── disease.dart               # Agronomic disease profile
│   ├── lesion_box.dart            # Relative coordinates (0.0 - 1.0) for bounding boxes
│   └── treatment_recommendation.dart # Structured remedy item
├── data/
│   ├── mock/                      # Mock crops, diseases, leaf samples, & references
│   └── repositories/
│       ├── history_repository.dart # Riverpod 3 Notifier for saved history & stats
│       └── settings_repository.dart# Riverpod 3 Notifier for confidence threshold
├── services/
│   ├── diagnosis/
│   │   ├── crop_diagnosis_service.dart      # Abstract diagnosis interface
│   │   └── demo_crop_diagnosis_service.dart # Deterministic mock inference engine
│   ├── knowledge_retrieval/
│   │   └── knowledge_retrieval_service.dart # Keyword-scored RAG document retrieval
│   └── persistence/
│       └── local_storage_service.dart       # SharedPreferences persistence layer
└── features/
    ├── home/                      # Screen 1: Dashboard, stats, hero banner, quick actions
    ├── diagnosis/                 # Screen 2: Crop selection, photo capture, sample picker
    ├── results/                   # Screen 3: Leaf Analysis Report, overlays, safety gates
    ├── treatment/                 # Screen 4: Treatment Plan, RAG query assistant, citations
    ├── history/                   # Screen 5: History archive, filters, search, delete
    ├── disease_library/           # Screen 6: Symptom catalog & detailed disease guides
    ├── learn/                     # Screen 7: Farmer education modules & How It Works
    └── settings/                  # Screen 8: Confidence threshold slider & privacy info
```

---

## ⚖️ Simulation vs Genuine Implementation Disclosure

> [!IMPORTANT]
> **Prototype Demonstration Notice**:
> This application is currently operating in **Deterministic Demo Simulation Mode**.
> 
> * **Simulated**: The disease classifications, confidence percentages, and lesion coordinates are generated deterministically based on the selected crop and photo hash / bundled demonstration scenarios.
> * **Implemented & Fully Functional**: The complete UI/UX flow, Riverpod 3 state management, GoRouter navigation, camera/gallery picker, custom canvas bounding-box transformations, Grad-CAM shaders, local SharedPreferences persistence, 70% threshold gating safety warnings, RAG document search, and native sharing are genuine, production-grade Flutter code.
> * **Backend Swap Ready**: The `CropDiagnosisService` interface can be swapped directly with a live HTTP/gRPC service (e.g., FastAPI running a YOLOv8-cls or EfficientNet model) without modifying any presentation widgets.

---

## 🧪 Testing & Quality Assurance

The project includes an automated test suite verifying all critical business and safety logic:

```bash
flutter test
```

### Test Suite Coverage:
1. **Confidence Threshold Safety**:
   - Default threshold set to 70.0%.
   - Exactly 70.0% against 70.0% threshold is NOT classified as below threshold.
   - 69.9% is correctly flagged as low confidence.
   - User threshold adjustments (e.g., 85% or 50%) dynamically update safety classification.
2. **RAG Knowledge Retrieval**:
   - Verifies all mock diseases map to verified agricultural citations.
   - Verifies multi-keyword searches ("neem", "copper", "bordeaux") return appropriate ICAR/Cornell documents.
   - Verifies crop filtering restricts unrelated documents.
3. **Data Serialization**:
   - Full round-trip testing of `DiagnosisResult.toJson()` and `DiagnosisResult.fromJson()` including lesion coordinate boxes.
4. **Local Persistence**:
   - Tests saving, retrieving, deleting individual records, clearing all history, and seeding demo history via mock SharedPreferences.
5. **Widget Smoke & Tab Navigation**:
   - Verifies dashboard rendering, header titles, quick actions, and tab navigation into the Learn hub.

---

## 🏃 Running the Application

### Prerequisites
- Flutter SDK 3.24+ (Dart 3.5+)
- An Android device, iOS simulator, or desktop/Chrome environment.

### Run Commands
```bash
# 1. Fetch dependencies
flutter pub get

# 2. Run static analysis (0 errors, 0 warnings)
flutter analyze

# 3. Run test suite
flutter test

# 4. Launch application
flutter run
```

---

## 📞 Agricultural Extension Helplines
* **Kisan Call Center (India)**: `1800-180-1551` (Toll-Free, 6:00 AM – 10:00 PM)
* **Local Agricultural Extension**: Contact your nearest Block Agriculture Officer or Krishi Vigyan Kendra (KVK) for laboratory fungal scrapings and soil pH analysis.
