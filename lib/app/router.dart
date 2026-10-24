import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/widgets/app_scaffold.dart';
import '../data/mock/mock_diseases.dart';
import '../data/mock/mock_leaf_samples.dart';
import '../features/diagnosis/screens/diagnosis_screen.dart';
import '../features/disease_library/screens/disease_detail_screen.dart';
import '../features/disease_library/screens/disease_library_screen.dart';
import '../features/history/screens/history_screen.dart';
import '../features/home/screens/home_screen.dart';
import '../features/learn/screens/how_it_works_screen.dart';
import '../features/learn/screens/learn_screen.dart';
import '../features/results/screens/diagnosis_results_screen.dart';
import '../features/settings/screens/settings_screen.dart';
import '../features/treatment/screens/treatment_plan_screen.dart';
import '../models/diagnosis_result.dart';
import '../models/disease.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    // Bottom Navigation Stateful Shell
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return AppScaffold(navigationShell: navigationShell);
      },
      branches: [
        // Tab 0: Home
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomeScreen(),
              ),
            ),
          ],
        ),

        // Tab 1: Diagnose
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/diagnose',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: DiagnosisScreen(),
              ),
            ),
          ],
        ),

        // Tab 2: History
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/history',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HistoryScreen(),
              ),
            ),
          ],
        ),

        // Tab 3: Learn
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/learn',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: LearnScreen(),
              ),
            ),
          ],
        ),
      ],
    ),

    // Sub-screens pushed on top of root navigator
    GoRoute(
      path: '/results',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final result = state.extra as DiagnosisResult? ?? _createFallbackResult();
        return DiagnosisResultsScreen(result: result);
      },
    ),
    GoRoute(
      path: '/treatment-plan',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final result = state.extra as DiagnosisResult? ?? _createFallbackResult();
        return TreatmentPlanScreen(result: result);
      },
    ),
    GoRoute(
      path: '/treatment-guide',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final result = _createFallbackResult();
        return TreatmentPlanScreen(result: result);
      },
    ),
    GoRoute(
      path: '/disease-library',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const DiseaseLibraryScreen(),
    ),
    GoRoute(
      path: '/disease-detail',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final disease = state.extra as Disease? ?? MockDiseases.diseases.first;
        return DiseaseDetailScreen(disease: disease);
      },
    ),
    GoRoute(
      path: '/how-it-works',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const HowItWorksScreen(),
    ),
    GoRoute(
      path: '/settings',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);

DiagnosisResult _createFallbackResult() {
  final sample = MockLeafSamples.samples.first;
  final d = MockDiseases.getById(sample.diseaseId);
  return DiagnosisResult(
    id: 'demo_fallback',
    cropId: 'tomato',
    cropName: 'Tomato',
    diseaseId: d.id,
    diseaseName: d.name,
    scientificName: d.scientificName,
    confidence: sample.confidence,
    severityTier: sample.severityTier,
    foliarDamagePct: sample.foliarDamagePct,
    analyzedAt: DateTime.now(),
    sampleKey: sample.key,
    lesions: sample.lesions,
    inferenceMode: 'Demo Simulation (Deterministic)',
    isDemo: true,
    disclaimer: 'Demonstration result. This prediction has not been verified by a trained diagnostic model.',
    isLowConfidence: sample.confidence < 70.0,
    isSaved: false,
    overview: d.overview,
    favorableConditions: d.favorableConditions,
    symptoms: d.symptoms,
    possibleCauses: d.possibleCauses,
    immediateRemedies: d.lowCostRemedies,
    culturalPrevention: d.culturalPractices,
    extensionProtocol: d.extensionProtocol,
    primarySource: 'ICAR-IIVR Extension Advisory',
  );
}
