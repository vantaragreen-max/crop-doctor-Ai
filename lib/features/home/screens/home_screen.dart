import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_logo.dart';
import '../../../data/repositories/history_repository.dart';
import '../../../models/crop.dart';
import '../../../models/diagnosis_result.dart';
import '../../diagnosis/providers/diagnosis_provider.dart';
import '../widgets/dashboard_stats_row.dart';
import '../widgets/hero_banner.dart';
import '../widgets/how_it_works_sheet.dart';
import '../widgets/quick_actions_grid.dart';
import '../widgets/recent_activity_section.dart';
import '../widgets/supported_crops_row.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyList = ref.watch(historyListProvider);

    return Scaffold(
      backgroundColor: AppColors.warmOffWhite,
      appBar: AppBar(
        backgroundColor: AppColors.warmOffWhite,
        elevation: 0,
        title: Row(
          children: [
            const AppLogo(size: 34),
            const SizedBox(width: 10),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning, Farmer',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryText,
                  ),
                ),
                Text(
                  "Let's keep your crops healthy today.",
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.secondaryText,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune_rounded, color: AppColors.primaryForestGreen),
            tooltip: 'App Settings & Threshold',
            onPressed: () => context.push('/settings'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(historyListProvider.notifier).reload();
        },
        color: AppColors.primaryForestGreen,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Banner
              HeroBanner(
                onScanLeaf: () {
                  context.go('/diagnose');
                },
                onHowItWorks: () {
                  HowItWorksSheet.show(context);
                },
              ),
              const SizedBox(height: 20),

              // Dashboard Statistics
              const DashboardStatsRow(),
              const SizedBox(height: 20),

              // Quick Actions
              QuickActionsGrid(
                onDiagnose: () {
                  context.go('/diagnose');
                },
                onDiseaseLibrary: () {
                  context.push('/disease-library');
                },
                onTreatmentGuide: () {
                  context.push('/treatment-guide');
                },
              ),
              const SizedBox(height: 20),

              // Supported Crops
              SupportedCropsRow(
                onSelectCrop: (Crop crop) {
                  ref.read(diagnosisWorkflowProvider.notifier).selectCrop(crop.id);
                  context.go('/diagnose');
                },
              ),
              const SizedBox(height: 20),

              // Recent Activity Section
              RecentActivitySection(
                recentItems: historyList,
                onViewReport: (DiagnosisResult result) {
                  context.push('/results', extra: result);
                },
                onStartScan: () {
                  context.go('/diagnose');
                },
                onViewAllHistory: () {
                  context.go('/history');
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
