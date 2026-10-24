import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/repositories/history_repository.dart';
import '../../../models/diagnosis_result.dart';
import '../widgets/history_card.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCrop = 'all'; // 'all', 'tomato', 'potato', 'corn'
  String _conditionFilter = 'all'; // 'all', 'disease', 'healthy'
  bool _sortNewestFirst = true;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _confirmDeleteSingle(DiagnosisResult result) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Diagnosis Record?'),
        content: Text(
          'Are you sure you want to delete the saved report for "${result.diseaseName}"?\n\n'
          'This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.errorRed),
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(historyListProvider.notifier).deleteResult(result.id);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Record deleted.')),
              );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _confirmClearAll() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear All Diagnosis History?'),
        content: const Text(
          'This will permanently remove all stored diagnosis records and demonstration history from local device storage.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.errorRed),
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(historyListProvider.notifier).clearAll();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('All history records cleared.')),
              );
            },
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final rawHistory = ref.watch(historyListProvider);

    // Apply filters
    var filtered = rawHistory.where((item) {
      if (_selectedCrop != 'all' && item.cropId.toLowerCase() != _selectedCrop) {
        return false;
      }
      if (_conditionFilter == 'healthy' && !item.diseaseName.toLowerCase().contains('healthy')) {
        return false;
      }
      if (_conditionFilter == 'disease' && item.diseaseName.toLowerCase().contains('healthy')) {
        return false;
      }
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final matchCrop = item.cropName.toLowerCase().contains(q);
        final matchDisease = item.diseaseName.toLowerCase().contains(q);
        final matchSci = item.scientificName.toLowerCase().contains(q);
        return matchCrop || matchDisease || matchSci;
      }
      return true;
    }).toList();

    // Sort
    filtered.sort((a, b) {
      return _sortNewestFirst
          ? b.analyzedAt.compareTo(a.analyzedAt)
          : a.analyzedAt.compareTo(b.analyzedAt);
    });

    return Scaffold(
      backgroundColor: AppColors.warmOffWhite,
      appBar: AppBar(
        backgroundColor: AppColors.warmOffWhite,
        elevation: 0,
        title: const Text(
          'Analysis History',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: AppColors.primaryText,
          ),
        ),
        actions: [
          if (rawHistory.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep_outlined, color: AppColors.errorRed),
              tooltip: 'Clear History',
              onPressed: _confirmClearAll,
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Search & Filter header
          Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            color: AppColors.warmOffWhite,
            child: Column(
              children: [
                // Search bar
                TextField(
                  controller: _searchController,
                  style: const TextStyle(fontSize: 13),
                  decoration: InputDecoration(
                    hintText: 'Search by crop or disease name...',
                    hintStyle: const TextStyle(fontSize: 12, color: AppColors.mutedText),
                    prefixIcon: const Icon(Icons.search, size: 20, color: AppColors.secondaryText),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: AppColors.subtleBorder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: AppColors.subtleBorder),
                    ),
                  ),
                  onChanged: (val) => setState(() => _searchQuery = val.trim()),
                ),
                const SizedBox(height: 10),

                // Crop Filter Chips & Sort
                Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildFilterChip('All Crops', 'all'),
                            const SizedBox(width: 6),
                            _buildFilterChip('🍅 Tomato', 'tomato'),
                            const SizedBox(width: 6),
                            _buildFilterChip('🥔 Potato', 'potato'),
                            const SizedBox(width: 6),
                            _buildFilterChip('🌽 Corn', 'corn'),
                            const SizedBox(width: 8),
                            Container(width: 1, height: 20, color: AppColors.subtleBorder),
                            const SizedBox(width: 8),
                            _buildConditionChip('All Status', 'all'),
                            const SizedBox(width: 6),
                            _buildConditionChip('Diseases', 'disease'),
                            const SizedBox(width: 6),
                            _buildConditionChip('Healthy', 'healthy'),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _sortNewestFirst ? Icons.arrow_downward : Icons.arrow_upward,
                        size: 18,
                        color: AppColors.primaryForestGreen,
                      ),
                      tooltip: _sortNewestFirst ? 'Newest First' : 'Oldest First',
                      onPressed: () => setState(() => _sortNewestFirst = !_sortNewestFirst),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // History records list
          Expanded(
            child: filtered.isEmpty
                ? _buildEmptyState(rawHistory.isEmpty)
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemCount: filtered.length,
                    separatorBuilder: (ctx, i) => const SizedBox(height: 10),
                    itemBuilder: (ctx, index) {
                      final item = filtered[index];
                      return HistoryCard(
                        result: item,
                        onTap: () {
                          context.push('/results', extra: item);
                        },
                        onDelete: () => _confirmDeleteSingle(item),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedCrop == value;
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          color: isSelected ? Colors.white : AppColors.primaryText,
        ),
      ),
      selected: isSelected,
      selectedColor: AppColors.primaryForestGreen,
      backgroundColor: Colors.white,
      onSelected: (val) {
        if (val) setState(() => _selectedCrop = value);
      },
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildConditionChip(String label, String value) {
    final isSelected = _conditionFilter == value;
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          color: isSelected ? Colors.white : AppColors.primaryText,
        ),
      ),
      selected: isSelected,
      selectedColor: AppColors.primaryForestGreen,
      backgroundColor: Colors.white,
      onSelected: (val) {
        if (val) setState(() => _conditionFilter = value);
      },
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildEmptyState(bool isCompletelyEmpty) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 68,
              height: 68,
              decoration: BoxDecoration(
                color: AppColors.softMint,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.history_toggle_off_rounded,
                color: AppColors.primaryForestGreen,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isCompletelyEmpty ? 'No Analysis History' : 'No Matching Records',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryText,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              isCompletelyEmpty
                  ? 'All leaf analyses you perform and save will be archived here for follow-up scouting.'
                  : 'Try clearing your search query or crop filter to view other saved diagnoses.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: AppColors.secondaryText),
            ),
            if (isCompletelyEmpty) ...[
              const SizedBox(height: 18),
              ElevatedButton.icon(
                onPressed: () => context.go('/diagnose'),
                icon: const Icon(Icons.camera_alt, size: 16),
                label: const Text('Diagnose a Crop'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
