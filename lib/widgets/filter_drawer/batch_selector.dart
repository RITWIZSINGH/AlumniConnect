// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import '../../constants/filter_constant.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class BatchSelector extends StatelessWidget {
  final int? selectedBatch;
  final Function(int?) onBatchSelected;

  const BatchSelector({
    Key? key,
    required this.selectedBatch,
    required this.onBatchSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        title: const Text('BATCH', style: AppTypography.sectionTitle),
        backgroundColor: AppColors.background,
        collapsedBackgroundColor: AppColors.background,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int>(
                  value: selectedBatch,
                  hint: Text(
                    'Select Batch',
                    style: AppTypography.listItem.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  isExpanded: true,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  borderRadius: BorderRadius.circular(8),
                  icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
                  items: FilterConstants.batchYears.map((int year) {
                    return DropdownMenuItem<int>(
                      value: year,
                      child: Text(
                        year.toString(),
                        style: AppTypography.listItem,
                      ),
                    );
                  }).toList(),
                  onChanged: onBatchSelected,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}