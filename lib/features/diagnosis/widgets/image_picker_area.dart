import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/mock/mock_leaf_samples.dart';

class ImagePickerArea extends StatelessWidget {
  final String? imagePath;
  final String? sampleKey;
  final ValueChanged<String> onImageSelected;
  final VoidCallback onSamplePickerTap;
  final VoidCallback onRemoveImage;

  const ImagePickerArea({
    super.key,
    this.imagePath,
    this.sampleKey,
    required this.onImageSelected,
    required this.onSamplePickerTap,
    required this.onRemoveImage,
  });

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 88,
      );

      if (pickedFile != null) {
        onImageSelected(pickedFile.path);
      }
    } catch (e) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.info_outline, color: AppColors.primaryForestGreen),
                SizedBox(width: 8),
                Text('Camera / Gallery Access'),
              ],
            ),
            content: Text(
              'Could not access the requested image source: $e\n\n'
              'You can still test all AI diagnostic features using our high-fidelity bundled demonstration leaves.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  onSamplePickerTap();
                },
                child: const Text('Try Sample Leaf'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasRealImage = imagePath != null &&
        imagePath!.isNotEmpty &&
        File(imagePath!).existsSync();
    final hasSample = sampleKey != null && sampleKey!.isNotEmpty;

    if (hasRealImage) {
      return _buildImagePreview(File(imagePath!));
    } else if (hasSample) {
      final sample = MockLeafSamples.getByKey(sampleKey!);
      return _buildSamplePreview(sample);
    }

    return _buildEmptyUploadArea(context);
  }

  Widget _buildEmptyUploadArea(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.subtleBorder,
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.softMint,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add_a_photo_outlined,
              size: 30,
              color: AppColors.primaryForestGreen,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Upload a leaf photograph',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryText,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'For better results, photograph a single leaf in natural light.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _pickImage(context, ImageSource.camera),
                  icon: const Icon(Icons.camera_alt, size: 16),
                  label: const Text('Take Photo', style: TextStyle(fontSize: 13)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _pickImage(context, ImageSource.gallery),
                  icon: const Icon(Icons.photo_library, size: 16),
                  label: const Text('Gallery', style: TextStyle(fontSize: 13)),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          TextButton.icon(
            onPressed: onSamplePickerTap,
            icon: const Icon(Icons.science_outlined, size: 15),
            label: const Text(
              'Or Try a Sample Demonstration Leaf',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryForestGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePreview(File file) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.subtleBorder, width: 1),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 260),
              child: Image.file(
                file,
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: onSamplePickerTap,
                icon: const Icon(Icons.sync_rounded, size: 16),
                label: const Text('Change Photo'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primaryForestGreen,
                ),
              ),
              OutlinedButton.icon(
                onPressed: onRemoveImage,
                icon: const Icon(Icons.delete_outline, size: 16, color: AppColors.errorRed),
                label: const Text(
                  'Remove',
                  style: TextStyle(color: AppColors.errorRed),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.errorRedLight),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSamplePreview(LeafSample sample) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.brightLeafGreen, width: 1.5),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.softMint,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.eco, color: sample.leafBaseColor, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sample Leaf Selected',
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.primaryForestGreen,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      sample.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: AppColors.primaryText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            sample.previewDescription,
            style: const TextStyle(fontSize: 12, color: AppColors.secondaryText),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: onSamplePickerTap,
                icon: const Icon(Icons.swap_horiz, size: 16),
                label: const Text('Switch Sample Leaf'),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primaryForestGreen,
                ),
              ),
              OutlinedButton.icon(
                onPressed: onRemoveImage,
                icon: const Icon(Icons.close, size: 16, color: AppColors.secondaryText),
                label: const Text(
                  'Clear',
                  style: TextStyle(color: AppColors.secondaryText),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.subtleBorder),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
