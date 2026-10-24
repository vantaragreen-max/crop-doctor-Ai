import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/custom_badge.dart';
import '../../../data/mock/mock_references.dart';
import '../../../models/diagnosis_result.dart';
import '../../../services/knowledge_retrieval/knowledge_retrieval_service.dart';
import '../widgets/treatment_card.dart';

class TreatmentPlanScreen extends ConsumerStatefulWidget {
  final DiagnosisResult result;

  const TreatmentPlanScreen({
    super.key,
    required this.result,
  });

  @override
  ConsumerState<TreatmentPlanScreen> createState() => _TreatmentPlanScreenState();
}

class _TreatmentPlanScreenState extends ConsumerState<TreatmentPlanScreen> {
  final KnowledgeRetrievalService _retrievalService = KnowledgeRetrievalService();
  final TextEditingController _queryController = TextEditingController();
  List<RagSearchResult> _ragSearchResults = [];
  bool _hasSearched = false;

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  void _runQuery(String query) {
    if (query.trim().isEmpty) return;
    final results = _retrievalService.searchKnowledgeBase(
      query: query,
      cropId: widget.result.cropId,
      diseaseId: widget.result.diseaseId,
    );

    setState(() {
      _ragSearchResults = results;
      _hasSearched = true;
    });
  }

  Future<void> _openSourceUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showUrlFallback(url);
      }
    } catch (_) {
      _showUrlFallback(url);
    }
  }

  void _showUrlFallback(String url) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Agricultural Publication Link'),
        content: SelectableText(
          'Reference source document:\n$url\n\n'
          'Published by certified research extension portals (ICAR / CIMMYT / University Extension).',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final result = widget.result;
    final recommendations = _retrievalService.getTreatmentPlanForDisease(result.diseaseId);
    final references = MockReferences.getReferencesForDisease(result.diseaseId);

    return Scaffold(
      backgroundColor: AppColors.warmOffWhite,
      appBar: AppBar(
        backgroundColor: AppColors.warmOffWhite,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Agronomic Treatment Plan',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: AppColors.primaryText,
              ),
            ),
            Text(
              '${result.cropName} • ${result.diseaseName}',
              style: const TextStyle(fontSize: 11, color: AppColors.secondaryText),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // RAG Assistant Search Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.deepForestGreen, AppColors.primaryForestGreen],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.psychology, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Ask Agronomic RAG Assistant',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const CustomBadge(
                        text: 'ICAR / KVK Data',
                        variant: BadgeVariant.neutral,
                        isSmall: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Query local agricultural references for specific remedies, dosages, or hygiene rules.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.85),
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _queryController,
                          style: const TextStyle(fontSize: 13, color: AppColors.primaryText),
                          decoration: InputDecoration(
                            hintText: 'e.g. Can I spray neem oil or baking soda?',
                            hintStyle: const TextStyle(fontSize: 12, color: AppColors.mutedText),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onSubmitted: _runQuery,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () => _runQuery(_queryController.text),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.brightLeafGreen,
                          foregroundColor: AppColors.deepForestGreen,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Search', style: TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Quick suggested query chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildQuickQueryChip('Neem oil dosage'),
                        const SizedBox(width: 6),
                        _buildQuickQueryChip('Bordeaux mixture ratio'),
                        const SizedBox(width: 6),
                        _buildQuickQueryChip('Canopy pruning'),
                        const SizedBox(width: 6),
                        _buildQuickQueryChip('Crop rotation rules'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // RAG Search Results (if query executed)
            if (_hasSearched) ...[
              Row(
                children: [
                  const Icon(Icons.manage_search, size: 20, color: AppColors.primaryForestGreen),
                  const SizedBox(width: 6),
                  Text(
                    'Retrieved Knowledge Passages (${_ragSearchResults.length})',
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => setState(() {
                      _hasSearched = false;
                      _queryController.clear();
                    }),
                    child: const Text('Clear', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (_ragSearchResults.isEmpty)
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.subtleBorder),
                  ),
                  child: const Text(
                    'No direct keyword matches found. Please consult your local extension office or review standard recommendations below.',
                    style: TextStyle(fontSize: 12, color: AppColors.secondaryText),
                  ),
                )
              else
                ..._ragSearchResults.take(3).map((r) => Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: const Border(
                          left: BorderSide(color: AppColors.brightLeafGreen, width: 4),
                          top: BorderSide(color: AppColors.subtleBorder),
                          right: BorderSide(color: AppColors.subtleBorder),
                          bottom: BorderSide(color: AppColors.subtleBorder),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomBadge(
                                text: 'Match Score: ${r.relevanceScore.toInt()}%',
                                variant: BadgeVariant.success,
                                isSmall: true,
                              ),
                              const Spacer(),
                              Text(
                                r.reference.organization.split('(').first.trim(),
                                style: const TextStyle(fontSize: 10, color: AppColors.mutedText),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            r.reference.title,
                            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            r.matchedExcerpt,
                            style: const TextStyle(fontSize: 11, color: AppColors.primaryText, height: 1.4),
                          ),
                        ],
                      ),
                    )),
              const Divider(),
              const SizedBox(height: 10),
            ],

            // Section 1: Understanding the Disease
            _buildSectionHeader('Understanding the Condition', Icons.menu_book_rounded),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.subtleBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.overview,
                    style: const TextStyle(fontSize: 13, height: 1.45, color: AppColors.primaryText),
                  ),
                  const SizedBox(height: 10),
                  const Text('Favorable Weather Drivers:', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(
                    result.favorableConditions,
                    style: const TextStyle(fontSize: 11, color: AppColors.secondaryText, height: 1.35),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Section 2: What You Can Do Now (Low-Cost Smallholder Management)
            _buildSectionHeader('What You Can Do Now (Low-Cost Remedies)', Icons.healing_rounded),
            const SizedBox(height: 8),
            ...recommendations.map((rec) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TreatmentCard(recommendation: rec),
                )),
            const SizedBox(height: 14),

            // Section 3: Treatment Precautions & Safety
            _buildSectionHeader('Treatment Precautions & Safe Use', Icons.warning_amber_rounded),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.warningAmberLight.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.warningAmber),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.shield_outlined, color: AppColors.warningAmberDark, size: 18),
                      SizedBox(width: 8),
                      Text(
                        'Chemical Input Safety Guidelines',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          color: Color(0xFF78350F),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('• Do not apply unverified home chemical brews or high-toxicity pesticides without official extension prescription.', style: TextStyle(fontSize: 11, color: Color(0xFF78350F))),
                  SizedBox(height: 4),
                  Text('• Observe Pre-Harvest Intervals (PHI) strictly before picking edible produce.', style: TextStyle(fontSize: 11, color: Color(0xFF78350F))),
                  SizedBox(height: 4),
                  Text('• Spray solutions during calm morning or late evening hours to protect pollinator bees.', style: TextStyle(fontSize: 11, color: Color(0xFF78350F))),
                  SizedBox(height: 4),
                  Text('• Always wear protective gloves, boots, and face covering during any application.', style: TextStyle(fontSize: 11, color: Color(0xFF78350F))),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Section 4: Agricultural References & Citations
            _buildSectionHeader('Agricultural References & Citations', Icons.verified_user_rounded),
            const SizedBox(height: 8),
            ...references.map((ref) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: AppColors.subtleBorder),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const CustomBadge(
                            text: 'Verified Institution',
                            icon: Icons.check_circle_rounded,
                            variant: BadgeVariant.success,
                            isSmall: true,
                          ),
                          const Spacer(),
                          Text(
                            ref.publicationDate,
                            style: const TextStyle(fontSize: 11, color: AppColors.mutedText),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        ref.title,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        ref.organization,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryForestGreen,
                        ),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: () => _openSourceUrl(ref.sourceUrl),
                        child: Row(
                          children: [
                            const Icon(Icons.open_in_new, size: 14, color: AppColors.infoBlue),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                ref.sourceUrl,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.infoBlue,
                                  decoration: TextDecoration.underline,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 24),

            // Bottom Disclaimer
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF3C7),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Text(
                AppConstants.demoNoticeFull,
                style: TextStyle(fontSize: 11, color: Color(0xFF78350F), height: 1.3),
              ),
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primaryForestGreen),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickQueryChip(String text) {
    return InkWell(
      onTap: () {
        _queryController.text = text;
        _runQuery(text);
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
