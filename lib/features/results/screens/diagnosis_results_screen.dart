import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/custom_badge.dart';
import '../../../data/mock/mock_references.dart';
import '../../../data/repositories/history_repository.dart';
import '../../../data/repositories/settings_repository.dart';
import '../../../models/diagnosis_result.dart';
import '../widgets/confidence_slider_sheet.dart';
import '../widgets/localization_viewer.dart';
import '../widgets/main_diagnosis_card.dart';
import '../widgets/symptoms_causes_card.dart';

class DiagnosisResultsScreen extends ConsumerStatefulWidget {
  final DiagnosisResult result;

  const DiagnosisResultsScreen({
    super.key,
    required this.result,
  });

  @override
  ConsumerState<DiagnosisResultsScreen> createState() => _DiagnosisResultsScreenState();
}

class _DiagnosisResultsScreenState extends ConsumerState<DiagnosisResultsScreen> {
  late bool _isSaved;

  @override
  void initState() {
    super.initState();
    _isSaved = widget.result.isSaved;
  }

  void _handleSave(DiagnosisResult currentResult) async {
    await ref.read(historyListProvider.notifier).saveResult(currentResult);
    setState(() => _isSaved = true);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text('Diagnosis report saved to History.'),
            ],
          ),
          backgroundColor: AppColors.primaryForestGreen,
        ),
      );
    }
  }

  void _handleShare(DiagnosisResult currentResult) async {
    final text = '''
Crop Doctor AI Diagnosis Report
Crop: ${currentResult.cropName}
Condition: ${currentResult.diseaseName} (${currentResult.scientificName})
Confidence: ${currentResult.confidence.toStringAsFixed(1)}%
Severity: ${currentResult.severityTier}
Foliar Damage: ${currentResult.foliarDamagePct.toStringAsFixed(1)}%
Date: ${DateFormat('yyyy-MM-dd HH:mm').format(currentResult.analyzedAt)}

Immediate Remedies:
${currentResult.immediateRemedies.map((r) => '• $r').join('\n')}

Extension Protocol:
${currentResult.extensionProtocol}

Notice: ${AppConstants.demoNoticeFull}
Kisan Helpline: ${AppConstants.kisanCallCenterTollFree}
''';

    try {
      await SharePlus.instance.share(
        ShareParams(text: text, subject: 'Crop Doctor AI Report - ${currentResult.cropName}'),
      );
    } catch (_) {
      await Clipboard.setData(ClipboardData(text: text));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Report copied to clipboard!'),
            backgroundColor: AppColors.primaryForestGreen,
          ),
        );
      }
    }
  }

  void _showAgriculturalSourcesSheet(BuildContext context, DiagnosisResult result) {
    final refs = MockReferences.getReferencesForDisease(result.diseaseId);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.softMint,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.verified_outlined,
                    color: AppColors.primaryForestGreen,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Agricultural References',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryText,
                        ),
                      ),
                      Text(
                        'Authoritative research & extension publications',
                        style: TextStyle(fontSize: 11, color: AppColors.secondaryText),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (refs.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Standard KVK IPM Advisory guidelines apply to this sample.'),
              )
            else
              ...refs.map((r) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.warmOffWhite,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.subtleBorder),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CustomBadge(
                              text: 'Verified Institution',
                              icon: Icons.check_circle,
                              variant: BadgeVariant.success,
                              isSmall: true,
                            ),
                            const Spacer(),
                            Text(
                              r.publicationDate,
                              style: const TextStyle(fontSize: 11, color: AppColors.mutedText),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          r.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                            color: AppColors.primaryText,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          r.organization,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryForestGreen,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          r.content,
                          style: const TextStyle(fontSize: 11, color: AppColors.secondaryText, height: 1.35),
                        ),
                      ],
                    ),
                  )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentThreshold = ref.watch(confidenceThresholdProvider);
    final result = widget.result;
    final isLowConfidence = result.confidence < currentThreshold;
    final dateFormat = DateFormat('MMM d, yyyy • h:mm a');

    return Scaffold(
      backgroundColor: AppColors.warmOffWhite,
      appBar: AppBar(
        backgroundColor: AppColors.warmOffWhite,
        elevation: 0,
        title: const Text(
          'Leaf Analysis Report',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: AppColors.primaryText,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isSaved ? Icons.bookmark : Icons.bookmark_border,
              color: AppColors.primaryForestGreen,
            ),
            tooltip: _isSaved ? 'Saved' : 'Save Report',
            onPressed: () => _handleSave(result),
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined, color: AppColors.primaryForestGreen),
            tooltip: 'Share Report',
            onPressed: () => _handleShare(result),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Metadata header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateFormat.format(result.analyzedAt),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryText,
                  ),
                ),
                const CustomBadge(
                  text: 'DEMO MODE',
                  icon: Icons.science,
                  variant: BadgeVariant.demo,
                  isSmall: true,
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Low-Confidence Warning Banner (Safety rule: confidence < threshold)
            if (isLowConfidence)
              Container(
                margin: const EdgeInsets.only(bottom: 14),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.warningAmberLight,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: AppColors.warningAmber),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.warning_rounded, color: AppColors.warningAmberDark, size: 22),
                        SizedBox(width: 8),
                        Text(
                          'Low-Confidence Result',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: Color(0xFF78350F),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Model confidence (${result.confidence.toStringAsFixed(1)}%) is below your safety threshold (${currentThreshold.toInt()}%).\n'
                      '${AppConstants.lowConfidenceWarning}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF78350F),
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.phone_in_talk, size: 14, color: AppColors.primaryForestGreen),
                          SizedBox(width: 6),
                          Text(
                            'Kisan Call Center: 1800-180-1551 (Toll-Free)',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryForestGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Main Diagnosis Card
            MainDiagnosisCard(
              result: result,
              currentThreshold: currentThreshold,
              onOpenThresholdSlider: () => ConfidenceSliderSheet.show(context),
            ),
            const SizedBox(height: 16),

            // Image Localization Viewer (Original / Highlighted)
            LocalizationViewer(result: result),
            const SizedBox(height: 16),

            // Symptoms and Causes Information
            SymptomsCausesCard(result: result),
            const SizedBox(height: 20),

            // Primary Action Buttons
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.push('/treatment-plan', extra: result);
                },
                icon: const Icon(Icons.menu_book_rounded, size: 20),
                label: const Text(
                  'View Treatment Plan & RAG Guidance',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showAgriculturalSourcesSheet(context, result),
                    icon: const Icon(Icons.source_outlined, size: 16),
                    label: const Text('Sources', style: TextStyle(fontSize: 13)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      context.go('/diagnose');
                    },
                    icon: const Icon(Icons.refresh_rounded, size: 16),
                    label: const Text('New Scan', style: TextStyle(fontSize: 13)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}
